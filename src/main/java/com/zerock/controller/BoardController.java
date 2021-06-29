package com.zerock.controller;

import com.zerock.domain.BoardAttachVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zerock.domain.BoardVO;
import com.zerock.domain.Criteria;
import com.zerock.domain.PageDTO;
import com.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
 @Log4j
 @RequestMapping("/board/*")
 @AllArgsConstructor
 public class BoardController {

	@Autowired
	private BoardService service;



	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list 호출 : " + cri);
		
		model.addAttribute("list",service.getListWithPaging(cri));
		model.addAttribute("pageMaker",new PageDTO(cri, service.getTotal(cri)));
		
	}
	
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
		
	}
	
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board,RedirectAttributes rttr) {
		
		log.info("register: " + board);

		if(board.getAttachList() != null){
			board.getAttachList().forEach(attach -> log.info(attach));
		}

		service.register(board);

		log.info("작성게시글 번호 : " + board.getBno());

		rttr.addFlashAttribute("result",board.getBno());
		
		
		return "redirect:/board/list";
		
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		
		
		log.info("get or modify");
		
		model.addAttribute("board",service.get(bno));
	}

	@PreAuthorize("principal.username==#board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		
		log.info("modify : " + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		
		
		return "redirect:/board/list";
	}

	@PreAuthorize("principal.username==#board.writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr
			,@ModelAttribute("cri")Criteria cri, String writer) {
		
		log.info("remove" + bno);

		List<BoardAttachVO> attachList = service.getAttachList(bno);

		if(service.remove(bno) > 0) {
			delteFiles(attachList);

			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
		
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){

		log.info("getAttachList " + bno);

		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}

	private void delteFiles(List<BoardAttachVO> attachList){

		if(attachList == null || attachList.size() <= 0 ){
			return;
		}

		log.info("delete attach files..........");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()
				+"_"+attach.getFileName());

				Files.deleteIfExists(file);

				if(Files.probeContentType(file).startsWith("image")) {

					Path thumbnail = Paths.get("c:\\upload\\" + attach.getUploadPath() + "\\s_" +
							attach.getUuid() + "_" + attach.getFileName());

					Files.deleteIfExists(thumbnail);
				}

			}catch (Exception e ){
				e.printStackTrace();
			}// end catch
		});// end each
	}
	
	
	
	
	

}
