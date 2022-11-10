package com.fm.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.order.model.OrderDto;
import com.fm.user.model.UserDto;

public interface OrderDao {

	public List<Map<String, Object>> orderListView(int uNo);

	public Map<String, Object> orderDetailView(int oNo);

	public int addCart(Map<Integer, Object> inputMap);
	
	
}
