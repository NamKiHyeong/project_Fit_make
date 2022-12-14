package com.fm.user.service;

import java.util.List;
import java.util.Map;

import com.fm.item.model.ItemDto;
import com.fm.user.model.UserDto;
import com.fm.util.BmiCalc;
import com.fm.util.PointAdd;

public interface UserService {
	public List<Map<String, Object>> pointHistoryList(int uNo, int start, int end);

	public UserDto userExist(String email, String password);

	public void userInsertOne(UserDto userDto, String address);

	public void userBmiUpdate(UserDto userDto, double height, double weight);
	
	public void bmiInsertOne(BmiCalc bmiCalc);

	public Map<String, Object> userSelectInfo(int uNo);

	public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber);

	public int checkEmail(String email);

	public int checkNickName(String nickName);

	public void addPoint(PointAdd pointAdd, int point);

	public void pointHistory(PointAdd pointAdd, int point);

	public int myPointChk(int uNo);

	public void userDelete(UserDto userDto) throws Exception;

	public void userUpdate(UserDto userDto, String nickName, String changepassword, long salt);

	public String myNickNameChk(String nickName);

	public String findUserId(String userPhoneNumber);

	public String resultUserpwd(String userEmail);

	public void userBmiDelete(UserDto userDto);

	public void addRecommendItem(UserDto userDto);
	
	public int getUserInfoTotalCount();

	public int getUserTotalCount(int uNo);

	public List<Map<String, Object>> viewUserList(int uNo, int start, int end);

	public List<ItemDto> viewRecommendItemList(int uNo);

	public List<ItemDto> viewBestItemList();

	public List<Map<String, Object>> viewReviewList();

	public List<Map<String, Object>> viewPointList(int uNo, int start, int end);



}
