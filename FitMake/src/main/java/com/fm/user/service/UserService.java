package com.fm.user.service;

import java.util.List;
import java.util.Map;

import com.fm.user.model.UserDto;
import com.fm.util.BmiCalc;
import com.fm.util.PointAdd;

public interface UserService {
	public List<Map<String, Object>> pointHistoryList(int uNo);

	public UserDto userExist(String email, String password);

	public void userInsertOne(UserDto userDto, String address);

	public void bmiInsertOne(BmiCalc bmiCalc);

	public Map<String, Object> userSelectInfo(int uNo);

	public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber);

	public int checkEmail(String email);

	public int checkNickName(String nickName);

	public void addPoint(UserDto userDto, int point);

	public void pointHisoty(PointAdd pointAdd, int point);

	public int myPointChk(int uNo);

	public void userDelete(UserDto userDto) throws Exception;

	public void userUpdate(UserDto userDto, String nickName, String password, int salt);

	public String myNickNameChk(String nickName);

	public String fintUserId(String userPhoneNumber);

	public String resultUserpwd(String userEmail);

	public void userBmiDelete(UserDto userDto);

}
