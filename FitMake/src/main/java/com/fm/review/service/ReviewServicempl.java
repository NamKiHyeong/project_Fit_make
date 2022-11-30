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
	public List<Map<String, Object>> reviewSelectList(int iNo){
		
		List<ReviewDto> reviewList= reviewDao.reviewSelectList(iNo);
		
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
		resultMap.put("reviewDto", reviewDto);
		
		List<Map<String, Object>> fileList = reviewDao.fileSelectList(rNo);
		resultMap.put("fileList", fileList);
		
		return resultMap;
		
	}
}
