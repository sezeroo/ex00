package com.zerock.service;

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
public class BoardServiceTests {

	@Autowired
	private BoardService service ;
	
	
	@Test
	public void testRegister() {
			
		BoardVO board = new BoardVO();
		board.setTitle("작성 테스트");
		board.setContent("작성테스트중입니다.");
		board.setWriter("sezero");
		
		service.register(board);
		
	}
	
	
}
