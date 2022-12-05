package com.fm.review.controller;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.review.model.ReviewDto;
import com.fm.review.service.ReviewService;
import com.fm.util.Paging;

@Controller
public class ReviewController {
	
	private static final Logger logger
		= LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewService reviewService;
	
/**
 * Create!!
 * @param cNo
 * @param model
 * @return
 */
	
	@RequestMapping(value="/review/add.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewAdd(@RequestParam(defaultValue = "0") int iNo, Model model) {
		logger.info("리플을 달아보자", model);
		
		logger.info("리플에 iNo 값이 들어옴? {}" + iNo);
		model.addAttribute("iNo", iNo);
		
		return "/review/ReviewAdd";
	}
	
	@RequestMapping(value="/review/addCtr.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewAddCtr(ReviewDto reviewDto, Model model, MultipartHttpServletRequest mulRequest) {
		logger.info("컨트롤에서 리플을 작성합니다1. {}" , reviewDto);
		
		try {
			reviewService.reviewInsert(reviewDto, mulRequest);
			
			logger.info("컨트롤에서 리플을 작성합니다2. {}" , reviewDto);
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("예외 발생");
			e.printStackTrace();
		}
			logger.info("컨트롤러에서 추가버튼을 눌렀을 때 list.do로 iNo 값을 쏴주나? {}" ,reviewDto.getiNo());
		return "redirect:/review/list.do?iNo=" + reviewDto.getiNo();
//		location.href="../review/list.do?iNo=" + iNo;
//		return "redirect:/item/list.do?cNo=" + itemDto.getcNo();
	}
	
/**
 * Read!!
 * @param cNo
 * @param model
 * @return
 */
	@RequestMapping(value="/review/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewSelectList(@RequestParam(defaultValue = "0") int iNo
			, @RequestParam(defaultValue = "1") int curPage
//			, @RequestParam(defaultValue = "") String keyword
			, Model model) {
		logger.info("리플리스트를 확인해 봅시다.{}" ,iNo);
		int totalReviewCount = reviewService.reviewSelectTotalReviewCount(iNo);
//		Map<String, Object> totalReviewCount = reviewService.reviewSelectTotalReviewCount(iNo);
//		int totalReviewCount = reviewService.reviewSelectTotalReviewCount(iNo, keyword);
		Paging reviewPaging = new Paging(totalReviewCount, curPage);
//		Paging reviewPaging = new Paging(totalReviewCount);
		int start = reviewPaging.getPageBegin();
		int end = reviewPaging.getPageEnd();
		List<Map<String, Object>> reviewList = reviewService.reviewSelectList(iNo, start, end);
//		List<Map<String, Object>> reviewList = reviewService.reviewSelectList(iNo, keyword, start, end);
//		List<Map<String, Object>> reviewList = reviewService.reviewSelectList(iNo);
		logger.info("리뷰리스트의 값이 잘 오나?? {}" + reviewList);
		Map<String, Object> searchMap = new HashMap<>();
//		searchMap.put("keyword", keyword);
		
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("iNo", iNo);
		pagingMap.put("reviewPaging", reviewPaging);
		pagingMap.put("totalItemCount", totalReviewCount);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pagingMap", pagingMap);
		model.addAttribute("searchMap", searchMap);
		
		return "/review/ReviewList";
	}
	//---------------------------------
	
//	@RequestMapping(value="/review/totalList.do", method = {RequestMethod.GET, RequestMethod.POST})
//	public String reviewSelectTotalList(@RequestParam(defaultValue = "1") int curPage
//			, Model model) {
//		int totalReviewCount = reviewService.reviewSelectTotalReviewCount2();
//		Paging reviewPaging = new Paging(totalReviewCount, curPage);
//		int start = reviewPaging.getPageBegin();
//		int end = reviewPaging.getPageEnd();
//		Map<String, Object> searchMap = new HashMap<>();
//		
//		Map<String, Object> pagingMap = new HashMap<>();
//		pagingMap.put("reviewPaging", reviewPaging);
//		pagingMap.put("totalItemCount", totalReviewCount);
//		
//		model.addAttribute("reviewList", reviewList);
//		model.addAttribute("pagingMap", pagingMap);
//		model.addAttribute("searchMap", searchMap);
//		
//		return "/review/ReviewList";
//	}
	
	
	
	//------------------------------------
	@RequestMapping(value="/review/one.do", method = RequestMethod.GET)
	public String reviewSelectOne(@RequestParam int iNo
			, @RequestParam int curPage
			, int rNo, Model model) {
		logger.info("컨트롤러 one에 원하는 정보 들어옴? {}", model);
		Map<String, Object>prevMap = new HashMap<String, Object>();
		prevMap.put("iNo", iNo);
		prevMap.put("curPage", curPage);
		
		Map<String, Object> map = reviewService.reviewSelectOne(rNo);
		
		logger.debug("컨트롤러 one에 원하는 정보를 서비스에서 갖고옴? {}" , map);
		ReviewDto reviewDto = (ReviewDto) map.get("reviewDto");
		logger.info("컨트롤러 one에 {}" , reviewDto);
		
		
		List<Map<String, Object>> fileList2 = (List<Map<String, Object>>)map.get("fileList2");
		logger.info("컨트롤러 one에 fileList2{}" , fileList2);
		
		model.addAttribute("reviewDto", reviewDto);
		model.addAttribute("fileList2", fileList2);
		model.addAttribute("prevMap", prevMap);
		
		return "/review/ReviewOne";
	}
	
	@RequestMapping(value="/review/update.do", method = RequestMethod.GET)
	public String reviewUpdate(int iNo
			, int curPage
			, int rNo, Model model) {
		logger.trace("수정하는 DB에 접속"+ iNo);
		
		Map<String, Object>prevMap = new HashMap<>();
		prevMap.put("iNo", iNo);
		prevMap.put("curPage", curPage);
		
		Map<String, Object> map = reviewService.reviewSelectOne(rNo);
		
		ReviewDto reviewDto = (ReviewDto)map.get("reviewDto");
		logger.info("컨트롤러에 ReviewDto가 들어왔나? {} 확인", reviewDto);
		List<Map<String, Object>> fileList2
		= (List<Map<String, Object>>) map.get("fileList2");
		
		System.out.println("update.do에서 " + rNo);
		
		model.addAttribute("reviewDto", reviewDto);
		model.addAttribute("prevMap", prevMap);
		if (fileList2.size() != 0) {
			model.addAttribute("img", fileList2.get(0));
		}
		
		return "review/ReviewUpdate";
	}
	
	@RequestMapping(value="/review/updateCtr.do", method = RequestMethod.POST)
	public String reviewUpdateCtr(HttpSession session
			, int curPage
			, ReviewDto reviewDto
			,@RequestParam(value = "fileIdx", defaultValue = "-1") int imgNo
			, MultipartHttpServletRequest mulRequest, Model model) {
//		logger.info("컨트롤러 서비스로 curPage {} " , curPage);
		logger.info("컨트롤러 서비스로 reviewDto {} " , reviewDto);
		logger.info("컨트롤러 서비스로 fileIdx {} " , imgNo);
		int iNo = reviewDto.getiNo();
		
		try {
			reviewService.reviewUpdateOne(reviewDto, mulRequest, imgNo);
			
		} catch (Exception e) {
			System.out.println("컨트롤 업데이트 예외 발생");
			e.printStackTrace();
		}
		return "redirect:/review/list.do?iNo=" + iNo;
	}
	
	@RequestMapping(value="/review/deleteOne.do", method = RequestMethod.GET)
	public String reviewDelete(int rNo,int iNo, Model model) {
		logger.info("삭제기능" + rNo);
			reviewService.reviewDeleteOne(rNo);
		logger.info("삭제기능");
		return "redirect:/review/list.do?iNo=" + iNo;
		
	}
}

