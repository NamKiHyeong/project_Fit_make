package com.fm.user.dao;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.user.model.UserDto;
import com.fm.util.BmiCalc;
import com.fm.util.PointAdd;

public interface UserDao {

	public UserDto userExist(String email, String password);

	public int userInsertOne(UserDto userDto, String address);

	public int bmiInsertOne(BmiCalc bmiCalc);

	public Map<String, Object> userSelectInfo(int uNo);

	public int checkEmail(String email);

	public int addPoint(UserDto userDto, int point);

	public int checkNickName(String nickName);

	public int pointHisoty(PointAdd pointAdd, int point);

	

}
