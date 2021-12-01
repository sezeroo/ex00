package com.zerock.service;

import com.zerock.domain.BoardAttachVO;
import com.zerock.domain.BoardVO;
import com.zerock.domain.Criteria;
import com.zerock.mapper.BoardAttachMapper;
import com.zerock.mapper.BoardMapper;
import com.zerock.mapper.ReplyMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class BoardSerivceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;

	@Autowired
	private BoardAttachMapper attachMapper;

	@Autowired
	private ReplyMapper replyMapper;
	 
	
	@Override
	public BoardVO get(Long bno) {

		
		return mapper.read(bno);
	}
	
	
	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {

		
		return mapper.getListWithPaging(cri);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {

		log.info("modify............" + board);
		
		attachMapper.deleteAll(board.getBno());

		boolean modifyResult = mapper.update(board)==1;

		if(modifyResult && board.getAttachList() != null && board.getAttachList().size()>0){

			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);

			});

		}

		return modifyResult;
	}

	@Transactional
	@Override
	public void register(BoardVO board) {
		
		log.info("register......... " + board);

		mapper.insertSelectKey(board);

		if(board.getAttachList() == null || board.getAttachList().size() <= 0 ){
			return;
		}

		board.getAttachList().forEach(attach-> {

			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Transactional
	@Override
	public int remove(long bno) {

		log.info("remove...." + bno);


		replyMapper.remove(bno);

		attachMapper.deleteAll(bno);

		return mapper.delete(bno);
	}
	
	@Override
	public int getTotal(Criteria cri) {

		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(long bno) {

		log.info("get Attach list by bno " + bno);

		return attachMapper.findByBno(bno);
	}


}
