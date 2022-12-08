package com.fm.item.dao;

import java.util.ArrayList;
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
	@Override
	public void insertFile(Map<String, Object> map) {
		sqlSession.insert(namespace + "insertFile", map);
	}
	
//	R
	@Override
	public List<ItemDto> itemSelectList(int cNo, String keyword, int start, int end, int older, int uNo){
		Map<String, Object>map = new HashMap<String, Object>();
		
		map.put("cNo", cNo);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		map.put("older", older);
		map.put("uNo", uNo);
		
		return sqlSession.selectList(namespace + "itemSelectList", map);
		
	}
	@Override
	public ItemDto itemSelectOne(int iNo) {
		return sqlSession.selectOne(namespace + "itemSelectOne", iNo);
	}
	
	@Override
	public List<Map<String, Object>> fileSelectList(int iNo){
		
		return sqlSession.selectList(namespace + "fileSelectList", iNo);
	}
	@Override
	public Map<String, Object> fileSelectOne(int iNo) {
		
		return sqlSession.selectOne(namespace + "fileSelectOne", iNo);
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
	@Override
	public int fileDelete(int iNo) {
		return sqlSession.delete(namespace + "fileDelete", iNo);
	}
	
	
	
	
	
	
	//---------------------------------------------------------- 카테고리의 제품 수
	@Override
	public int itemSelectTotalItemCount(int cNo, String keyword, int uNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("cNo", cNo);
		map.put("keyword", keyword);
		map.put("uNo", uNo);
		return sqlSession.selectOne(namespace + "itemSelectTotalItemCount", map);
	}
	
	@Override
	public int reviewSelectTotalReviewCount(int iNo){
		return sqlSession.selectOne("com.fm.review.reviewSelectTotalReviewCount", iNo);
	}
	@Override
	public String getCategoryName(int cNo) {
		return sqlSession.selectOne(namespace + "getCategoryName", cNo);
	}
	@Override
	public List<ItemDto> viewBestItemList(int cNo, String keyword, int start, int end, int older, int uNo) {

		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("cNo", cNo);
		inputMap.put("keyword", keyword);
		inputMap.put("start", start);
		inputMap.put("end", end);
		inputMap.put("uNo", uNo);
		
		List<Integer> bestItemNoList = sqlSession.selectList(namespace + "viewBestItemNoList", inputMap);
		List<ItemDto> newBestItemList = new ArrayList<ItemDto>();
		
		for(int iNo : bestItemNoList) {
			newBestItemList.add(sqlSession.selectOne(namespace + "viewTotalBestItemList", iNo));
		}
		
		return newBestItemList;
	}
	@Override
	public List<ItemDto> viewRecommendItemList(int cNo, String keyword, int start, int end, int older,
			int uNo) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", uNo);
		inputMap.put("keyword", keyword);
		inputMap.put("start", start);
		inputMap.put("end", end);
		inputMap.put("older", older);
		
		
		return sqlSession.selectList(namespace + "viewRecommendItemList", inputMap);
	}
	@Override
	public int selectRecommendItemCount(int cNo, String keyword, int uNo) {
			Map<String, Object> inputMap = new HashMap<String, Object>();
			inputMap.put("uNo", uNo);
			inputMap.put("keyword", keyword);
			inputMap.put("cNo", cNo);
		return sqlSession.selectOne(namespace + "selectRecommendItemCount", inputMap);
	}
}
