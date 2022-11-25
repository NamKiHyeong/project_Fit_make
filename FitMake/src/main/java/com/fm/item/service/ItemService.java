package com.fm.item.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.item.model.ItemDto;


public interface ItemService {
	public void itemInsertOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest) throws Exception;
	
	public Map<String, Object> itemSelectOne(int no);
	public List<Map<String, Object>> itemSelectList(int cNo, String keyword, int start, int end, int older);
	
	public int itemUpdateOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest, int fileIdx) throws Exception;
	
	public void itemDeleteOne(int no);

//-----------------------------------------------------------
	
	public int itemSelectTotalItemCount(int cNo, String keyword);
}
