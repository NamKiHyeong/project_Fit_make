package com.fm.review.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fm.review.model.ReviewDto;
import com.fm.review.service.ReviewService;

@Controller
public class ReviewController {
	
	private static final Logger logger
		= LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(value="/review/add.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewAdd(Model model) {
		logger.info("리플을 달아보자", model);
		
		return "/review/ReviewAdd";
	}
	
	@RequestMapping(value="/review/addCtr.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewAddCtr(ReviewDto reviewDto, Model model, HttpServletRequest request) {
		logger.info("리플을 작성합니다." + reviewDto);
		try {
			reviewService.reviewInsert(reviewDto, request);
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("예외 발생");
			e.printStackTrace();
		}
		
		return "redirect:/item/list.do?cNo=2";
	}
}
