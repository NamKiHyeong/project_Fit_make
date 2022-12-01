package com.fm.board.dao;

import java.util.List;
import java.util.Map;

public interface BoardDao {

	List<Map<String, Object>> viewBoardList(int uNo);

}
