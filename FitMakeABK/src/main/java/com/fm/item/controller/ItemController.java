package com.fm.item.controller;

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
	
	@RequestMapping(value="/item/add.do", method = { RequestMethod.GET, RequestMethod.POST})
	public String inteAdd(ItemDto itemDto, Model model) {
		logger.trace("제품 리스트로 옴" + itemDto);
		
		return "/item/category";
	}
	@RequestMapping(value = "/item/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST})
	public String itemAddCtr(ItemDto itemDto, Model model) {
		logger.trace("제품이 추가되었습니다!" + itemDto);
		try {
//			itemService.itemInsertOne(itemDto, mulRequest);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
//		return "redirect:/item/list.do"; mapping 한 주소로
		return "/item/itemAdd"; // jsp 주소로
	}
	
	
	
}
