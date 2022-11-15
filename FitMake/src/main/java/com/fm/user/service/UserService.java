package com.fm.user.service;

import java.util.Map;


import com.fm.user.model.UserDto;
import com.fm.util.BmiCalc;

public interface UserService {

	public UserDto userExist(String email, String password);

	public void userInsertOne(UserDto userDto, String address);

	public void bmiInsertOne(BmiCalc bmiCalc);

	public Map<String, Object> userSelectInfo(int uNo);

	
	

}
