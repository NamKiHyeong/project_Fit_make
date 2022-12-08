package com.fm.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.review.model.ReviewDto;

public interface ReviewService {
//	C
	public void reviewInsert(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest) throws Exception;
	
//	R
	public int reviewSelectTotalReviewCount(int iNo);
	public List<Map<String, Object>> reviewSelectList(int iNo, int start, int end);
	public Map<String, Object> reviewSelectOne(int rNo);
//	U
	public int reviewUpdateOne(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest, int imgNo) throws Exception;
//	D
	public void reviewDeleteOne(int rNo);

	public List<Map<String, Object>> getOrderList(int uNo);
	
}
