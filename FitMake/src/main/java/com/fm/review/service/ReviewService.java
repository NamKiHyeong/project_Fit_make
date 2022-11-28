package com.fm.review.service;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.review.model.ReviewDto;

public interface ReviewService {
	public void reviewInsert(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest) throws Exception;
	
	
	
	
}
