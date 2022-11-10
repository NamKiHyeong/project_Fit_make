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
	
	/**
	 * 주문관리 페이지 리스트를 호출 할 때 사용하는 메서드 
	 * @param session 세션에 담긴 내 번호를 가져와서 호출함
	 * @param model 추후 사용을 위해 생성 해놓음
	 * @return 여러 테이블에서 데이터를 가져오므로 Map에 담아서 반환함
	 */
	@RequestMapping(value = "/order/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String OrderList(HttpSession session, Model model) {
		logger.info("Welcome UserController login! ");
		
		List<Map<String, Object>> orderListMap = orderService.orderListView((int)session.getAttribute("uNo"));
		
		model.addAttribute("orderListMap", orderListMap);
		
		return "order/OrderManage";
	}
	
	@RequestMapping(value = "/order/detail.do", method = RequestMethod.POST)
	public String login(HttpSession session, Model model, int oNo) {
		logger.info("Welcome UserController login! ");
		
		Map<String, Object> orderDetailMap = orderService.orderDetailView(oNo);
		
		return "order/OrderManage";
	}
	

}
