package com.fm.item.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fm.item.dao.ItemDao;
import com.fm.item.model.ItemDto;
import com.fm.util.FileUtils;

@Service
public class ItemServicempl implements ItemService{
	private static final Logger log = LoggerFactory.getLogger(ItemServicempl.class);
	
	@Autowired
	public ItemDao itemDao;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtiles;
	
	@Override
	public void itemInsertOne(ItemDto itemDto, HttpServletRequest mulRequest) throws Exception {
//	public void itemInsertOne(ItemDto itemDto) throws Exception {
		itemDao.itemInsertOne(itemDto);
		
//		Iterator<String> iterator = mulRequest.getFileNames();
//		MultipartFile multipartFile = null;
//		
//		while(iterator.hasNext()) {
//			multipartFile = mulRequest.getFile(iterator.next());
//			
//			if(multipartFile.isEmpty()==false) {
//				log.debug("---------------file start -------------");
//				log.debug(" name : {}", multipartFile.getName());
//				log.debug("fileName : {}", multipartFile.getOriginalFilename());
//				log.debug("size : {}", multipartFile.getSize());
//				log.debug("---------------file end -------------\n");
//			}
//		}// while end
//		
//		int parentSql = itemDto.getiNo();
//		
//		List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(parentSql, mulRequest);
//		아이템  등록이 확인되면 파일도 C도 추가해서 multi C로 바꾸기
//		for (int i = 0; i < list.size(); i++) {
//			itemDao.insertFile(list.get(i));
//		}
		
	}
	
	@Override
	public List<ItemDto> itemSelectList(){
		return itemDao.itemSelectList();
		
	}
	
	public Map<String, Object> itemSelectOne(int no){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ItemDto itemDto = itemDao.itemSelectOne(no);
		resultMap.put("itemDto", itemDto);
		
		return resultMap;
		
	}
}
