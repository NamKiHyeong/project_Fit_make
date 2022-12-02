package com.fm.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.transaction.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.order.dao.OrderDao;
import com.fm.order.model.CartDto;
import com.fm.order.model.OrderDto;

@Service
public class OrderServiceImpl implements OrderService {

	private static final Logger log = LoggerFactory.getLogger(OrderServiceImpl.class);

	@Autowired
	public OrderDao orderDao;

	@Override
	public List<Map<String, Object>> viewCartList(int uNo) {
		
		return orderDao.viewCartList(uNo);
	}
	
	@Override
	public int addCart(int uNo, int iNo, int iCount) {
		log.debug("uNo: " + uNo, " iNo : " + iNo, "icount : " + iCount);
		return orderDao.addCart(uNo, iNo, iCount);
	}
	
	@Override
	public int deleteCart(int uNo, int ctNo) {
		
		return orderDao.deleteCart(uNo, ctNo);
	}
	
	@Override
	public List<Map<String, Object>> viewOrderList(int uNo, String searchOption, String searchText, int start, int end) {
		
		return orderDao.viewOrderList(uNo, searchOption, searchText, start, end);
	}
	
	@Override
	public int addOrder(int uNo) {
		
		return orderDao.addOrder(uNo);
	}

	@Override
	public List<Map<String, Object>> viewOrderConfirmItem(int oNo) {
		
		return orderDao.viewOrderConfirmItem(oNo);
	}

	@Override
	public Map<String, Object> viewMyInfo(int uNo) {
		return orderDao.viewMyInfo(uNo);
	}
	
	@Override
	public int addOrderDetail(int uNo, int iNo, int iCount, int price) {
		
		return orderDao.addOrderDetail(uNo, iNo, iCount, price);
	}

	@Override
	public int updateCart(CartDto cartDto) {
		
		return orderDao.updateCart(cartDto);
	}

	@Override
	public int viewOrderNo(int uNo) {
		
		return orderDao.viewOrderNo(uNo);
	}

	@Override
	public int deleteOrder(int uNo, int oNo) {
		
		return orderDao.deleteOrder(uNo, oNo);
	}
	
	@Override
	public void updateOrder(int oNo, String oStatus) {
		
		orderDao.updateOrder(oNo, oStatus);
	}

	@Override
	public int getOrderTotalCount(int uNo, String searchOption, String searchText) {
		
		return orderDao.getOrderTotalCount(uNo, searchOption, searchText);
	}

	@Override
	public int checkCart(int uNo, int iNo) {
		
		return orderDao.checkCart(uNo, iNo);
	}

	@Override
	public List<Map<String, Object>> viewCartFileList(int uNo) {
		
		return orderDao.viewCartFileList(uNo);
	}

	@Override
	public Map<String, Object> countMyOrderStatus(int uNo) {
		
		
		
		Map<String, Object> resultMap= new HashMap<String, Object>();
		resultMap.put("oPending", orderDao.countMyOrderStatus(uNo, "pending"));
		resultMap.put("oConfirm", orderDao.countMyOrderStatus(uNo, "confirm"));
		resultMap.put("oPixed", orderDao.countMyOrderStatus(uNo, "pixed"));
		
		
		return resultMap;
	}

	@Override
	public Map<String, Object> viewOrderDetailItem(int oNo) {
		
		return orderDao.viewOrderDetailItem(oNo);
	}

}
