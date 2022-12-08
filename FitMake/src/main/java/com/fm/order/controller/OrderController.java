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
	 * 	장바구니 리스트 불러오기
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param model		화면 구성을 위한 객체
	 * @return			장바구니 제품 리스트 반환
	 */
	@RequestMapping(value = "/cart/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewCartList(HttpSession session, Model model) {
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();

		List<Map<String, Object>> cartMapList = orderService.viewCartList(uNo);
		
		model.addAttribute("cartMapList", cartMapList);

		return "cart/CartList";
	}

	/**
	 * 비동기 장바구니 추가 기능
	 * @param session	회원 번호를 가져오기 위한 객체
	 * @param iNo		제품 번호
	 * @param ctCount	장바구니에 저장하고 싶은 제품 갯수
	 * @return			장바구니에 있는지 확인을 하고 있다면 2를 반환 / 없다면 추가 후 1을 반환
	 */
	  @ResponseBody
	  @RequestMapping(value = "/cart/add.do", method = RequestMethod.POST)
	  public int AddcartAsync(HttpSession session, Model model, @RequestParam(value="iNo[]", defaultValue = "0") int[] iNo
			  , @RequestParam(value="ctCount", defaultValue = "1") int ctCount) throws Exception {
		  
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
	 * 장바구니 수량 업데이트 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param cartDto	DB업데이트에 필요한 정보를 가져오는 객체
	 * @return			DB업데이트 후 금액을 반환
	 * @throws Exception
	 */
	  @ResponseBody
	  @RequestMapping(value="/cart/update.do", method = RequestMethod.POST)
	  public int updateCartAsync(HttpSession session, CartDto cartDto) throws Exception {
			
			UserDto userDto = (UserDto) session.getAttribute("_userDto_");

			cartDto.setuNo(userDto.getuNo());

			orderService.updateCart(cartDto);
			int totalPrice = orderService.getTotalCartPrice(userDto.getuNo());
			
			
			return totalPrice;
		}	  
	  
	/**
	 * 장바구니 삭제
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param ctNo		장바구니에 등록된 제품의 장바구니 번호
	 * @return			성공하면 1 / 실패하면 2
	 */
	@ResponseBody
	@RequestMapping(value = "/cart/delete.do", method = RequestMethod.POST)
	public int deleteCartAsync(HttpSession session, @RequestParam(value="ctNo") int ctNo) {

		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		int result = orderService.deleteCart(uNo, ctNo);

		return result;
	}
	
	/**
	 * 장바구니 요약정보를 보여주기 위한 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @return			회원이 가지고 있는 장바구니 리스트를 반환
	 */
	 @ResponseBody
	 @RequestMapping(value = "/cart/summary.do", method = RequestMethod.GET)
	 public List<Map<String, Object>> viewCartHeadListAsync(HttpSession session) {
				
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
	 * 주문리스트를 확인 기능
	 * @param session		회원번호를 가져오기 위한 객체
	 * @param model			화면 구성을 위한 객체
	 * @param curPage		현재 페이지 번호
	 * @param searchOption	검색 옵션
	 * @param searchText	검색어
	 * @return				주문리스트를 반환
	 */
	@Transactional
	@RequestMapping(value = "/order/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewOrderList(HttpSession session, Model model
			, @RequestParam(defaultValue = "1") int curPage
			, @RequestParam(defaultValue = "user") String searchOption
			, @RequestParam(defaultValue = "") String searchText) {
		
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
	 * 주문 추가를 위한 기능
	 * @param session		회원번호를 가져오기 위한 객체
	 * @param redirect		다른 매핑된 주소로 보내기 위한 객체
	 * @param iNo			주문에 등록하고자 하는 제품 번호
	 * @param ctCount		장바구니에 저장된 제품 갯수 / 바로 구매를 누르면 1
	 * @param iSellprice	제품 가격
	 * @param ctNo			장바구니에 등록된 제품 번호 / 없다면 0
	 * @return
	 */
	@Transactional
	@RequestMapping(value = "/order/add.do", method = {RequestMethod.POST })
	public String addOrder(HttpSession session, Model model, RedirectAttributes redirect, 
			@RequestParam(defaultValue = "0") int[] iNo,
			@RequestParam(defaultValue = "1") int[] ctCount, @RequestParam(defaultValue = "0") int[] iSellprice,
			@RequestParam(defaultValue = "0") int[] ctNo) {
		
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
	 * 주문 상태 업데이트
	 * @param session		회원번호를 얻기 위한 객체
	 * @param oNoArr		업데이트 하고자 하는 주문번호 리스트
	 * @param oStatusArr	업데이트 하고자 하는 주문상태
	 * @return				주문리스트로 리다이렉트
	 */
	@Transactional
	@RequestMapping(value = "/order/update.do", method = RequestMethod.POST)
	public String updateOrder(HttpSession session, Model model, @RequestParam(defaultValue = "0") int[] oNoArr,
			@RequestParam(defaultValue = "0") String[] oStatusArr) {
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		Map<String, Object> refundMap= new HashMap<String, Object>();
				
		for(int i = 0; i < oNoArr.length ; i++) {
			orderService.updateOrder(oNoArr[i], oStatusArr[i]);
			if(oStatusArr[i].equals("cancel")) {
				refundMap = orderService.getPointHistory(oNoArr[i], uNo);
				orderService.updatePoint(uNo, Integer.parseInt(String.valueOf(refundMap.get("FM_POINT_HISTORY"))), oNoArr[i]);
				orderService.addPointHistory(uNo, Integer.parseInt(String.valueOf(refundMap.get("FM_POINT_HISTORY"))), oNoArr[i]);
				
			}
		}
		
		return "redirect:/order/list.do";
	}

	/**
	 * 주문상세확인
	 * @param session	회원번호를 얻기 위한 객체
	 * @param model		화면구성을 위한 객체
	 * @param oNo		확인하고자 하는 주문 번호
	 * @return			
	 */
	@Transactional
	@RequestMapping(value = "/order/detail.do", method = { RequestMethod.POST})
	public String viewOrderDetail(HttpSession session, Model model, @RequestParam(defaultValue = "0") int oNo) {

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
	 * 주문확정 전 확인 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param model		화면 구성을 위한 객체
	 * @param oNo		주문하고자 하는 주문 번호
	 * @param ctNo		주문하고자 하는 제품의 장바구니 번호 / 장바구니에 등록이 되어있지 않다면 -1
	 * @return
	 */
	@Transactional
	@RequestMapping(value = "/order/check.do", method = { RequestMethod.POST, RequestMethod.GET})
	public String viewOrderConfirm(HttpSession session, Model model, @RequestParam(defaultValue = "0") int oNo, 
			@RequestParam(value="ctNo", defaultValue = "-1") int[] ctNo) {

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
	 * 주문확정 기능
	 * @param session			회원 번호를 가져오기 위한 객체
	 * @param ctNo				주문 확정 후 삭제할 장바구니 제품 번호 리스트
	 * @param orderTotalPrice	포인트 차감을 위한 주문 총 금액
	 * @param oNo				주문 확정 할 주문 번호
	 * @return
	 */
	@Transactional
	@RequestMapping(value="/order/confirm.do", method = {RequestMethod.POST})
	public String orderConfirm(HttpSession session, @RequestParam(value="ctNo", defaultValue = "0") int[] ctNo
			, @RequestParam int orderTotalPrice
			, @RequestParam int oNo) {
		logger.debug("Welcome orderConfirm");
		
		String viewUrl = "";
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		orderService.updatePoint(uNo, orderTotalPrice, oNo);
		orderService.addPointHistory(uNo, orderTotalPrice, oNo);
		
		if(ctNo[0] != 0) {
			
			for (int i = 0; i < ctNo.length; i++) {
				orderService.deleteCart(uNo, ctNo[i]);
			}
			
			viewUrl = "/order/OrderSuccess";
		} else {
			viewUrl = "/order/OrderSuccess";
		}
		return viewUrl;
	}
	
	/**
	 * 주문확정 전 취소 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @param oNo		삭제하고자 하는 주문 번호
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
	
	/**
	 * 주문상태 Nav에서 주문 갯수를 확인하기 위한 기능
	 * @param session	회원번호를 가져오기 위한 객체
	 * @return			주문번호가 각 몇개인지 반환
	 */
	@ResponseBody
	@RequestMapping(value="/order/count.do", method= {RequestMethod.GET})
	public Map<String, Object> countMyOrderStatus(HttpSession session) {
		
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();
		
		Map<String, Object> orderStatusMap = orderService.countMyOrderStatus(uNo);
		
		return orderStatusMap;
	}
	  
}
