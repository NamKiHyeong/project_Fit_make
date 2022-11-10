package com.fm.user.dao;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.user.model.UserDto;

public interface UserDao {

	public UserDto userExist(String email, String password);

	public int userInsertOne(UserDto userDto);
	
}
