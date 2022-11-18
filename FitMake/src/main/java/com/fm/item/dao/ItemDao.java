package com.fm.item.dao;

import java.util.List;
import java.util.Map;

import com.fm.item.model.ItemDto;

public interface ItemDao {
	public int itemInsertOne(ItemDto itemDto);
	
	public List<ItemDto> itemSelectList();
	public ItemDto itemSelectOne(int no);
	
	public int itemUpdateOne(ItemDto itemDto);
	
	public void itemDeleteOne(int no);

	
	public void insertFile(Map<String, Object> map);
}
