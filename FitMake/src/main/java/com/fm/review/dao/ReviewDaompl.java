package com.fm.review.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.review.model.ReviewDto;

@Repository
public class ReviewDaompl implements ReviewDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	String namespace = "com.fm.review.";
	
//	C
	@Override
	public int reviewInsert(ReviewDto reviewDto) {
		return sqlSession.insert(namespace + "reviewInsert", reviewDto);
	}
	
	
}
