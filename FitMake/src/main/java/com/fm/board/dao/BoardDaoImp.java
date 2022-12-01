package com.fm.board.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class BoardDaoImp implements BoardDao{
	
	@Autowired
	SqlSessionTemplate sqlSession;

	String namespace = "com.fm.board.";

	@Override
	public List<Map<String, Object>> viewBoardList(int uNo) {
		
		return sqlSession.selectList(namespace + "viewBoardList", uNo);
	}
	
	
}
