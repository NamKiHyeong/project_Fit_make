package com.fm.item.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.item.dao.ItemDao;
import com.fm.item.model.ItemDto;
import com.fm.util.FileUtils;

@Service
public class ItemServicempl implements ItemService {
	private static final Logger log = LoggerFactory.getLogger(ItemServicempl.class);

	@Autowired
	public ItemDao itemDao;

	@Resource(name = "fileUtils")
	private FileUtils fileUtiles;
/**
 * 
 */
	@Override
	public void itemInsertOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest) throws Exception {
		itemDao.itemInsertOne(itemDto);

		Iterator<String> iterator = mulRequest.getFileNames();
		MultipartFile multipartFile = null;

		while (iterator.hasNext()) {
			multipartFile = mulRequest.getFile(iterator.next());

			if (multipartFile.isEmpty() == false) {
				log.debug("---------------file start -------------");
				log.debug(" name : {}", multipartFile.getName());
				log.debug("fileName : {}", multipartFile.getOriginalFilename());
				log.debug("size : {}", multipartFile.getSize());
				log.debug("---------------file end -------------\n");
			}
		} // while end

		int parentSql = itemDto.getiNo();

		List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(parentSql, mulRequest);

		for (int i = 0; i < list.size(); i++) {
			itemDao.insertFile(list.get(i));
		}

	}

	@Override
	public List<Map<String, Object>> itemSelectList(int cNo) {
		List<ItemDto> itemList = itemDao.itemSelectList(cNo);
		
		List<Map<String, Object>> list = new ArrayList<>();
		for (ItemDto itemDto : itemList) {
			Map<String, Object> map = new HashMap<String, Object>();
			int iNo = itemDto.getiNo();
			
			Map<String, Object> fileMap = itemDao.fileSelectOne(iNo);
			
			System.out.println("sk ckwdk" + itemDto);
			
			map.put("fileMap", fileMap);
			map.put("itemDto", itemDto);
			
			list.add(map);
		}
		
		return list;

	}

	public Map<String, Object> itemSelectOne(int no) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ItemDto itemDto = itemDao.itemSelectOne(no);
		resultMap.put("itemDto", itemDto);

		
		List<Map<String, Object>> fileList = itemDao.fileSelectList(no);
		resultMap.put("fileList", fileList);
		
		return resultMap;

	}

	public int itemUpdateOne(ItemDto itemDto) throws Exception {

		int resultNum = 0;

		try {
			resultNum = itemDao.itemUpdateOne(itemDto);
		} catch (Exception e) {

			// TODO: handle exception
		}
		return resultNum;
	}

	public void itemDeleteOne(int no) {
		itemDao.itemDeleteOne(no);
	}


}
