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
			int review = reviewDao.reviewSelectTotalReviewCount(iNo);
			log.info("review의 값이 잘 들어옴? {}" , review);
//			Map<String, Object> reviewMap = (Map<String, Object>) review;
			
			map.put("fileMap", fileMap);
			map.put("itemDto", itemDto);
			map.put("review", review);
			list.add(map);
		}
		
		return list;

	}

	@Override
	public int itemSelectTotalItemCount(int cNo, String keyword) {
		
		return itemDao.itemSelectTotalItemCount(cNo, keyword);
	}
//	@Override
//	public int reviewSelectTotalReviewCount(int iNo) {
//		return itemDao.reviewSelectTotalReviewCount(iNo);
//	}
	@Override
	public Map<String, Object> itemSelectOne(int iNo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ItemDto itemDto = itemDao.itemSelectOne(iNo);
		resultMap.put("itemDto", itemDto);

		
		List<Map<String, Object>> fileList = itemDao.fileSelectList(iNo);
		resultMap.put("fileList", fileList);
		
		return resultMap;

	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int itemUpdateOne(ItemDto itemDto, MultipartHttpServletRequest mulRequest
			, int imgNo) throws Exception {

		int resultNum = 0;

		try {
			
			// item 정보 업데이트하는 dao
			resultNum = itemDao.itemUpdateOne(itemDto);
			log.info("서비스mpl에서 itemDto는?? {}", itemDto);
			
			log.info("서비스mpl에서 업데이트는 성공했나? {}",resultNum);
			int iNo = itemDto.getiNo();
			
			// 선택한 item에 이미지 정보를 불러오는 dao
			Map<String, Object> tempFileMap = itemDao.fileSelectOne(iNo);
			log.info("서비스mpl에서 파일 하나를 잘 찾아왔나? {}",tempFileMap);
			
			// 실제 파일을 등록하고 등록한 파일의 정보를 가져오는 메서드
			// 파일이 없으면 알아서 등록이 안되고 있으면 등록이 됌
			List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(iNo, mulRequest);
			
			log.info("서비스mpl에서 list를 잘 찾아왔나? {}",list);
			
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
			log.debug("서비스 mpl에서 예외 발생", itemDto.getiName());
			TransactionAspectSupport.currentTransactionStatus()
			.setRollbackOnly();
		}
		
		log.debug("수정이 완료되었습니다. {}", itemDto.getiName());
		
		return resultNum;
	}

	@Override
	public void itemDeleteOne(int iNo) {
		itemDao.itemDeleteOne(iNo);
	}


}
