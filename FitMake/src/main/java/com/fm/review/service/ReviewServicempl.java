package com.fm.review.service;

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

import com.fm.review.controller.ReviewController;
import com.fm.review.dao.ReviewDao;
import com.fm.review.model.ReviewDto;
import com.fm.util.FileUtils;


@Service
public class ReviewServicempl implements ReviewService {
	private static final Logger logger
	= LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	public ReviewDao reviewDao;
	
	
	@Resource(name = "fileUtils")
	private FileUtils fileUtiles;
	
	
	@Override
	public void reviewInsert(ReviewDto reviewDto, MultipartHttpServletRequest mulRequest) {
		reviewDao.reviewInsert(reviewDto);
		
//		Iterator<String> iterator = mulRequest.getFileNames(iterator.next());
		MultipartFile multipartFile = null;
		
//		while(iterator.hasNext()) {
//			multipartFile = mulRequest.getFile(iterator.next());
//		}
		
		int parentSql = reviewDto.getrNo();
//		List<Map<String, Object>> list = fileUtiles.parseInsertFileInfo(parentSql, mulRequest);
		
//		for(int i=0; i<list.size(); i++) {
//			reviewDao.insertFile(list.get(i));
//			
//		}
	}
}
