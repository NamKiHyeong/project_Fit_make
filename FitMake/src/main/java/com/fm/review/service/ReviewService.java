package com.fm.review.service;

import javax.servlet.http.HttpServletRequest;

import com.fm.review.model.ReviewDto;

public interface ReviewService {
	public void reviewInsert(ReviewDto reviewDto, HttpServletRequest request) throws Exception;
	
	
	
}
