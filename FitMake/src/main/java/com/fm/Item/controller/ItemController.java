package com.fm.Item.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fm.Item.service.ItemService;

//import com.fm.item.controller.UserController;
//import com.fm.item.model.UserDto;
//import com.fm.item.service.UserService;
//import com.fm.item.Paging;

@Controller
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Autowired
	private ItemService itemService;
	
	
	@RequestMapping(value = "/item/categorytest.do", method = RequestMethod.GET)
	public String categorytest(HttpSession session, Model model) {
		logger.info("다이어트 사이트 옴");
		
		return "category/diet";
		
	}
		
}
