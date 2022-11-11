package com.fm.Item.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.Item.dao.ItemDao;
import com.fm.Item.model.ItemDto;
import com.fm.util.FileUtils;

public class ItemServicempl implements ItemService{
	private static final Logger log = LoggerFactory.getLogger(ItemServicempl.class);
	
	@Autowired
	public ItemDao itemDao;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtiles;
	
	@Override
	public void itemInsertOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest) throws Exception {
		
		itemDao.itemInsertOne(itemDto);
		
		Iterator<String> iterator = mulRequest.getFileNames();
		MultipartFile multipartFile = null;
		
		while(iterator.hasNext()) {
			log.debug("---------------file start -------------");
			log.debug(" name : {}", multipartFile.getName());
			log.debug("fileName : {}", multipartFile.getOriginalFilename());
			log.debug("size : {}", multipartFile.getSize());
			log.debug("---------------file end -------------\n");
		}// while end
		
		int parentSql = itemDto.getiNo();
		
		List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(parentSql, mulRequest);
		
//		for (int i = 0; i < list.size(); i++) {
//			itemDao.insertFile(list.get(i));
//		}		
		
	}
	
}
