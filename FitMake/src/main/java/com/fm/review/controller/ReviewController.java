package com.fm.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String reviewAdd(int cNo, Model model) {
		logger.info("리플을 달아보자", model);
		
		model.addAttribute("cNo", cNo);
		return "/review/ReviewAdd";
	}
	
	@RequestMapping(value="/review/addCtr.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewAddCtr(ReviewDto reviewDto, Model model, MultipartHttpServletRequest mulRequest) {
		logger.info("리플을 작성합니다." + reviewDto);
		try {
			reviewService.reviewInsert(reviewDto, mulRequest);
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("예외 발생");
			e.printStackTrace();
		}
		
//		return "redirect:/item/list.do?cNo=2";
		return "redirect:/review/list.do?cNo=1";
		
	}
	
/**
 * Read!!
 * @param cNo
 * @param model
 * @return
 */
	@RequestMapping(value="/review/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewSelectList(@RequestParam int cNo, Model model) {
//		logger.info("리플을 확인합니다.{}" ,reviewDto);
		logger.info("카테고리는?.{}" , cNo);
		
		List<Map<String, Object>> reviewList = reviewService.reviewSelectList(cNo);
		
		logger.info("카테고리는?.{}" , reviewList);
//		Map<String, Object> 
		
		Map<String, Object> pagingMap = new HashMap<>();
		
		pagingMap.put("cNo", cNo);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pagingMap", pagingMap);
		
		return "/review/ReviewList";
	}
}
