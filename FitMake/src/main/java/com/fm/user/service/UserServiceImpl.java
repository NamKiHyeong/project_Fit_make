package com.fm.user.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.transaction.Transaction;
import org.json.simple.JSONObject;
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
import com.fm.util.PointAdd;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class UserServiceImpl implements UserService {

	private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);

	@Autowired
	public UserDao userDao;

	@Override
	public List<Map<String, Object>> pointHistoryList(int uNo) {
		
		return userDao.pointHistoryList(uNo);
	}

	@Override
	public UserDto userExist(String email, String password) {
		
		return userDao.userExist(email, password);
	}

	@Override
	public void userInsertOne(UserDto userDto, String address) {

		userDao.userInsertOne(userDto, address);
	}

	@Override
	public void bmiInsertOne(BmiCalc bmiCalc) {

		userDao.bmiInsertOne(bmiCalc);

	}

	@Override
	public Map<String, Object> userSelectInfo(int uNo) {

		return userDao.userSelectInfo(uNo);
	}

	@Override
	public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) {
		String api_key = "NCSEYAU3GAKDFC8B";
		String api_secret = "FLLPTMWHSAIBTGGJTP5OYFQ75WN7MT48";
		Message coolsms = new Message(api_key, api_secret);

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", userPhoneNumber); // 수신전화번호
		params.put("from", "01033729219"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		params.put("type", "SMS");
		params.put("text", "[FitMake] 인증번호는" + "[" + randomNumber + "]" + "입니다."); // 문자 내용 입력
		params.put("app_version", "test app 1.2"); // application name and version

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

	}

	@Override
	public int checkEmail(String email) {

		int result = 0;

		result = userDao.checkEmail(email);

		return result;
	}

	@Override
	public void addPoint(UserDto userDto, int point) {

		userDao.addPoint(userDto, point);
	}

	@Override
	public void pointHisoty(PointAdd pointAdd, int point) {

		userDao.pointHisoty(pointAdd, point);
	}

	@Override
	public int checkNickName(String nickName) {
		int result = 0;

		result = userDao.checkNickName(nickName);

		return result;
	}

	@Override
	public int myPointChk(int uNo) {

		return userDao.myPointChk(uNo);
	}

	@Override
	public void userDelete(UserDto userDto) throws Exception {

		userDao.userDelete(userDto);
	}

	@Override
	public void userUpdate(UserDto userDto, String nickName, String password, int salt) {

		userDao.userUpdate(userDto, nickName, password, salt);

	}

	@Override
	public String myNickNameChk(String nickName) {

		return userDao.myNickNameChk(nickName);
	}

	@Override
	public String fintUserId(String userPhoneNumber) {

		String result = "";

		try {
			result = userDao.fintUserId(userPhoneNumber);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public String resultUserpwd(String userEmail) {
		String result = "";

		try {
			result = userDao.resultUserpwd(userEmail);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void userBmiDelete(UserDto userDto) {
		
		userDao.userBmiDelete(userDto);
	}

	@Override
	public void addRecommendItem(UserDto userDto) {
			
		 userDao.addRecommendItem(userDto);
	}

	@Override
	public int getUserTotalCount(int uNo) {
		
		
		return userDao.getUserTotalCount(uNo);
	}

	@Override
	public List<Map<String, Object>> viewUserList(int uNo, int start, int end) {
		
		
		return userDao.viewUserList(uNo, start, end);
	}

	@Override
	public List<Map<String, Object>> viewRecommendItemList(int uNo) {
		
		return userDao.viewRecommendItemList(uNo);
	}

	@Override
	public List<Map<String, Object>> viewBestItemList() {
		
		return userDao.viewBestItemList();
	}

}
