package com.fm.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.order.model.CartDto;
import com.fm.order.model.OrderDto;
import com.fm.user.model.UserDto;

public interface OrderService {

	public List<Map<String, Object>> viewCartList(int uNo);

	public int addCart(int uNo, int iNo, int iCount);

	public int deleteCart(int uNo, int ctNo);

	public List<Map<String, Object>> viewOrderList(int uNo, String searchOption, String searchText, int start, int end);
	
	public int addOrder(int uNo);
	
	public List<Map<String, Object>> viewOrderConfirmItem(int oNo);
	
	public List<Map<String, Object>> viewOrderDetailItem(int oNo);

	public Map<String, Object> viewMyInfo(int uNo);

	public int addOrderDetail(int uNo, int iNo, int iCount, int price);

	public int updateCart(CartDto cartDto);

	public int viewOrderNo(int uNo);

	public int deleteOrder(int uNo, int oNo);

	public void updateOrder(int oNo, String oStatus);

	public int getOrderTotalCount(int uNo, String searchOption, String searchText);

	public int checkCart(int uNo, int iNo);

	public Map<String, Object> countMyOrderStatus(int uNo);

	public int getTotalCartPrice(int uNo);

	public void updatePoint(int uNo, int orderTotalPrice, int oNo);

	public void addPointHistory(int uNo, int orderTotalPrice, int oNo);

	public Map<String, Object> getPointHistory(int oNo, int uNo);


}
