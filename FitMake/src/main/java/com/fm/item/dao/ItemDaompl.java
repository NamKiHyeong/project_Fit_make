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
	public ItemDto itemSelectOne(int no) {
		return sqlSession.selectOne(namespace + "itemSelectOne", no);
	}
	
//	U
	@Override
	public int itemUpdateOne(ItemDto itemDto) {
		return sqlSession.update(namespace + "itemUpdateOne", itemDto);
	}
//	D
	@Override
	public void itemDeleteOne(int no){
		sqlSession.delete(namespace + "itemDeleteOne", no);
	
	}
	
	//---------------------------------------------------------- 제품 이미지
	
	@Override
	public void insertFile(Map<String, Object> map) {
		
		sqlSession.insert(namespace + "insertFile", map);
	}
	
	@Override
	public List<Map<String, Object>> fileSelectList(int no){
		
		return sqlSession.selectList(namespace + "fileSelectList", no);
	}
	@Override
	public Map<String, Object> fileSelectOne(int no) {
		// TODO Auto-generated method stub
		System.out.println(no);
		return sqlSession.selectOne(namespace + "fileSelectOne", no);
	}
	
	@Override
	public int fileDelete(int no) {
		return sqlSession.delete(namespace + "fileDelete", no);
	}
	
	
	//---------------------------------------------------------- 카테고리의 제품 수
	public int itemSelectTotalItemCount(int cNo, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("cNo", cNo);
		map.put("keyword", keyword);
		return sqlSession.selectOne(namespace + "itemSelectTotalItemCount", map);
	}
}
