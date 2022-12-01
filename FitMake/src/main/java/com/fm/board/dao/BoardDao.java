package com.fm.board.dao;

import java.util.List;
import java.util.Map;

import com.fm.board.model.BoardDto;
import com.fm.board.model.ReplyDto;

public interface BoardDao {

	List<Map<String, Object>> viewBoardList(int uNo, int start, int end);

	int getBoardTotalCount(int uNo);

	Map<String, Object> viewBoardDetail(int uNo, int bNo);

	int addBoardDetail(BoardDto boardDto);

	int deleteBoardDetail(BoardDto boardDto);

	List<Map<String, Object>> viewReplyList(ReplyDto replyDto);

	int addReply(ReplyDto replyDto);

}
