package com.fm.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fm.board.dao.BoardDao;
import com.fm.board.model.BoardDto;
import com.fm.board.model.ReplyDto;

@Service
public class BoardServiceImp implements BoardService {
	
	@Autowired
	public BoardDao boardDao;

	@Override
	public List<Map<String, Object>> viewBoardList(int uNo, int start, int end) {
		
		return boardDao.viewBoardList(uNo, start, end);
	}

	@Override
	public int getBoardTotalCount(int uNo) {
		
		return boardDao.getBoardTotalCount(uNo);
	}

	@Override
	public Map<String, Object> viewBoardDetail(int uNo, int bNo) {
		
		return boardDao.viewBoardDetail(uNo, bNo);
	}

	@Override
	public int addBoardDetail(BoardDto boardDto) {
		
		return boardDao.addBoardDetail(boardDto);
	}

	@Override
	public int deleteBoardDetail(BoardDto boardDto) {
		
		return boardDao.deleteBoardDetail(boardDto);
	}

	@Override
	public List<Map<String, Object>> viewReplyList(ReplyDto replyDto) {
		
		return boardDao.viewReplyList(replyDto);
	}

	@Override
	public int addReply(ReplyDto replyDto) {
		
		return boardDao.addReply(replyDto);
	}
	
}
