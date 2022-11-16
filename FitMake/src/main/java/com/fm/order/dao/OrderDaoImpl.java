package com.fm.order.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.order.model.CartDto;
import com.fm.order.model.OrderDto;
import com.fm.user.model.UserDto;

//DB와 관련된 작업을 저장하는 곳이라 레파지토리라는 어노테이션을 붙여야 한다.
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
	public int deleteCart(int uNo, int cNo) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("uNo", uNo);
		inputMap.put("cNo", cNo);
				
		return sqlSession.delete(namespace + "deleteCart", inputMap);
	}
	
	@Override
	public List<Map<String, Object>> viewOrderList(int uNo) {
		
		return sqlSession.selectList(namespace + "viewOrderList", uNo);
	}
	
	@Override
	public int addOrder(int uNo) {
		
		return sqlSession.insert(namespace + "addOrder", uNo);
	}
	
	@Override
	public List<Map<String, Object>> viewOrderDetailItem(int oNo) {
		
		return sqlSession.selectList(namespace + "viewOrderDetailItem", oNo);
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
	public Map<String, Object> viewOrderDetailMyInfo(int uNo) {
		
		return sqlSession.selectOne("com.fm.user.userSelectInfo", uNo);
	}

	@Override
	public int updateCart(CartDto cartDto) {
		
		return sqlSession.update(namespace + "updateCart", cartDto);
	}

}
