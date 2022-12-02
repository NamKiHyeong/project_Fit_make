package com.fm.order.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.jasper.tagplugins.jstl.core.Choose;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.order.model.CartDto;
import com.fm.order.model.OrderDto;
import com.fm.user.model.UserDto;


@Repository
public class OrderDaoImpl implements OrderDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	String namespace = "com.fm.order.";
	
	@Override
	public List<Map<String, Object>> viewCartList(int uNo) {
		
		return sqlSession.selectList(namespace + "viewCartList", uNo);
	}
	
	@Override
	public int addCart(int uNo, int iNo, int iCount) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("iNo", iNo);
		inputMap.put("uNo", uNo);
		inputMap.put("iCount", iCount);
		
		inputMap.toString();
		
		return sqlSession.insert(namespace + "addCart", inputMap);
	}
	
	@Override
	public int deleteCart(int uNo, int ctNo) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("uNo", uNo);
		inputMap.put("ctNo", ctNo);
				
		return sqlSession.delete(namespace + "deleteCart", inputMap);
	}
	
	@Override
	public List<Map<String, Object>> viewOrderList(int uNo, String searchOption, String searchText
			, int start, int end) {
		
		if(searchOption.equals("user")) {
			searchOption = "u.FM_USER_NICKNAME";
		} else {
			searchOption = "o.FM_ORDER_STATUS";
			
			switch (searchText) {
				case "대기":
					searchText = "pending";
					break;
				case "승인":
					searchText = "confirm";
					break;
				case "취소":
					searchText = "cancel";
					break;
				case "구매확정":
					searchText = "pixed";
					break;	
			}
		}
						
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", uNo);
		inputMap.put("searchOption", searchOption);
		inputMap.put("searchText", searchText);
		inputMap.put("start", start);
		inputMap.put("end", end);
		
		
		return sqlSession.selectList(namespace + "viewOrderList", inputMap);
	}
	
	@Override
	public int addOrder(int uNo) {
		
		return sqlSession.insert(namespace + "addOrder", uNo);
	}
	
	@Override
	public List<Map<String, Object>> viewOrderConfirmItem(int oNo) {
		
		return sqlSession.selectList(namespace + "viewOrderConfirmItem", oNo);
	}

	@Override
	public int addOrderDetail(int uNo, int iNo, int iCount, int price) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("uNo", uNo);
		inputMap.put("iNo", iNo);
		inputMap.put("iCount", iCount);
		inputMap.put("price", price);
		
		return sqlSession.insert(namespace + "addOrderDetail", inputMap);
	}
	
	@Override
	public Map<String, Object> viewOrderConfirmMyInfo(int uNo) {
		
		return sqlSession.selectOne("com.fm.user.userSelectInfo", uNo);
	}

	@Override
	public int updateCart(CartDto cartDto) {
		
		return sqlSession.update(namespace + "updateCart", cartDto);
	}

	@Override
	public int viewOrderNo(int uNo) {
		
		return sqlSession.selectOne(namespace + "viewOrderNo", uNo);
	}

	@Override
	public int deleteOrder(int uNo, int oNo) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("uNo", uNo);
		inputMap.put("oNo", oNo);
		
		return sqlSession.delete(namespace + "deleteOrder", inputMap);
	}

	@Override
	public void updateOrder(int oNo, String oStatus) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("oNo", oNo);
		inputMap.put("oStatus", oStatus);
		
		sqlSession.update(namespace + "updateOrder" , inputMap);
	}

	@Override
	public int getOrderTotalCount(int uNo, String searchOption, String searchText) {
		
		if(searchOption.equals("user")) {
			searchOption = "u.FM_USER_NICKNAME";
		} else {
			searchOption = "o.FM_ORDER_STATUS";
			
			switch (searchText) {
			case "대기":
				searchText = "pending";
				break;
			case "승인":
				searchText = "confirm";
				break;
			case "취소":
				searchText = "cancel";
				break;
			case "구매확정":
				searchText = "pixed";
				break;	
			}
		}
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("searchOption", searchOption);
		inputMap.put("searchText", searchText);
		inputMap.put("uNo", uNo);
		
		return sqlSession.selectOne(namespace + "getOrderTotalCount", inputMap);
	}

	@Override
	public int checkCart(int uNo, int iNo) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", uNo);
		inputMap.put("iNo", iNo);
		
		return sqlSession.selectOne(namespace + "checkCart", inputMap);
	}

	@Override
	public List<Map<String, Object>> viewCartFileList(int uNo) {
		
		return sqlSession.selectList(namespace + "viewCartFileList", uNo);
	}

	@Override
	public Object countMyOrderStatus(int uNo, String oStatus) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", uNo);
		inputMap.put("oStatus", oStatus);
		
		return sqlSession.selectOne(namespace + "countMyOrderStatus", inputMap);
	}

		

}
