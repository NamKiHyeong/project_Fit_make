package com.fm.Item.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.Item.model.ItemDto;

@Repository
public class ItemDaompl {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String namespace = "com.fm.item.";
	
	public int itmeInsertOne(ItemDto itemDto) {
		return sqlSession.insert(namespace + "itemInsertOne", itemDto);
	}
			
}
