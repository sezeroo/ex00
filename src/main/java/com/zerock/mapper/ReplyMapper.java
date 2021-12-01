package com.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zerock.domain.Criteria;
import com.zerock.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long bno);
	
	public int delete (String reply,Long rno);

	//게시물에 있는 댓글삭제하기.
	public int remove (Long bno);
	
	public int update (ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,
											@Param("bno") Long bno);
	
	public int getCountByBno(Long bno);
	
	
	
}
