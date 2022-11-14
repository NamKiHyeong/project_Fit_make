package com.fm.item.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.item.model.ItemDto;

@Repository
public class ItemDaompl implements ItemDao{
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String namespace = "com.fm.item.";
	
	@Override
	public int itemInsertOne(ItemDto itemDto) {
		return sqlSession.insert(namespace + "itemInsertOne", itemDto);
	}
	
	@Override
	public List<ItemDto> itemSelectList(){
		return sqlSession.selectList(namespace + "itemSelectList");
	}
	
	public ItemDto itemSelectOne(int no) {
		return sqlSession.selectOne(namespace + "itemSelectOne");
	}

			
}
