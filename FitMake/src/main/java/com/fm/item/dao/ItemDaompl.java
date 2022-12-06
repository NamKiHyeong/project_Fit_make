package com.fm.item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.item.model.ItemDto;

@Repository
public class ItemDaompl implements ItemDao{
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String namespace = "com.fm.item.";
//	C
	@Override
	public int itemInsertOne(ItemDto itemDto) {
		
		itemDto.setiCGrade((int)Math.round(Math.ceil(itemDto.getiCalory()/100))+1);
		return sqlSession.insert(namespace + "itemInsertOne", itemDto);
	}
//	R
	@Override
	public List<ItemDto> itemSelectList(int cNo, String keyword, int start, int end, int older){
		Map<String, Object>map = new HashMap<String, Object>();
		
		map.put("cNo", cNo);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		
		
		if(older==1) {
			return sqlSession.selectList(namespace + "itemSelectListGold", map);
		} else if(older==2) {
			return sqlSession.selectList(namespace + "itemSelectListReview", map);
		} else {
			return sqlSession.selectList(namespace + "itemSelectList", map);
		}
		
	}
	
	@Override
	public ItemDto itemSelectOne(int iNo) {
		
		return sqlSession.selectOne(namespace + "itemSelectOne", iNo);
	}
	
//	U
	@Override
	public int itemUpdateOne(ItemDto itemDto) {
		return sqlSession.update(namespace + "itemUpdateOne", itemDto);
	}
//	D
	@Override
	public void itemDeleteOne(int iNo){
		sqlSession.delete(namespace + "itemDeleteOne", iNo);
	
	}
	
	//---------------------------------------------------------- 제품 이미지
	
	@Override
	public void insertFile(Map<String, Object> map) {
		
		sqlSession.insert(namespace + "insertFile", map);
	}
	
	@Override
	public List<Map<String, Object>> fileSelectList(int iNo){
		
		return sqlSession.selectList(namespace + "fileSelectList", iNo);
	}
	@Override
	public Map<String, Object> fileSelectOne(int iNo) {
		// TODO Auto-generated method stub
		System.out.println(iNo);
		return sqlSession.selectOne(namespace + "fileSelectOne", iNo);
	}
	
	@Override
	public int fileDelete(int iNo) {
		return sqlSession.delete(namespace + "fileDelete", iNo);
	}
	
	
	//---------------------------------------------------------- 카테고리의 제품 수
	@Override
	public int itemSelectTotalItemCount(int cNo, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("cNo", cNo);
		map.put("keyword", keyword);
		return sqlSession.selectOne(namespace + "itemSelectTotalItemCount", map);
	}
	
	@Override
	public int reviewSelectTotalReviewCount(int iNo){
//		public Map<String, Object> reviewSelectTotalReviewCount(int iNo){
		System.out.println("item daompl에서 리뷰 값을 가져오기 위한 iNo 값이 제대로 들어오나?" + iNo);
		return sqlSession.selectOne("com.fm.review.reviewSelectTotalReviewCount", iNo);
	}
}
