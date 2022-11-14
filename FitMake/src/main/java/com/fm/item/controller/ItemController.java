package com.fm.item.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public String itemAdd(ItemDto itemDto, Model model) {
		logger.trace("제품 추가해봅시다!" + itemDto);
//		return "redirect:/item/list.do"; mapping 한 주소로
		return "/item/ItemAdd"; // jsp 주소로
	}
	
	@RequestMapping(value = "/item/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST})
	public String itemAddCtr(ItemDto itemDto, Model model,
			HttpServletRequest mulRequest) {
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
	@RequestMapping(value="/item/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String itemList(Model model) {
		logger.trace("제품 리스트로 옴" + model);
		
		List<ItemDto> itemList = itemService.itemSelectList();
		
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
	
	
}
