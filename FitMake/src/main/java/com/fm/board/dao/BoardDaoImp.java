package com.fm.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.board.model.BoardDto;
import com.fm.board.model.ReplyDto;

@Repository
public class BoardDaoImp implements BoardDao{
	
	@Autowired
	SqlSessionTemplate sqlSession;

	String namespace = "com.fm.board.";

	@Override
	public List<Map<String, Object>> viewBoardList(int uNo, int start, int end) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("uNo", uNo);
		inputMap.put("start", start);
		inputMap.put("end", end);
		
		return sqlSession.selectList(namespace + "viewBoardList", inputMap);
	}

	@Override
	public int getBoardTotalCount(int uNo) {
		
		return sqlSession.selectOne(namespace + "getBoardTotalCount", uNo);
	}

	@Override
	public Map<String, Object> viewBoardDetail(int uNo, int bNo) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("uNo", uNo);
		inputMap.put("bNo", bNo);
		
		return sqlSession.selectOne(namespace + "viewBoardDetail", inputMap);
	}

	@Override
	public int addBoardDetail(BoardDto boardDto) {
		
		return sqlSession.insert(namespace + "addBoardDetail", boardDto);
	}

	@Override
	public int deleteBoardDetail(BoardDto boardDto) {
		
		return sqlSession.delete(namespace + "deleteBoardDetail", boardDto);
	}

	@Override
	public List<Map<String, Object>> viewReplyList(ReplyDto replyDto) {
		
		return sqlSession.selectList(namespace + "viewReplyList", replyDto);
	}
	
	@Override
	public int addReply(ReplyDto replyDto) {
		
		ReplyDto newReplyDto = new ReplyDto();
		
		newReplyDto = sqlSession.selectOne(namespace+ "getIrParentNo", replyDto);
		
		if(newReplyDto == null) {
			replyDto.setIrParentNo(0);
		} else {
			replyDto.setIrParentNo(newReplyDto.getIrParentNo());
		}
		
		return sqlSession.insert(namespace + "addReply", replyDto);
	}
	
	
}
