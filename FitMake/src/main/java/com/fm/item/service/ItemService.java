package com.fm.item.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.item.model.ItemDto;


public interface ItemService {
	public void itemInsertOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest) throws Exception;
//	public void itemInsertOne(ItemDto itemDto, HttpServletRequest hRequest) throws Exception;
	
	public Map<String, Object> itemSelectOne(int no);
	
	public int itemUpdateOne(ItemDto itemDto) throws Exception;
	
	public void itemDeleteOne(int no);

	public List<Map<String, Object>> itemSelectList(int cNo);
	


}
