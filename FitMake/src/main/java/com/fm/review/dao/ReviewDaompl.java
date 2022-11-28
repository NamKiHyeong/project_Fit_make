package com.fm.review.dao;

import java.util.Map;

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
	@Override
	public void insertFile(Map<String, Object> map) {
		sqlSession.insert(namespace + "insertFile", map);
	}
	
	
}
