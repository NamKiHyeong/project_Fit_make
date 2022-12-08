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
import com.fm.review.dao.ReviewDao;
import com.fm.util.FileUtils;

@Service
public class ItemServicempl implements ItemService {
	private static final Logger log = LoggerFactory.getLogger(ItemServicempl.class);

	@Autowired
	public ItemDao itemDao;
	
	@Autowired
	public ReviewDao reviewDao;

	@Resource(name = "fileUtils")
	private FileUtils fileUtiles;
	
	/** Create
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
	public List<ItemDto> itemSelectList(int cNo, String keyword, int start, int end, int older, int uNo) {
		List<ItemDto> itemList = itemDao.itemSelectList(cNo, keyword, start, end, older, uNo);
		
		List<ItemDto> list = new ArrayList<>();
		
		for (ItemDto itemDto : itemList) {
			
			int iNo = itemDto.getiNo();
			
			Map<String, Object> fileMap = itemDao.fileSelectOne(iNo);
			int review = reviewDao.reviewSelectTotalReviewCount(iNo);
			
			itemDto.setrCount(review);
			itemDto.setiImgStoredName((String)fileMap.get("FM_ITEM_STORED_IMG_NAME"));
			list.add(itemDto);
		}
		
		return list;

	}
	// 페이징을 하기 위한 제품 수를 구함
	@Override
	public int itemSelectTotalItemCount(int cNo, String keyword, int uNo) {
		
		return itemDao.itemSelectTotalItemCount(cNo, keyword, uNo);
	}
	@Override
	public Map<String, Object> itemSelectOne(int iNo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ItemDto itemDto = itemDao.itemSelectOne(iNo);
		List<Map<String, Object>> fileList = itemDao.fileSelectList(iNo);
		
		resultMap.put("itemDto", itemDto);
		resultMap.put("fileList", fileList);
		
		return resultMap;

	}
	
	/** Update
	 *  업데이트가 완료되면 실행되도록 @Transactional을 씀 되지 않으면 롤백
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int itemUpdateOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest
			, int imgNo) throws Exception {

		int resultNum = 0;

		try {
			
			// item 정보 업데이트하는 dao
			resultNum = itemDao.itemUpdateOne(itemDto);
			
			int iNo = itemDto.getiNo();
			
			// 선택한 item에 이미지 정보를 불러오는 dao
			Map<String, Object> tempFileMap = itemDao.fileSelectOne(iNo);
			
			// 실제 파일을 등록하고 등록한 파일의 정보를 가져오는 메서드
			// 파일이 없으면 알아서 등록이 안되고 있으면 등록이 됌
			List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(iNo, mulRequest);
			
			// 리스트안에 요소가 있을때
			// 리스트안에 요소가 있다는것은 파일을 새로 등록햇을때만 요소가 있음
			// 요소가 없다는것은 등록을 아에 안한것
			// 사진 있는 상태에서 사진 새로 업데이트
			if(list.isEmpty() == false) {
				
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
			// 이미지를 삭제해서 존재 않을 때
			}else if(imgNo == -1){
				
				if(tempFileMap != null){
					//db에서 파일정보 삭제
					itemDao.fileDelete(iNo);
					//실제 드라이브에 파일을 삭제
					fileUtiles.parseUpdateFileInfo(tempFileMap);
					
				}
			}
			
			
			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus()
			.setRollbackOnly();
		}
		
		return resultNum;
	}
	/** Delete
	 * 
	 */
	@Override
	public void itemDeleteOne(int iNo) {
		itemDao.itemDeleteOne(iNo);
	}
	
	
	
//	-------------------------------------------------------
	@Override
	public String getCategoryName(int cNo) {
		
		return itemDao.getCategoryName(cNo);
	}
	@Override
	public List<ItemDto> viewBestItemList(int cNo, String keyword, int start, int end, int older, int uNo) {
		
		return itemDao.viewBestItemList(cNo, keyword, start, end, older, uNo);
	}
	@Override
	public List<ItemDto> viewRecommendItemList(int cNo, String keyword, int start, int end, int older
			, int uNo) {
		
		return itemDao.viewRecommendItemList(cNo, keyword, start, end, older, uNo);
	}
	@Override
	public int selectRecommendItemCount(int cNo, String keyword, int uNo) {
		return itemDao.selectRecommendItemCount(cNo, keyword, uNo);
	}


}
