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
	
	/**
	 * 문의게시판 리스트를 반환하는 기능
	 * @param session	세션에 저장된 회원번호를 구하기 위한 객체
	 * @param model		화면 구성을 위한 객체
	 * @param curPage	현재 페이지 정보
	 * @return
	 */
	@RequestMapping(value = "/inquiry/list.do", method = RequestMethod.GET)
	public String viewBoardList(HttpSession session, Model model, @RequestParam(defaultValue = "1") int curPage) {
		
		String viewUrl = "";
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		int totalCount = boardService.getBoardTotalCount(uNo);
		
		Paging iqPaging = new Paging(totalCount, curPage);
		
		int start = iqPaging.getPageBegin();
		int end = iqPaging.getPageEnd();
		
		List<Map<String, Object>> inquiryMapList = boardService.viewBoardList(uNo, start, end);
		
		
		Map<String, Object> iqPagingMap = new HashMap<String, Object>();
		
		iqPagingMap.put("iqPaging", iqPaging); 
		iqPagingMap.put("totalCount",totalCount);
		iqPagingMap.put("start", start);
		iqPagingMap.put("end", end);
		
		model.addAttribute("inquiryMapList", inquiryMapList);
		model.addAttribute("iqPagingMap", iqPagingMap);
		
		viewUrl = "/inquiry/InquiryBoardList";
		
		return viewUrl;
	}
	
	/**
	 * 문의게시판 작성을 위한 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param boardDto	작성된 내용을 DB에 전달하기 위한 객체
	 * @return	
	 */
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
	
	/**
	 * 문의게시판 내용을 보기 위한 기능 
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param model		화면구성을 위한 객체
	 * @param bNo		게시글번호
	 * @return
	 */
	@RequestMapping(value="/inquiry/detail.do", method = RequestMethod.GET)
	public String viewBoardDetail(HttpSession session, Model model, @RequestParam int bNo) {
		
		String viewUrl = "";
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		Map<String, Object> inquiryMap = boardService.viewBoardDetail(uNo, bNo);
		
		model.addAttribute("inquiryMap", inquiryMap);
		
		viewUrl = "/inquiry/InquiryBoardDetail";
		
		return viewUrl;
	}
	
	/**
	 * 게시판 글 삭제를 위한 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param boardDto	게시판 번호를 가져오기 위한 객체
	 * @return			
	 */
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
	
	/**
	 * 비동기 댓글 작성을 위한 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param replyDto	DB에 담을 내용을 가져오기 위한 객체
	 * @return			댓글 작성 성공 여부 1 성공 
	 */
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
	
	/**
	 * 비동기 댓글 리스트를 가져오기 위한 기능 
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param replyDto	댓글 내용 잡합을 가져오기 위한 객체
	 * @return			댓글 리스트를 반환
	 */
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
