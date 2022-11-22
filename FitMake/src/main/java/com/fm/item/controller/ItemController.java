package com.fm.item.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.item.model.ItemDto;
import com.fm.item.service.ItemService;

@Controller
public class ItemController {
	private static final Logger logger
		= LoggerFactory.getLogger(ItemController.class);
	
	@Autowired
	private ItemService itemService;
	
	
/**
 * Create!!! Item Add
 * @param itemDto
 * @param mulRequest
 * @param model
 * @return MultipartHttpServletRequest mulRequest
 *  나중에 sub을 사용할 때 사용하기
 */
	@RequestMapping(value = "/item/add.do", method = { RequestMethod.GET, RequestMethod.POST})
	public String itemAdd(Model model) {
		logger.trace("제품 추가해봅시다!" + model);
//		return "redirect:/item/list.do"; mapping 한 주소로
		return "/item/ItemAdd"; // jsp 주소로
	}
	
	@RequestMapping(value = "/item/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST})
	public String itemAddCtr(ItemDto itemDto, Model model,
			MultipartHttpServletRequest mulRequest) {
		logger.trace("제품 추가합니다!" + itemDto);
		try {
			itemService.itemInsertOne(itemDto, mulRequest);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("예외임");
			e.printStackTrace();
		}
		return "redirect:/item/list.do";
	}
	
	/**
	 * Read!!!
	 * @param itemDto
	 * @param model spirng에서 지원해준 화면 구성을 위해서 받아온 객체
	 * @return
	 * 1단계 리스트 나오는지 확인
	 * 2단계 검색 기능 넣고서 나오는지 확인
	 * 3단계 페이징 확인
	 */
//	@RequestMapping(value="/item/list.do", method = {RequestMethod.GET, RequestMethod.POST})
//	public String itemList(int iNo, Model model) {
//		logger.trace("제품 리스트로 옴" + model);
//		
//		Map<String, Object> map = itemService.itemSelectOne(itemDto.getiNo());
//		List<ItemDto> itemList = itemService.itemSelectList();
//		
//		ItemDto itemDto2 = (ItemDto) map.get("itemDto");
//		
//		List<Map<String, Object>> fileList 
//			= (List<Map<String, Object>>) map.get("fileList");
//		
//		model.addAttribute("itemDto", itemDto2);
//		model.addAttribute("itemList", itemList);
//		model.addAttribute("fileList", fileList);
//		
//		return "/item/Category";
//	}
	
	@RequestMapping(value="/item/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String itemList(int cNo, Model model) {
		logger.trace("제품 리스트로 옴" + model);
		
		List<Map<String, Object>> itemList = itemService.itemSelectList(cNo);
		
		model.addAttribute("itemList", itemList);
		
		return "/item/Category";
	}
	
	
	@RequestMapping(value="/item/one.do")
	public String itemOne(int no, Model model) {
		logger.trace("제품 상세정보" + model);
		
		Map<String, Object> map = itemService.itemSelectOne(no);
		
		ItemDto itemDto = (ItemDto) map.get("itemDto");
//		List<Map<String, Object>> fileList
		
		model.addAttribute("itemDto", itemDto);
		
		return "/item/ItemOne";
		
	}
	
	
	/**
	 * Update!!!!!!!
	 * @param iNo를 Service랑 Dao는 안해도 되는데 왜 여기만 꼭 마바티스에서 바꿔준 걸로 써야할까? 
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/item/update.do", method = RequestMethod.GET)
	public String itemUpdate(int iNo, Model model) {
		logger.trace("수정하는 DB에 접속"+ iNo);
		
		Map<String, Object> map = itemService.itemSelectOne(iNo);
		
		ItemDto itemDto = (ItemDto)map.get("itemDto");
		
		model.addAttribute("itemDto", itemDto);
		
		return "item/ItemUpdate";
	}
	
	@RequestMapping(value="/item/updateCtr.do", method = RequestMethod.POST)
	public String itemUpdateCtr(HttpSession session, ItemDto itemDto, Model model) {
		logger.trace("수정하기"+itemDto);
		
		int resultNum = 0;
		
		try {
			resultNum = itemService.itemUpdateOne(itemDto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		ItemDto sessionItemDto = (ItemDto)session.getAttribute("itemDto");
		if(sessionItemDto != null) {
			if(sessionItemDto.getiNo() == itemDto.getiNo() ) {
				
				ItemDto newItemDto = new ItemDto();
				
				newItemDto.setiNo(itemDto.getiNo());
				newItemDto.setiName(itemDto.getiName());
				newItemDto.setiSellprice(itemDto.getiSellprice());
				newItemDto.setiCount(itemDto.getiCount());
				
				session.removeAttribute("itemDto");
				session.setAttribute("itemDto", newItemDto);
			}
		}
	
		return "redirect:/item/list.do";
	}
	
	
	@RequestMapping(value="/item/deleteOne.do", method = RequestMethod.GET)
	public String itemDelete(int iNo, Model model) {
		logger.info("삭제기능" + iNo);
		
		itemService.itemDeleteOne(iNo);
		
		return "redirect:/item/list.do";
		
	}
}
