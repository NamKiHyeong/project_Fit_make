package com.fm.item.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.item.model.ItemDto;


public interface ItemService {
	public void itemInsertOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest) throws Exception;
	
	public List<Map<String, Object>> itemSelectList(int cNo, String keyword, int start, int end, int older, int uNo);
	public Map<String, Object> itemSelectOne(int iNo);
	
	public int itemUpdateOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest, int imgNo) throws Exception;
	
	public void itemDeleteOne(int iNo);

//-----------------------------------------------------------
	
	public int itemSelectTotalItemCount(int cNo, String keyword, int uNo);

	public String getCategoryName(int cNo);

	public List<Map<String, Object>> viewBestItemList(int cNo, String keyword, int start, int end, int older, int uNo);

	public List<Map<String, Object>> viewRecommendItemList(int cNo, String keyword, int start, int end, int older,
			int uNo);
	
}
