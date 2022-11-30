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
		
//		return "redirect:/item/list.do?cNo=2";
		return "redirect:/reivew/list.do?cNo=1";
		
	}
	
/**
 * Read!!
 * @param cNo
 * @param model
 * @return
 */
	@RequestMapping(value="/review/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewSelectList(@RequestParam(defaultValue = "0") int iNo, Model model) {
		logger.info("리플리스트를 확인해 봅시다.{}" ,iNo);
		
		List<Map<String, Object>> reviewList = reviewService.reviewSelectList(iNo);
		
		logger.info("리뷰리스트의 값이 잘 오나?? {}" + reviewList);
		
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("iNo", iNo);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pagingMap", pagingMap);
		
		return "/review/ReviewList";
	}
	
	@RequestMapping(value = "/review/one.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewSelectOne(int iNo, int rNo, Model model) {
		logger.info("컨트롤러 one에 원하는 정보 들어옴? {}", model);
		Map<String, Object>prevMap = new HashMap<String, Object>();
		prevMap.put("iNo", iNo);

		Map<String, Object> map = reviewService.reviewSelectOne(rNo);
		
		ReviewDto reviewDto = (ReviewDto) map.get("reviewDto");
		
		logger.debug("컨트롤러 one에 원하는 정보를 서비스에서 갖고옴? {}" , map);
		
		List<Map<String, Object>> fileList = (List<Map<String, Object>>)map.get("fileList");
		
		
		model.addAttribute("reviewDto", reviewDto);
		model.addAttribute("fileList", fileList);
		model.addAttribute("prevMap", prevMap);
		
		return "/review/ReviewOne";
	}
}
