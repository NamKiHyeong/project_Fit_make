package com.fm.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.user.model.UserDto;
import com.fm.util.BmiCalc;

public interface UserService {

	public UserDto userExist(String email, String password);

	public void userInsertOne(UserDto userDto);

	public void bmiInsertOne(BmiCalc bmiCalc);

	public Map<String, Object> userSelectInfo(int uNo);
	
	

}
