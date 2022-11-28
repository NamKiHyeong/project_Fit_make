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
	
////	R
//	@Override
//	public List<ReviewDto> reviewSelectList(int cNo){
//		Map<String, Object>map = new HashMap<String, Object>();
//		
//		map.put("cNo", cNo);
//		
//		return sqlSession.selectList(namespace + "reviewSelect", map);
//	}
//	
//	
//	@Override
//	public Map<String, Object> fileSelectOne(int no){
//		
//		return sqlSession.selectOne(namespace + "fileSelectOne", no);
//		
//	}
	
}
