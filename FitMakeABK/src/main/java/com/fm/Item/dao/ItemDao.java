package com.fm.Item.dao;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.Item.model.ItemDto;

public interface ItemDao {
	public int itemInsertOne(ItemDto itemDto);
}
