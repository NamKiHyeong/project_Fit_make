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
	
	/** Create
	 *  review Info
	 */
	@Override
	public int reviewInsert(ReviewDto reviewDto) {
		return sqlSession.insert(namespace + "reviewInsert", reviewDto);
	}
	//review File
	@Override
	public void insertFile(Map<String, Object> map) {
		sqlSession.insert(namespace + "insertFile", map);	//여기가 문제라고?
	}
	
	/** Read
	 * 
	 */
	@Override
	public int reviewSelectTotalReviewCount(int iNo) {
		return sqlSession.selectOne(namespace + "reviewSelectTotalReviewCount", iNo);
	}
	
	@Override
	public List<ReviewDto> reviewSelectList(int iNo, int start, int end){
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("iNo", iNo);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList(namespace + "reviewSelect", map);
	}
		
	@Override
	public Map<String, Object> fileSelectOne(int rNo){
		return sqlSession.selectOne(namespace + "fileSelectOne", rNo);
	}
	
	//	R One
	@Override
	public ReviewDto reviewSelectOne(int rNo) {
		return sqlSession.selectOne(namespace + "reviewSelectOne", rNo);
	}
	//저장된 사진을 리스트로 가져옴
	@Override
	public List<Map<String, Object>> fileSelectList(int rNo){
		return sqlSession.selectList(namespace + "fileSelectList", rNo);
	}
	//	U
	@Override
	public int reviewUpdateOne(ReviewDto reviewDto) {
		return sqlSession.update(namespace + "reviewUpdateOne", reviewDto);
	}
	
	
	//	D review Info 삭제
	@Override
	public void reviewDeleteOne(int rNo){
		sqlSession.delete(namespace + "reviewDeleteOne", rNo);
	}
	//	D review 사진 삭제 
	@Override
	public int fileDelete(int rNo) {
		return sqlSession.delete(namespace + "fileDelete", rNo);
	}
	
	
}
