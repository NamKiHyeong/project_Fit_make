package com.fm.order.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.order.model.OrderDto;
import com.fm.user.model.UserDto;

//DB와 관련된 작업을 저장하는 곳이라 레파지토리라는 어노테이션을 붙여야 한다.
@Repository
public class OrderDaoImpl implements OrderDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	String namespace = "com.fm.order.";

	@Override
	public List<Map<String, Object>> orderListView(int uNo) {
		
		return sqlSession.selectList(namespace + "orderListView", uNo);
	}
	
	@Override
	public Map<String, Object> orderDetailView(int oNo) {
		
		return sqlSession.selectOne(namespace + "orderDetailView", oNo);
	}

	@Override
	public int addCart(int uNo, int iNo, int iCount) {
		
		Map<Integer, Object> inputMap = new HashMap<Integer, Object>();
		
		inputMap.put(iNo, "iNo");
		inputMap.put(uNo, "uNo");
		inputMap.put(iCount, "iCount");
		
		return sqlSession.insert(namespace + "addCart", inputMap);
	}

	@Override
	public List<Map<String, Object>> cartListView(int uNo) {
		
		return sqlSession.selectList(namespace + "cartListView", uNo);
	}

}
