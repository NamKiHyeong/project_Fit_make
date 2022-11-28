package com.fm.review.dao;

import java.util.List;
import java.util.Map;

import com.fm.review.model.ReviewDto;

public interface ReviewDao {
	
	public int reviewInsert(ReviewDto reviewDto);
	public void insertFile(Map<String,Object> map);
	
	
//	public List<ReviewDto> reviewSelectList(int cNo);
////	public List<Map<String, Object>> fileSelectList(int rNo);
//	public Map<String, Object> fileSelectOne(int no);

}
