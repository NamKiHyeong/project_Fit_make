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
	
	
	@Override
	public void reviewInsert(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest) throws Exception{
		log.info("서비스mpl에서 {} 를 넣을 값임" , reviewDto);
		reviewDao.reviewInsert(reviewDto);
		log.info("서비스mpl에서 {} 를 넣은 값임" , reviewDto);
		
		Iterator<String> iterator = mulRequest.getFileNames();
		MultipartFile multipartFile = null;
//		
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
		int parentSeq = reviewDto.getrNo();
		log.info("서비스 mpl에서 사진 파일하기 위한 rNo? {}", parentSeq);
		List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(parentSeq, mulRequest);
		
		for(int i=0; i<list.size(); i++) {
			reviewDao.insertFile(list.get(i));
		}
		
	}
	
	
	
	@Override
//	public List<Map<String, Object>> reviewSelectList(int iNo){
		public List<Map<String, Object>> reviewSelectList(int iNo, int start, int end){
//		public List<Map<String, Object>> reviewSelectList(int iNo, String keyword, int start, int end){
		
//		List<ReviewDto> reviewList= reviewDao.reviewSelectList(iNo);
		List<ReviewDto> reviewList= reviewDao.reviewSelectList(iNo, start, end);
//		List<ReviewDto> reviewList= reviewDao.reviewSelectList(iNo, keyword, start, end);
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		for (ReviewDto reviewDto : reviewList) {
			Map<String, Object> map = new HashMap<String, Object>();

			int rNo = reviewDto.getrNo();
			//파일을 못 받아오는 듯하다
			log.info("리뷰 리스트에서 rNo= {}" , rNo);
			Map<String, Object> fileMap = reviewDao.fileSelectOne(rNo);
			log.info("리뷰 리스트에서 fileMap= {}" , fileMap);
			
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
		log.info("서비스mpl에 reviewDto {}" , reviewDto);
		resultMap.put("reviewDto", reviewDto);
		
		List<Map<String, Object>> fileList2 = reviewDao.fileSelectList(rNo);
		log.info("서비스mpl에 fileList2 {}" , fileList2);
		resultMap.put("fileList2", fileList2);
		
		return resultMap;
		
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int reviewUpdateOne(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest
			, int imgNo) throws Exception {

		int resultNum = 0;

		try {
			resultNum = reviewDao.reviewUpdateOne(reviewDto);
			log.info("서비스mpl에서 reviewDto는?? {}", reviewDto);
			
			log.info("서비스mpl에서 업데이트는 성공했나? {}",resultNum);
			int rNo = reviewDto.getrNo();
			
//			
			Map<String, Object> tempFileMap2 = reviewDao.fileSelectOne(rNo);
			log.info("서비스mpl에서 파일 하나를 잘 찾아왔나? {}",tempFileMap2);
			List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(rNo, mulRequest);
			
			log.info("서비스mpl에서 list를 잘 찾아왔나? {}",list);
			
			
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
				log.debug("수정되는 것 확인4", reviewDto.getrTitle());
				
				if(tempFileMap2 != null){
					//db에서 파일정보 삭제
					reviewDao.fileDelete(rNo);
					//실제 드라이브에 파일을 삭제
					fileUtiles.parseUpdateFileInfo(tempFileMap2);
					
					log.debug("수정되는 것 확인5", reviewDto.getrTitle());
				}
			}
			
		} catch (Exception e) {
			log.debug("서비스 mpl에서 예외 발생", reviewDto.getrTitle());
			TransactionAspectSupport.currentTransactionStatus()
			.setRollbackOnly();
		}
		log.debug("수정이 완료되었습니다. {}", reviewDto.getrTitle());
		
		return resultNum;
	}
	
	@Override
	public void reviewDeleteOne(int rNo) {
		reviewDao.reviewDeleteOne(rNo);
	}
	
	@Override
//	public int reviewSelectTotalReviewCount(int iNo, String keyword){
//		return reviewDao.reviewSelectTotalReviewCount(iNo, keyword);
//	}
	
	public int reviewSelectTotalReviewCount(int iNo){
//		public Map<String, Object> reviewSelectTotalReviewCount(int iNo){
		return reviewDao.reviewSelectTotalReviewCount(iNo);
	}
}
