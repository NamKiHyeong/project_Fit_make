package com.fm.Item.service;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.Item.model.ItemDto;


public interface ItemService {
	public void itemInsertOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest) throws Exception;
	
}
