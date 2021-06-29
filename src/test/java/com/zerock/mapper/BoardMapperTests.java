package com.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zerock.domain.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Autowired
	private BoardMapper mapper;
	
//	@Test
//	public void testGetList() {
//		
//		mapper.getList().forEach(board -> log.info(board));
//		
//		
//	}
	
//	@Test
//	public void testInsert() {
//		
//		BoardVO board = new BoardVO();
//		
//		board.setTitle("두번쨰 작성하는글");
//		board.setContent("두번쨰 작성하면서 복습합니다.");
//		board.setWriter("sezero");
//		
//		mapper.insertSelectKey(board);
//		
//		log.info(board);
//
//	
//	}
	

	
	
}

