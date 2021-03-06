package com.zerock.service;

import java.util.List;

import com.zerock.domain.Criteria;
import com.zerock.domain.ReplyPageDTO;
import com.zerock.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(String reply,Long rno);


	public List<ReplyVO> getListWithPaging(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);	
}
