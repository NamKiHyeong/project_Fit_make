package com.fm.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtils")
public class FileUtils {
	/**
	 * 맵 업로드 경로
	 */
	private static final String filePath = "C:\\upload";
	
	/**
	 *  파일 업로드를 위한 메소드
	 * @param parentSeq 멤버의 MNO
	 * @param multipartHttpServletRequest 몰라
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> parseInsertFileInfo(int parentSeq, 
			MultipartHttpServletRequest multipartHttpServletRequest) throws Exception{
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		MultipartFile multipartFile = null;
		String originalFileName = null;			//파일 이름
		String originalFileExtension = null; 	//파일 확장자
		String storedFileName = null; 			//중복 방지용
		
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		//DB에 실제 저장할 내용
		Map<String, Object> fileInfoMap = null;
		
		File file = new File(filePath);
		
		if(file.exists() == false) { // 파일경로가 존재하지 않는다면 make directories 를 한다
			file.mkdirs();
		} 
		
		while(iterator.hasNext()) {
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			
			if(multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = CommonUtils.getRandomString() + originalFileExtension;
				
				file = new File(filePath, storedFileName);
				multipartFile.transferTo(file); // 여기서 파일이 생긴다
				
				fileInfoMap = new HashMap<String, Object>();
				fileInfoMap.put("parentSeq", parentSeq);
				fileInfoMap.put("original_file_name", originalFileName);
				fileInfoMap.put("stored_file_name", storedFileName);
				fileInfoMap.put("file_size", multipartFile.getSize());
				
				fileList.add(fileInfoMap);
			}
		}
		
		return fileList;
	}
	
	/**
	 *  기존의 파일이 존재하는데 새로운 파일로 변경되는 경우
	 * @param tempFileMap 기존 파일의 정보를 가지고 있는 맵
	 * @throws Exception 몰라
	 */
	public void parseUpdateFileInfo(Map<String, Object> tempFileMap) 
		throws Exception{
		
		String storedFileName = (String)tempFileMap.get("STORED_FILE_NAME"); 
		
		File file = new File(filePath + "/" + storedFileName);
		
		if(file.exists()) {
			file.delete();
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
		
		
	}
}
