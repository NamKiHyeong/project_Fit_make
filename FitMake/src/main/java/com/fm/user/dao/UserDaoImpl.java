package com.fm.user.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.user.model.UserDto;
import com.fm.util.BmiCalc;

//DB와 관련된 작업을 저장하는 곳이라 레파지토리라는 어노테이션을 붙여야 한다.
@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	String namespaceuser = "com.fm.user.";
	String namespaceutil = "com.fm.user.";

	@Override
	public UserDto userExist(String email, String password) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("email", email);
		paramMap.put("password", password);

		UserDto userDto = sqlSession.selectOne(namespaceuser + "userExist", paramMap);

		return userDto;
	}

	@Override
	public int userInsertOne(UserDto userDto) {

		return sqlSession.insert(namespaceuser + "userInsertOne", userDto);
	}

	@Override
	public int bmiInsertOne(BmiCalc bmiCalc) {

		bmiCalc.setbRaw(Math.round((bmiCalc.getWeight() / (bmiCalc.getHeight() * bmiCalc.getHeight())) * 100000) / 10d);
		bmiCalc.setGoalBmi(
				(Math.round((bmiCalc.getWeight() / (bmiCalc.getHeight() * bmiCalc.getHeight())) * 100000) / 10d) - 1);
		bmiCalc.setGoalCalory((Math.round((bmiCalc.getWeight() * 30) / 3) - 300) / 2);

		return sqlSession.insert(namespaceutil + "bmiInsertOne", bmiCalc);
	}

	@Override
	public Map<String, Object> userSelectInfo(int uNo) {
		
		
		return sqlSession.selectOne(namespaceuser + "userSelectInfo", uNo);
	}

}
