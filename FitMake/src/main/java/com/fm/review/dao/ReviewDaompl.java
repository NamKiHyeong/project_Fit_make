package com.fm.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.item.model.ItemDto;
import com.fm.review.model.ReviewDto;

@Repository
public class ReviewDaompl implements ReviewDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	String namespace = "com.fm.review.";
	
//	C
	@Override
	public int reviewInsert(ReviewDto reviewDto) {
		System.out.println("Daompl에서" + reviewDto);
		return sqlSession.insert(namespace + "reviewInsert", reviewDto);
		
	}
	@Override
	public void insertFile(Map<String, Object> map) {
		System.out.println("map의 parent seq" + map.get("parentSeq"));
		
		sqlSession.insert(namespace + "insertFile", map);	//여기가 문제라고?
	}
	
//	R list
	@Override
	public List<ReviewDto> reviewSelectList(int iNo){
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("iNo", iNo);
		
		return sqlSession.selectList(namespace + "reviewSelect", map);
	}
		
	@Override
	public Map<String, Object> fileSelectOne(int rNo){
		System.out.println("Daompl에서 rNo은? " + rNo);
		return sqlSession.selectOne(namespace + "fileSelectOne", rNo);
	}
	
//	R One
	@Override
	public ReviewDto reviewSelectOne(int rNo) {
		System.out.println("Daompl에서 rNo" + rNo);
		return sqlSession.selectOne(namespace + "reviewSelectOne", rNo);
	}

	@Override
	public List<Map<String, Object>> fileSelectList(int rNo){
		System.out.println("Daompl에서 파일리스트는? rNo" + rNo);
		return sqlSession.selectList(namespace + "fileSelectList", rNo);
	}
//	U
	@Override
	public int reviewUpdateOne(ReviewDto reviewDto) {
		System.out.println("Dao mpl에서 업데이트 Dto?" + reviewDto);
		return sqlSession.update(namespace + "reviewUpdateOne", reviewDto);
	}
//	D
	@Override
	public void reviewDeleteOne(int rNo){
		sqlSession.delete(namespace + "reviewDeleteOne", rNo);
	}
	
	@Override
	public int fileDelete(int rNo) {
		return sqlSession.delete(namespace + "fileDelete", rNo);
	}
}
