package com.fm.review.service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fm.review.controller.ReviewController;
import com.fm.review.dao.ReviewDao;
import com.fm.review.model.ReviewDto;

@Service
public class ReviewServicempl implements ReviewService {
	private static final Logger logger
	= LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	public ReviewDao reviewDao;
	
//	@Resource(name = "fileUtils")
//	private FileUtils fileUtiles;
	
	public void reviewInsert(ReviewDto reviewDto, HttpServletRequest request) {
		reviewDao.reviewInsert(reviewDto);
		
//		Iterator<String> iterator = mulRequest.get
		
		
		int parentSql = reviewDto.getrNo();
		
	}
}
