package com.fm.user.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.transaction.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.user.dao.UserDao;
import com.fm.user.model.UserDto;
import com.fm.util.BmiCalc;
import com.fm.util.FileUtils;

@Service
public class UserServiceImpl implements UserService {

	private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);

	@Autowired
	public UserDao UserDao;

	@Override
	public UserDto userExist(String email, String password) {
		// TODO Auto-generated method stub
		return UserDao.userExist(email, password);
	}

	@Override
	public void userInsertOne(UserDto userDto) {

		UserDao.userInsertOne(userDto);
	}

	@Override
	public void bmiInsertOne(BmiCalc bmiCalc) {
		
		UserDao.bmiInsertOne(bmiCalc);
		
	}

}
