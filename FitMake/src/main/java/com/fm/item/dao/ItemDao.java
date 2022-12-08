package com.fm.item.dao;

import java.util.List;
import java.util.Map;

import com.fm.item.model.ItemDto;

public interface ItemDao {
//	C
	public int itemInsertOne(ItemDto itemDto);
	public void insertFile(Map<String, Object> map);
	
//	R
	public List<ItemDto> itemSelectList(int cNo, String keyword, int start, int end, int older, int uNo);
	public ItemDto itemSelectOne(int iNo);

	public List<Map<String, Object>> fileSelectList(int iNo);
	public Map<String, Object> fileSelectOne(int iNo);
	
	public int reviewSelectTotalReviewCount(int iNo);
	public int itemSelectTotalItemCount(int cNo, String keyword, int uNo);
//	U
	int itemUpdateOne(ItemDto itemDto);

	
//	D
	public void itemDeleteOne(int no);
	public int fileDelete(int iNo);
	
	
//-----------------------------------------------------------
	
	

	

	public String getCategoryName(int cNo);

	public List<ItemDto> viewBestItemList(int cNo, String keyword, int start, int end, int older, int uNo);

	public List<ItemDto> viewRecommendItemList(int cNo, String keyword, int start, int end, int older,
			int uNo);

	public int selectRecommendItemCount(int cNo, String keyword, int uNo);
	
	

}