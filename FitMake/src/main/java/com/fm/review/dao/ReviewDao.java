package com.fm.review.dao;

import java.util.Map;

import com.fm.review.model.ReviewDto;

public interface ReviewDao {
	
	public int reviewInsert(ReviewDto reviewDto);
	public void insertFile(Map<String,Object> map);
	
	
}
