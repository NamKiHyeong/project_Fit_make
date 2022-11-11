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
import com.fm.util.BmiCalc;
import com.fm.util.Paging;

import javafx.beans.DefaultProperty;

//어노테이션 드리븐
@Controller
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderService orderService;
	
	/**
	 * 장바구니 추가 기능
	 * @param session 	세션에 있는uNo를 가지고 오기 위한 객체
	 * @param model		화면 구성을 위한 객체
	 * @param iNo		장바구니에 추가할 제품번호
	 * @param iCount 	장바구니에 추가할 제품갯수
	 * @return			화면에서 이동할 것인지 아닌지 선택한 값을 통해 다르게 리턴 
	 */
	@RequestMapping(value = "/cart/add.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String addCart(HttpSession session, Model model, 
			@RequestParam(defaultValue = "0") int iNo, 
			@RequestParam(defaultValue = "0") int iCount) {
		logger.info("Welcome orderCart!");
		
		session.setAttribute("uNo", 1);
		int resultNum = 0;
		
		int uNo = (int)session.getAttribute("uNo"); 
		iNo = 1;
		iCount = 3;
		
		resultNum = orderService.addCart(uNo, iNo, iCount);
		
		// 화면에서 남아 있을것인지 아닌지 확인 받아서 들어온 값에 따라 리턴을 다르게 한다
		return "redirect:/cart/list.do";
	}
	
	/**
	 * 장바구니 목록 보기 기능
	 * @param session 	세션에 저장된 userNo(uNo)를 가져오기 위한 객체
	 * @param model		장바구니 목록을 화면에 보내기 위한 객체
	 * @return			CartList.jsp 호출
	 */
	@RequestMapping(value = "/cart/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String viewCartList(HttpSession session, Model model) {
		
		session.setAttribute("uNo", 1);
		
		List<Map<String, Object>> cartMapList = orderService.viewCartList((int)session.getAttribute("uNo"));
		
		model.addAttribute("cartMapList", cartMapList);
		
		return "cart/CartList";
	}
	
	@RequestMapping(value = "/cart/delete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteCart(HttpSession session, Model model, int cNo) {
		
		session.setAttribute("uNo", 1);
		
		int resultNum = 0;
		int uNo = (int)session.getAttribute("uNo");
		
		resultNum = orderService.deleteCart(uNo, cNo);
		
		return "redirect:/cart/list.do";
	}
	
	
	/**
	 * 주문관리 페이지 리스트를 호출 할 때 사용하는 메서드 
	 * @param session 세션에 담긴 내 번호를 가져와서 호출함
	 * @param model 화면 구성을 위해 DB 정보를 받아와 전송하기 위한 변수
	 * @return 여러 테이블에서 데이터를 가져오므로 Map에 담아서 반환함
	 */
	@RequestMapping(value = "/order/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String orderList(HttpSession session, Model model) {
		logger.info("Welcome orderList!");
		// 세션의 사용자 번호를 임시로 1로 지정
		session.setAttribute("uNo", 1);
		
		List<Map<String, Object>> orderListMap = orderService.orderListView((int)session.getAttribute("uNo"));
		
		model.addAttribute("orderListMap", orderListMap);
			
		return "order/OrderManage";
	}

	/**
	 * 주문상세페이지를 호출하는 메서드
	 * @param session 세션의 uNo를 사용하게 되면 사용할 수 있도록 session을 받아놓음
	 * @param model 화면 구성을 위해 DB 정보를 받아와 전송하기 위한 변수
	 * @param oNo 주문목록 화면에서 주문 번호를 받아와 DB에 매개변수로 넣음
	 * @return	DB에서 Map으로 받은 값을 OrderDetail.jsp 페이지로 전송
	 */
	@RequestMapping(value = "/order/detail.do", method = RequestMethod.POST)
	public String orderDetail(HttpSession session, Model model, int oNo) {
		logger.info("Welcome orderDetail!");
		
		Map<String, Object> orderDetailMap = orderService.orderDetailView(oNo);
		
		model.addAttribute("orderDetailMap", orderDetailMap);
		
		return "order/OrderDetail";
	}
	
}
