package com.fm.review.service;

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

import com.fm.review.dao.ReviewDao;
import com.fm.review.model.ReviewDto;
import com.fm.util.FileUtils;


@Service
public class ReviewServicempl implements ReviewService {
	private static final Logger log
	= LoggerFactory.getLogger(ReviewServicempl.class);
	
	@Autowired
	public ReviewDao reviewDao;
	
	
	@Resource(name = "fileUtils")
	private FileUtils fileUtiles;
	
	/** Create
	 *  
	 */
	@Override
	public void reviewInsert(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest) throws Exception{
		
//		Dao로 값을 보내기
		reviewDao.reviewInsert(reviewDto);
		
		Iterator<String> iterator = mulRequest.getFileNames();
		MultipartFile multipartFile = null;
		
//		파일이 잘 들어왔는지 디버깅
		while(iterator.hasNext()) {
			multipartFile = mulRequest.getFile(iterator.next());
			
			if(multipartFile.isEmpty() == false) {
				log.debug ("---------------file start -------------");
				log.debug(" name : {}", multipartFile.getName());
				log.debug("fileName : {}", multipartFile.getOriginalFilename());
				log.debug("size : {}", multipartFile.getSize());
				log.debug("---------------file end -------------\n");
			}
		}
//		rNo 리뷰No
		int parentSeq = reviewDto.getrNo();
		
//		리뷰 사진을 리스트에 저장하는데 다른 패키지의 메서드 fileUtile를 활용
		List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(parentSeq, mulRequest);
		
//		for문을 이용하여 리스트에 저장된 review 한개씩 업로드
		for(int i=0; i<list.size(); i++) {
			reviewDao.insertFile(list.get(i));
		}
		
	}
	
	/** Read
	 *  
	 */
	//item리스트에서 리뷰 수에 따라서 정렬을 변겅하기 위한 코드
	@Override
	public int reviewSelectTotalReviewCount(int iNo){
		return reviewDao.reviewSelectTotalReviewCount(iNo);
	}
	//모든 리뷰를 가져오기 위한 코드
	@Override
	public List<Map<String, Object>> reviewSelectList(int iNo, int start, int end){
		
		List<ReviewDto> reviewList= reviewDao.reviewSelectList(iNo, start, end);
		
		List<Map<String, Object>> list = new ArrayList<>();
		// 리뷰 수 만큼 사진 리뷰와 사진을 매칭해서 리스트에 저장
		for (ReviewDto reviewDto : reviewList) {
			Map<String, Object> map = new HashMap<String, Object>();

			int rNo = reviewDto.getrNo();
			
			Map<String, Object> fileMap = reviewDao.fileSelectOne(rNo);
			
			map.put("fileMap", fileMap);
			map.put("reviewDto", reviewDto);
			
			list.add(map);
		}
		return list;
	}
	
	@Override
	public Map<String, Object> reviewSelectOne(int rNo){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ReviewDto reviewDto = reviewDao.reviewSelectOne(rNo);
		resultMap.put("reviewDto", reviewDto);
		//item에서 fileList를 썼기 때문에 혹시 모를 버그를 위해서 변수명을 fileList2로 함
		List<Map<String, Object>> fileList2 = reviewDao.fileSelectList(rNo);
		resultMap.put("fileList2", fileList2);
		
		return resultMap;
		
	}
	
	/** Update
	 *  업데이트를 하기 위해서는 Info와 파일을 업데이트 해야 하는데 하나라도 실패할 경우
	 *  롤백하기 위해서 Transactional을 사용함 
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int reviewUpdateOne(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest
			, int imgNo) throws Exception {

		int resultNum = 0;

		try {
			resultNum = reviewDao.reviewUpdateOne(reviewDto);
			
			int rNo = reviewDto.getrNo();
			
			Map<String, Object> tempFileMap2 = reviewDao.fileSelectOne(rNo);
			
			List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(rNo, mulRequest);
			
			// 리스트가 존재 할 경우 수행			
			if(list.isEmpty() == false) {
				
				//review_img테이블에 파일정보가 존재 할 경우
				if(tempFileMap2 != null) {
					//db에서 파일정보 삭제
					reviewDao.fileDelete(rNo);
					//실제 드라이브에 파일을 삭제
					fileUtiles.parseUpdateFileInfo(tempFileMap2);
				}
				
				for(Map<String, Object> map : list) {
					//db에 파일정보를 추가
					reviewDao.insertFile(map);
					
				}
			// 이미지를 삭제해서 존재하지 않을 때
			} else if(imgNo == -1){
				
				if(tempFileMap2 != null){
					//db에서 파일정보 삭제
					reviewDao.fileDelete(rNo);
					//실제 드라이브에 파일을 삭제
					fileUtiles.parseUpdateFileInfo(tempFileMap2);
					
				}
			}
			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus()
			.setRollbackOnly();
		}
		
		return resultNum;
	}
	
	@Override
	public void reviewDeleteOne(int rNo) {
		reviewDao.reviewDeleteOne(rNo);
	}

	@Override
	public List<Map<String, Object>> getOrderList(int uNo) {
		
		return reviewDao.getOrderList(uNo);
	}
	
	
}
