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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
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
	
/**Crdate
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
/** Read
 * 
 */
	@Override
	public List<Map<String, Object>> itemSelectList(int cNo, String keyword, int start, int end, int older) {
		List<ItemDto> itemList = itemDao.itemSelectList(cNo, keyword, start, end, older);
		
		List<Map<String, Object>> list = new ArrayList<>();
		for (ItemDto itemDto : itemList) {
			Map<String, Object> map = new HashMap<String, Object>();
			int iNo = itemDto.getiNo();
			
			Map<String, Object> fileMap = itemDao.fileSelectOne(iNo);
//			List<Map<String, Object>> fileMap = itemDao.fileSelectOne(iNo);
			
			map.put("fileMap", fileMap);
			map.put("itemDto", itemDto);
			
			list.add(map);
		}
		
		return list;

	}

	@Override
	public int itemSelectTotalItemCount(int cNo, String keyword) {
		
		return itemDao.itemSelectTotalItemCount(cNo, keyword);
	}
	@Override
	public Map<String, Object> itemSelectOne(int no) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ItemDto itemDto = itemDao.itemSelectOne(no);
		resultMap.put("itemDto", itemDto);

		
		List<Map<String, Object>> fileList = itemDao.fileSelectList(no);
		resultMap.put("fileList", fileList);
		
		return resultMap;

	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int itemUpdateOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest, int fileIdx) throws Exception {

		int resultNum = 0;

		try {
			resultNum = itemDao.itemUpdateOne(itemDto);
			
			int iNo = itemDto.getiNo();
			
//			List<Map<String, Object>> tempFileMap = itemDao.fileSelectOne(iNo);
			Map<String, Object> tempFileMap = itemDao.fileSelectOne(iNo);
			// 실제 드라이브 파일을 추가하고 정보를 반환함 ex)이름 사이즈 번호
			List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(iNo, mulRequest);
			
			log.debug("수정되는 것 확인1", itemDto.getiName());
			
			// 리스트가 존재 할 경우 수행			
			if(list.isEmpty() == false) {
				
				//item_img테이블에 파일정보가 존재 할 경우
				if(tempFileMap != null) {
					//db에서 파일정보 삭제
					itemDao.fileDelete(iNo);
					//실제 드라이브에 파일을 삭제
					fileUtiles.parseUpdateFileInfo(tempFileMap);
				}
				
				for(Map<String, Object> map : list) {
					//db에 파일정보를 추가
					itemDao.insertFile(map);
					
				}
			// 이미지를 삭제해서 존재하지 않을 때
			} else if(fileIdx == -1){
				log.debug("수정되는 것 확인4", itemDto.getiName());
				
				if(tempFileMap != null){
					//db에서 파일정보 삭제
					itemDao.fileDelete(iNo);
					//실제 드라이브에 파일을 삭제
					fileUtiles.parseUpdateFileInfo(tempFileMap);
					
					log.debug("수정되는 것 확인5", itemDto.getiName());
				}
			}
			
		} catch (Exception e) {
			log.debug("수정되는 것 확인6", itemDto.getiName());
			TransactionAspectSupport.currentTransactionStatus()
			.setRollbackOnly();
		}
		log.debug("수정되는 것 확인7", itemDto.getiName());
		
		return resultNum;
	}

	@Override
	public void itemDeleteOne(int no) {
		itemDao.itemDeleteOne(no);
	}


}
