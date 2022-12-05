package com.fm.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.review.model.ReviewDto;

public interface ReviewService {
	public void reviewInsert(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest) throws Exception;
	
	public List<Map<String, Object>> reviewSelectList(int iNo, int start, int end);
//	public List<Map<String, Object>> reviewSelectList(int iNo, String keyword, int start, int end);
//	public List<Map<String, Object>> reviewSelectList(int iNo);
	public Map<String, Object> reviewSelectOne(int rNo);

	public int reviewUpdateOne(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest, int imgNo) throws Exception;

	public void reviewDeleteOne(int rNo);

	public int reviewSelectTotalReviewCount(int iNo);
//	public Map<String, Object> reviewSelectTotalReviewCount(int iNo);
//	public int reviewSelectTotalReviewCount(int iNo, String keyword);
//-----------------
//	public int reviewSelectTotalReviewCount2();
	
	
}
