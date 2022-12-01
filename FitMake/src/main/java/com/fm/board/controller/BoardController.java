package com.fm.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fm.board.service.BoardService;
import com.fm.user.model.UserDto;


public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService BoardService;
	
	@RequestMapping
	public String viewBoardList(HttpSession session, Model model) {
		
		String viewUrl = "";
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		List<Map<String, Object>> BoardMapList = BoardService.viewBoardList(uNo);
		
		
		
		
		
		model.addAttribute("BoardMapList", BoardMapList);
		
		viewUrl = "/inquiry/InquiryBoardList";
		
		return viewUrl;
	}
}
