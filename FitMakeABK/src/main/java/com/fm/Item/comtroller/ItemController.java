package com.fm.Item.comtroller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.Item.model.ItemDto;
import com.fm.Item.service.ItemService;

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
 * @return category.jsp -> categoryNo에 따라 가도록 변경
 * 
 */
	@RequestMapping(value = "/item/itemAdd.do", method = RequestMethod.POST)
	public String itemAdd(ItemDto itemDto, MultipartHttpServletRequest mulRequest,
			Model model) {
		logger.trace("제품이 추가되었습니다!" + itemDto);
		try {
			itemService.itemInsertOne(itemDto, mulRequest);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/item/category.jsp";
	}
	
	
	
}
