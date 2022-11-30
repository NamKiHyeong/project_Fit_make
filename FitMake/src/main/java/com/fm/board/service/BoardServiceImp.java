package com.fm.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.fm.board.dao.BoardDao;

public class BoardServiceImp implements BoardService {
	
	@Autowired
	public BoardDao boardDao;

	@Override
	public List<Map<String, Object>> viewBoardList(int uNo) {
		
		return boardDao.viewBoardList(uNo);
	}
	
}
