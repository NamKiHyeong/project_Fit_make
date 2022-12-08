package com.fm.user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.item.model.ItemDto;
import com.fm.user.model.UserDto;
import com.fm.util.BmiCalc;
import com.fm.util.PointAdd;

//DB와 관련된 작업을 저장하는 곳이라 레파지토리라는 어노테이션을 붙여야 한다.
@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	String namespaceuser = "com.fm.user.";

	@Override
	public List<Map<String, Object>> pointHistoryList(int uNo, int start, int end) {
			
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", uNo);
		inputMap.put("start", start);
		inputMap.put("end", end);
		inputMap.put("oNo", 0);
		
		return sqlSession.selectList(namespaceuser + "pointHistoryList", inputMap);
	}

	@Override
	public UserDto userExist(String email, String password) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("email", email);
		
		UserDto userDto = sqlSession.selectOne(namespaceuser + "userExist", paramMap);
		
		String existPwd = userDto.setHashpwd(userDto.getSalt(), password);
		if (existPwd.equals(userDto.getPassword())) {
			
			return userDto;
		} else {
			return null;
		}

	}

	@Override
	public int userInsertOne(UserDto userDto, String address) {

		userDto.setAddress(address);
		

		return sqlSession.insert(namespaceuser + "userInsertOne", userDto);
	}

	@Override
	public int bmiInsertOne(BmiCalc bmiCalc) {

		bmiCalc.setbRaw(Math.round((bmiCalc.getWeight() / (bmiCalc.getHeight() * bmiCalc.getHeight())) * 100000) / 10d);
		bmiCalc.setGoalBmi(
				(Math.round((bmiCalc.getWeight() / (bmiCalc.getHeight() * bmiCalc.getHeight())) * 100000) / 10d) - 1);
		bmiCalc.setGoalCalory((Math.round((bmiCalc.getWeight() * 30) / 3) - 300) / 2);

		return sqlSession.insert(namespaceuser + "bmiInsertOne", bmiCalc);
	}

	@Override
	public Map<String, Object> userSelectInfo(int uNo) {

		return sqlSession.selectOne(namespaceuser + "userSelectInfo", uNo);
	}

	@Override
	public int checkEmail(String email) {

		return sqlSession.selectOne(namespaceuser + "checkEmail", email);
	}

	@Override
	public int addPoint(PointAdd pointAdd, int point) {
		
		pointAdd.setpHistory(point);
		
		return sqlSession.update(namespaceuser + "addPoint", pointAdd);
	}

	@Override
	public int pointHistory(PointAdd pointAdd, int point) {

		pointAdd.setpHistory(point);

		return sqlSession.insert(namespaceuser + "pointHistory", pointAdd);
	}

	@Override
	public int checkNickName(String nickName) {

		return sqlSession.selectOne(namespaceuser + "checkNickName", nickName);
	}

	@Override
	public int myPointChk(int uNo) {

		return sqlSession.selectOne(namespaceuser + "myPointChk", uNo);
	}

	@Override
	public void userDelete(UserDto userDto) {
		
		sqlSession.delete(namespaceuser + "userDelete", userDto);
	}
	
	@Override
	public void userBmiDelete(UserDto userDto) {
		
		sqlSession.delete(namespaceuser + "userBmiDelete", userDto);
	}

	@Override
	public void userUpdate(UserDto userDto, String nickName, String password, int salt) {

		userDto.setNickName(nickName);
		userDto.setPassword(password);
		userDto.setSalt(salt);

		sqlSession.update(namespaceuser + "userUpdate", userDto);
	}

	@Override
	public String myNickNameChk(String nickName) {

		return sqlSession.selectOne(namespaceuser + "myNickNameChk", nickName);
	}

	@Override
	public String fintUserId(String userPhoneNumber) {

		return sqlSession.selectOne(namespaceuser + "fintUserId", userPhoneNumber);

	}

	@Override
	public String resultUserpwd(String userEmail) {
		
		return sqlSession.selectOne(namespaceuser + "resultUserpwd", userEmail);
	}

	@Override
	public void addRecommendItem(UserDto userDto) {

		sqlSession.insert(namespaceuser + "addRecommendItem", userDto);
	}

	@Override
	public int getUserTotalCount(int uNo) {
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("uNo", uNo);
		
		return sqlSession.selectOne(namespaceuser + "getUserTotalCount", inputMap);
	}

	@Override
	public List<Map<String, Object>> viewUserList(int uNo, int start, int end) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", uNo);
		inputMap.put("start", start);
		inputMap.put("end", end);
		
		return sqlSession.selectList(namespaceuser + "viewUserList", inputMap);
	}

	@Override
	public List<ItemDto> viewRecommendItemList(int uNo) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", uNo);
		inputMap.put("start", 1);
		inputMap.put("end", 4);
		inputMap.put("keyword", "");
		
		return sqlSession.selectList("com.fm.item.viewRecommendItemList", inputMap);
	}

	@Override
	public List<ItemDto> viewBestItemList() {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", -1);
		inputMap.put("start", 1);
		inputMap.put("end", 4);
		inputMap.put("keyword", "");
		
		List<Integer> bestItemList = sqlSession.selectList("com.fm.item.viewBestItemNoList", inputMap);
		List<ItemDto> newBestItemList = new ArrayList<ItemDto>();
		for(int iNo : bestItemList) {
			newBestItemList.add(sqlSession.selectOne("com.fm.item.viewTotalBestItemList", iNo));
		}
		
		return newBestItemList;
	}

	@Override
	public List<Map<String, Object>> viewReviewList() {
		
		return sqlSession.selectList("com.fm.review.viewReviewList");
	}

	@Override
	public List<Map<String, Object>> viewPointList(int uNo, int start, int end) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("uNo", uNo);
		inputMap.put("start", start);
		inputMap.put("end", end);
		
		return sqlSession.selectList(namespaceuser + "viewPointList", inputMap);
	}

}
