package com.fm.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.user.model.UserDto;

public interface UserService {

	public UserDto userExist(String email, String password);

	public void userInsertOne(UserDto userDto);
	
	

}
