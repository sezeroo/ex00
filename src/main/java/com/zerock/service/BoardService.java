package com.zerock.service;

import java.util.List;

import com.zerock.domain.BoardAttachVO;
import com.zerock.domain.BoardVO;
import com.zerock.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public int remove(long bno);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotal(Criteria cri);

	public List<BoardAttachVO> getAttachList(long bno);
	
}
