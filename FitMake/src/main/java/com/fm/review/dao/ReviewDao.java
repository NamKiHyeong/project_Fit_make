package com.fm.review.dao;

import java.util.List;
import java.util.Map;

import com.fm.review.model.ReviewDto;

public interface ReviewDao {
//	C
	public int reviewInsert(ReviewDto reviewDto);
	public void insertFile(Map<String,Object> map);
	
//	R
//	public List<ReviewDto> reviewSelectList(int iNo);
	public List<ReviewDto> reviewSelectList(int iNo, int start, int end);
//	public List<ReviewDto> reviewSelectList(int iNo, String keyword, int start, int end);
	public Map<String, Object> fileSelectOne(int rNo);
	
	public ReviewDto reviewSelectOne(int rNo);
	public List<Map<String, Object>> fileSelectList(int rNo);
	int reviewUpdateOne(ReviewDto reviewDto);
	
	
	public void reviewDeleteOne(int iNo);
	public int fileDelete(int iNo);
	public int reviewSelectTotalReviewCount(int iNo);
//	public Map<String, Object> reviewSelectTotalReviewCount(int iNo);
//	public int reviewSelectTotalReviewCount(int iNo, String keyword);
}
