package com.fm.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fm.board.model.BoardDto;
import com.fm.board.model.ReplyDto;
import com.fm.board.service.BoardService;
import com.fm.user.model.UserDto;
import com.fm.util.Paging;

@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/inquiry/list.do", method = RequestMethod.GET)
	public String viewBoardList(HttpSession session, Model model, @RequestParam(defaultValue = "1") int curPage) {
		
		String viewUrl = "";
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		int totalCount = boardService.getBoardTotalCount(uNo);
		
		Paging igPaging = new Paging(totalCount, curPage);
		
		int start = igPaging.getPageBegin();
		int end = igPaging.getPageEnd();
		
		List<Map<String, Object>> BoardMapList = boardService.viewBoardList(uNo, start, end);
		
		
		Map<String, Object> igPagingMap = new HashMap<String, Object>();
		
		igPagingMap.put("igPaging", igPaging); 
		igPagingMap.put("totalCount",totalCount);
		igPagingMap.put("start", start);
		igPagingMap.put("end", end);
		
		model.addAttribute("BoardMapList", BoardMapList);
		model.addAttribute("igPagingMap", igPagingMap);
		
		viewUrl = "/inquiry/InquiryBoardList";
		
		return viewUrl;
	}
	
	@RequestMapping(value = "/inquiry/add.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String addBoardDetail(HttpSession session, BoardDto boardDto) {
		String viewUrl = "";
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		boardDto.setuNo(uNo);
		
		if(boardDto.getbTitle().equals("")) {
			viewUrl = "/inquiry/InquiryBoardAdd";
		} else {
			
			int result = boardService.addBoardDetail(boardDto);
			viewUrl = "redirect:./list.do";
			
		}
		
		return viewUrl;
	}
	
	@RequestMapping(value="/inquiry/detail.do", method = RequestMethod.GET)
	public String viewBoardDetail(HttpSession session, Model model, @RequestParam int bNo) {
		
		String viewUrl = "";
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		Map<String, Object> boardMap = boardService.viewBoardDetail(uNo, bNo);
		
		model.addAttribute("boardMap", boardMap);
		
		viewUrl = "/inquiry/InquiryBoardDetail";
		
		return viewUrl;
	}
	
	@RequestMapping(value="/inquiry/delete.do")
	public String deleteBoardDetail(HttpSession session, BoardDto boardDto) {
		
		String viewUrl = "";
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		boardDto.setuNo(uNo);
		
		int result = boardService.deleteBoardDetail(boardDto);
		
	
		viewUrl = "redirect:./list.do";
		
		return viewUrl;
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/add.do", method = RequestMethod.POST)
	public int addReply(HttpSession session, ReplyDto replyDto) {
		logger.debug("replyDto" + replyDto.getIrParentNo());
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		replyDto.setuNo(uNo);
		
		int result = boardService.addReply(replyDto);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/list.do", method = RequestMethod.POST)
	public List<Map<String, Object>> viewReplyList (HttpSession session, ReplyDto replyDto) {
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		replyDto.setuNo(uNo);
		
		List<Map<String, Object>> replyMapList = boardService.viewReplyList(replyDto);
		
		return replyMapList;
	}
	
}
