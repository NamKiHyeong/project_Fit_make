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
	public List<ItemDto> itemSelectList(int cNo, int start, int end){
		Map<String, Object>map = new HashMap<String, Object>();
		
//		map.put("SearchOption", SearchOptionmap);
//		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		map.put("cNo", cNo);
		return sqlSession.selectList(namespace + "itemSelectList", map);
//		return sqlSession.selectList(namespace + "itemSelectList", cNo);
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
	
	@Override
	public void itemDeleteOne(int no){
		sqlSession.delete(namespace + "itemDeleteOne", no);
	
	}
	
	//----------------------------------------------------------
	
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
//	public List<Map<String, Object>> fileSelectOne(int no) {
		// TODO Auto-generated method stub
		System.out.println(no);
		return sqlSession.selectOne(namespace + "fileSelectOne", no);
//		return sqlSession.selectList(namespace + "fileSelectOne", no);
	}
	
	@Override
	public int fileDelete(int no) {
		return sqlSession.delete(namespace + "fileDelete", no);
	}
}
