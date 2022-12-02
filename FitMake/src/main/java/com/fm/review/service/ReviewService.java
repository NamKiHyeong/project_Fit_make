package com.fm.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.review.model.ReviewDto;

public interface ReviewService {
	public void reviewInsert(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest) throws Exception;
	
	public List<Map<String, Object>> reviewSelectList(int iNo);
	public Map<String, Object> reviewSelectOne(int rNo);

	public int reviewUpdateOne(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest, int fileIdx) throws Exception;

	public void reviewDeleteOne(int rNo);
	
	
	
}
