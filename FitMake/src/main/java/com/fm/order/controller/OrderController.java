package com.fm.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.order.model.OrderDto;
import com.fm.order.service.OrderService;
import com.fm.util.Paging;

//어노테이션 드리븐
@Controller
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderService orderService;
	
	
	@RequestMapping(value = "/order/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String OrderList(HttpSession session, Model model) {
		logger.info("Welcome UserController login! ");
		
		List<Map<String, Object>> orderMapList = orderService.orderListView((int)session.getAttribute("uNo"));
		
		model.addAttribute("orderMapList", orderMapList);
		
		return "order/OrderManage";
	}
	
	@RequestMapping(value = "/order/detail.do", method = RequestMethod.POST)
	public String login(HttpSession session, Model model, int oNo) {
		logger.info("Welcome UserController login! ");
		
		Map<String, Object> orderDetailMap = orderService.orderDetailView(oNo);
		
		return "order/OrderManage";
	}
	

}
