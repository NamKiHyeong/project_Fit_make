package com.fm.review.dao;

import java.util.List;
import java.util.Map;

import com.fm.review.model.ReviewDto;

public interface ReviewDao {
//	C
	public int reviewInsert(ReviewDto reviewDto);
	public void insertFile(Map<String,Object> map);
	
//	R
	public List<ReviewDto> reviewSelectList(int iNo, int start, int end);
	public ReviewDto reviewSelectOne(int rNo);
	
	public Map<String, Object> fileSelectOne(int rNo);
	public List<Map<String, Object>> fileSelectList(int rNo);
	
	public int reviewSelectTotalReviewCount(int iNo);
//	U
	int reviewUpdateOne(ReviewDto reviewDto);
	
//	D
	public void reviewDeleteOne(int iNo);
	public int fileDelete(int iNo);
	
	public List<Map<String, Object>> getOrderList(int uNo, int oNo);
	
}
