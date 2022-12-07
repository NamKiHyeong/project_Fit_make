package com.fm.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fm.util.Paging;
import com.fm.order.model.CartDto;
import com.fm.order.service.OrderService;
import com.fm.user.model.UserDto;

//어노테이션 드리븐
@Controller
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderService orderService;

	/**
	 * 장바구니 목록 보기 기능
	 * 
	 * @param session 세션에 저장된 userNo(uNo)를 가져오기 위한 객체
	 * @param model   장바구니 목록을 화면에 보내기 위한 객체
	 * @return CartList.jsp 호출
	 */
	@RequestMapping(value = "/cart/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewCartList(HttpSession session, Model model) {
		logger.debug("Welcome CartList");
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();

		List<Map<String, Object>> cartMapList = orderService.viewCartList(uNo);
		
		model.addAttribute("cartMapList", cartMapList);

		return "cart/CartList";
	}

	/**
	 * 비동기 장바구니 추가 기능
	 * @param session 	세션에 저장된 회원번호를 받기 위한 객체
	 * @param model		필요 없음 지금은
	 * @param iNo		장바구니에 등록하고자 하는 제품 번호
	 * @param iCount	장바구니에 등록하고자 하는 제품 갯수
	 * @return			장바구니에 이미 있다면 2 / 성공했다면 1을 반환
	 * @throws Exception
	 */
	  @ResponseBody
	  @RequestMapping(value = "/cart/add.do", method = RequestMethod.POST)
	  public int AddcartAsync(HttpSession session, Model model, @RequestParam(value="iNo[]", defaultValue = "0") int[] iNo
			  , @RequestParam(value="ctCount", defaultValue = "1") int ctCount) throws Exception {
		  logger.debug("welcome CartAdd");
		  
	      UserDto userDto = (UserDto) session.getAttribute("_userDto_");
	      int uNo = (int)userDto.getuNo();
	      
	      for(int i = 0; i < iNo.length; i++) {
		      if(orderService.checkCart(uNo, iNo[i]) != 0) {
		    	  return 2;
		      }
	      }
	      
	      for(int i = 0; i < iNo.length; i++) {
	    	  orderService.addCart(uNo, iNo[i], ctCount);
	      }
	      
	    return 1;
	  }

	 /**
	  * 비동기 카트 수량 업데이트 기능
	  * @param session		회원번호를 가져오기 위한 객체
	  * @param cartDto		업데이트하기 위한 정보를 가지고 있는 객체
	  * @return				성공하면 1을 반환
	  * @throws Exception	
	  */
	  @ResponseBody
	  @RequestMapping(value="/cart/update.do", method = RequestMethod.POST)
	  public int updateCartAsync(HttpSession session, CartDto cartDto) throws Exception {
			logger.debug("Welcome cartUpdate" + cartDto.getCtNo() + "" + cartDto.getCtCount());
			
			UserDto userDto = (UserDto) session.getAttribute("_userDto_");

			cartDto.setuNo(userDto.getuNo());

			orderService.updateCart(cartDto);
			int totalPrice = orderService.getTotalCartPrice(userDto.getuNo());
			
			
			return totalPrice;
		}	  
	  
	/**
	 * 비동기 장바구니 제품 삭제 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param ctNo		장바구니번호
	 * @return			성공하면 1을 반환
	 */
	@ResponseBody
	@RequestMapping(value = "/cart/delete.do", method = RequestMethod.POST)
	public int deleteCartAsync(HttpSession session, @RequestParam(value="ctNo") int ctNo) {
		logger.debug("welcome cartDelete");

		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		orderService.deleteCart(uNo, ctNo);

		return 1;
	}
	
	/**
	 * 장바구니 드롭다운 내용을 호출하는 기능
	 * @param session	회원번호를 얻기 위한 객체
	 * @return			장바구니 제품 리스트를 반환
	 */
	  @ResponseBody
	  @RequestMapping(value = "/cart/summary.do", method = RequestMethod.GET)
	  public List<Map<String, Object>> viewCartHeadListAsync(HttpSession session) {
			logger.debug("Welcome CartList");
				
			UserDto userDto = (UserDto) session.getAttribute("_userDto_");
			if(userDto == null) {
				List<Map<String, Object>> cartMapList = null;
				return cartMapList;
			} else {
				int uNo = (int) userDto.getuNo();
				
				List<Map<String, Object>> cartMapList = orderService.viewCartList(uNo);
				return cartMapList;
			}
			
	  }
	
	/**
	 * 주문관리 페이지 리스트를 호출 할 때 사용하는 메서드
	 * 
	 * @param session 세션에 담긴 내 번호를 가져와서 호출함
	 * @param model   화면 구성을 위해 DB 정보를 받아와 전송하기 위한 변수
	 * @return 여러 테이블에서 데이터를 가져오므로 Map에 담아서 반환함
	 */
	@Transactional
	@RequestMapping(value = "/order/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewOrderList(HttpSession session, Model model
			, @RequestParam(defaultValue = "1") int curPage
			, @RequestParam(defaultValue = "user") String searchOption
			, @RequestParam(defaultValue = "") String searchText) {
		logger.info("Welcome orderList!");
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		String viewUrl = "";
		
		
		int totalCount = orderService.getOrderTotalCount(uNo, searchOption, searchText);
		
		Paging orderPaging = new Paging(totalCount, curPage);
		
		int start = orderPaging.getPageBegin();
		int end = orderPaging.getPageEnd();
		
		List<Map<String, Object>> orderMapList = orderService.viewOrderList(uNo, searchOption, searchText, start, end);
		
		Map<String, Object> oPagingMap = new HashMap<String, Object>();
		oPagingMap.put("orderPaging", orderPaging); 
		oPagingMap.put("totalCount",totalCount);
		oPagingMap.put("start", start);
		oPagingMap.put("end", end);
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("searchOption", searchOption);
		searchMap.put("searchText", searchText);
		
		model.addAttribute("orderMapList", orderMapList);
		model.addAttribute("searchMap", searchMap);
		model.addAttribute("oPagingMap", oPagingMap);
		
		if(uNo == 1) {
			viewUrl = "order/OrderManage";
		} else {
			viewUrl = "order/MyOrder";
		}
		
		return viewUrl;
	}

	/**
	 * 주문하기 기능
	 * 
	 * @param session 세션에 저장된 uNo를 가져오기 위한 객체
	 * @param model   화면 구성을 위한 객체
	 * @param iNo     제품번호
	 * @param iCount  구매하고자 하는 제품 갯수
	 * @param iPrice  제품 가격
	 * @param ctNo     장바구니 번호
	 * @return 주문이 완료 된 후 주문 리스트 jsp를 호출한다
	 */
	@Transactional
	@RequestMapping(value = "/order/add.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String addOrder(HttpSession session, Model model, RedirectAttributes redirect, 
			@RequestParam(defaultValue = "0") int[] iNo,
			@RequestParam(defaultValue = "1") int[] ctCount, @RequestParam(defaultValue = "0") int[] iSellprice,
			@RequestParam(defaultValue = "0") int[] ctNo) {
		logger.debug("welcome orderAdd");
		logger.debug("welcome ctCount" + ctCount[0]);
		logger.debug("welcome ctNo" + ctNo[0]);
		logger.debug("welcome iNo" + iNo[0]);
		logger.debug("welcome iSellprice" + iSellprice[0]);
		logger.debug("welcome ctNo.length" + ctNo.length);
		logger.debug("welcome ctNo.length" + ctCount.length);
		logger.debug("welcome ctNo.length" + iSellprice.length);
		logger.debug("welcome iNo.length" + iNo.length);
		
		String viewUrl = "";
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		int oNo = 0;
		
		if (ctNo[0] == 0) {

			orderService.addOrder(uNo);
			orderService.addOrderDetail(uNo, iNo[0], ctCount[0], iSellprice[0]);
			oNo = orderService.viewOrderNo(uNo);
			
			redirect.addAttribute("oNo", oNo);
			
			viewUrl = "redirect:/order/check.do";
		} else if (ctNo.length > 0) {

			orderService.addOrder(uNo);
			oNo = orderService.viewOrderNo(uNo);
			
			for (int i = 0; i < iNo.length; i++) {
				orderService.addOrderDetail(uNo, iNo[i], ctCount[i], iSellprice[i]);
			}
			
			redirect.addAttribute("ctNo", ctNo);
			redirect.addAttribute("oNo", oNo);
			
			viewUrl = "redirect:/order/check.do";
		} else {
			viewUrl = "/main/MainPage";
		}

		return viewUrl;
	}

	/**
	 * 주문 상태를 업데이트 하는 기능
	 * @param session
	 * @param model
	 * @param oNoArr		업데이트 하고자 하는 주문번호의 집합
	 * @param oStatusArr	업데이트 하고자 하는 주문상태
	 * @return
	 */
	@Transactional
	@RequestMapping(value = "/order/update.do", method = RequestMethod.POST)
	public String updateOrder(HttpSession session, Model model, @RequestParam(defaultValue = "0") int[] oNoArr,
			@RequestParam(defaultValue = "0") String[] oStatusArr) {
		logger.debug("welcome orderUpdate");
		
		for(int i = 0; i < oNoArr.length ; i++) {
			orderService.updateOrder(oNoArr[i], oStatusArr[i]);
		}
		
		return "redirect:/order/list.do";
	}

	
	@Transactional
	@RequestMapping(value = "/order/detail.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String viewOrderConfirm(HttpSession session, Model model, @RequestParam(defaultValue = "0") int oNo) {
		logger.info("Welcome orderDetail!");
		logger.info("oNo" + oNo);

		String viewUrl = "";
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();

		if(uNo > 0) {
			
			List<Map<String, Object>> orderDetailItemList = orderService.viewOrderDetailItem(oNo);
			Map<String, Object> orderDetailMyInfo = orderService.viewMyInfo(uNo);
			
			model.addAttribute("orderDetailItemList", orderDetailItemList);
			model.addAttribute("orderDetailMyInfo", orderDetailMyInfo);
			model.addAttribute("oNo", oNo);
			
			viewUrl = "/order/MyOrderDetail";
		} else {
			viewUrl = "redirect:/auth/login.do";
		}
		return viewUrl;
	}
	

	/**
	 * 주문상세 및 확인 페이지를 호출하는 메서드
	 * 
	 * @param session 세션의 uNo를 사용하게 되면 사용할 수 있도록 session을 받아놓음
	 * @param model   화면 구성을 위해 DB 정보를 받아와 전송하기 위한 변수
	 * @param oNo     주문목록 화면에서 주문 번호를 받아와 DB에 매개변수로 넣음
	 * @return DB에서 Map으로 받은 값을 OrderDetail.jsp 페이지로 전송
	 */
	@Transactional
	@RequestMapping(value = "/order/check.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String viewOrderDetail(HttpSession session, Model model, @RequestParam(defaultValue = "0") int oNo, 
			@RequestParam(value="ctNo", defaultValue = "-1") int[] ctNo) {
		logger.info("Welcome orderDetail!");
		logger.info("ctNo" + ctNo[0]);
		logger.info("oNo" + oNo);

		String viewUrl = "";
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();

		if (uNo > 0) {
			oNo = orderService.viewOrderNo(uNo);
			List<Map<String, Object>> orderConfirmItemList = orderService.viewOrderConfirmItem(oNo);
			Map<String, Object> orderConfirmMyInfo = orderService.viewMyInfo(uNo);
			
			model.addAttribute("orderConfirmItemList", orderConfirmItemList);
			model.addAttribute("orderConfirmMyInfo", orderConfirmMyInfo);
			model.addAttribute("ctNo", ctNo);
			model.addAttribute("oNo", oNo);
			
			viewUrl = "/order/OrderConfirm";
		} else {
			viewUrl = "redirect:../auth/Login.do";
		}
		return viewUrl;
	}
	/**
	 * 주문 확인에서 구매를 결정하거나 취소하는 단계
	 * @param session 	세션에 저장된 uNo를 가져오기 위한 객체
	 * @param ctNo		장바구니에 담긴 아이템을 삭제하기 위한 장바구니 제품번호
	 * @return			주문리스트 호출
	 */
	@Transactional
	@RequestMapping(value="/order/confirm.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String orderConfirm(HttpSession session, @RequestParam(value="ctNo", defaultValue = "0") int[] ctNo) {
		logger.debug("Welcome orderConfirm");
		
		String viewUrl = "";
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		if(ctNo[0] != 0) {
			
			for (int i = 0; i < ctNo.length; i++) {
				orderService.deleteCart(uNo, ctNo[i]);
			}
			
			viewUrl = "/order/OrderSuccess";
		} else {
			viewUrl = "redirect:/order/list.do";
		}
		return viewUrl;
	}
	
	/** 
	 * orderconfirm 화면에서 주문 취소를 했을 경우 order를 삭제
	 * @param session	세션의 uNo를 얻기 위한 객체
	 * @param model		화면 구성을 위한 객체
	 * @param oNo		삭제 시 
	 * @return
	 */
	@RequestMapping(value="/order/cancel.do", method=RequestMethod.POST)
	public String orderConfirmDelete(HttpSession session, Model model,
			@RequestParam int oNo) {
		
		String viewUrl = "";
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		orderService.deleteOrder(uNo, oNo);
		
		viewUrl="redirect:../cart/list.do";
		
		return viewUrl;
	}
	
	@ResponseBody
	@RequestMapping(value="/order/count.do", method= {RequestMethod.POST, RequestMethod.GET})
	public Map<String, Object> countMyOrderStatus(HttpSession session) {
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		Map<String, Object> orderStatusMap = orderService.countMyOrderStatus(uNo);
		
		return orderStatusMap;
	}
	  
}
