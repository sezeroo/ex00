package com.zerock.service;

import java.util.List;

import com.zerock.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zerock.domain.Criteria;
import com.zerock.domain.ReplyPageDTO;
import com.zerock.domain.ReplyVO;
import com.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.transaction.annotation.Transactional;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{

		@Autowired
		private ReplyMapper mapper;

		@Autowired
		private BoardMapper boardmapper;
	
	@Override
	public List<ReplyVO> getListWithPaging(Criteria cri, Long bno) {

			log.info("getListWithPaging.....................");
		
		return mapper.getListWithPaging(cri, bno);
	}
	
	@Override
	public ReplyVO get(Long rno) {

		log.info("댓글 상세보기........");	
		
		return mapper.read(rno);
	}
	
	@Override
	public int modify(ReplyVO vo) {

		log.info("modify...........");
		log.info("ReplyServiceImpl..... modify 에서 확인하는 Description :" + vo.getDescription());

		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int register(ReplyVO vo) {

			log.info("댓글 입력........");

			boardmapper.updateReplyCnt(vo.getBno(),1L);

		return mapper.insert(vo);
	}

	@Transactional
	@Override
	public int remove(String reply,Long rno) {

		log.info("remove............");	

		ReplyVO vo = mapper.read(rno);


		boardmapper.updateReplyCnt(vo.getBno(),0L);

		return mapper.delete(reply,rno);
	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {

		
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
		
	}
	
	
	
	
}
