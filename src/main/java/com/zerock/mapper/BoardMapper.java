package com.zerock.mapper;

import java.util.List;

import com.zerock.domain.BoardVO;
import com.zerock.domain.Criteria;
import org.apache.ibatis.annotations.Param;

public interface BoardMapper {
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete (Long bno);
	
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);

	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount")Long amount);

}
