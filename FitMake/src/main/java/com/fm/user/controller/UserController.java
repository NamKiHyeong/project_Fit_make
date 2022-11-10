package com.fm.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.user.model.UserDto;
import com.fm.user.service.UserService;
import com.fm.util.Paging;

//어노테이션 드리븐
@Controller
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;
	
	// 로그인 페이지 이동
	@RequestMapping(value = "/auth/login.do", method = RequestMethod.GET)
	public String login(HttpSession session, Model model) {
		logger.info("Welcome UserController login! ");

		return "auth/LoginForm";
	}
	@RequestMapping(value = "/mainpage/main.do", method = RequestMethod.GET)
	public String main(HttpSession session, Model model) {
		logger.info("메인로고 클릭! ");
		
		String viewPage = "";
		if (session != null) {
			viewPage = "/mainpage/main";
		} else if (session == null) {
			viewPage = "redirect:/auth/loginCtr.do";
		}
		return viewPage;
	}
	// 로그인
	@RequestMapping(value = "/auth/loginCtr.do", method = RequestMethod.POST)
	public String loginCtr(String email, String password, HttpSession session, Model model) {
		logger.info("Welcome UserController loginCtr! " + email + ", " + password);

		UserDto userDto = userService.userExist(email, password);

		String viewUrl = "";
		// 회원 확인
		if (userDto != null) {
			session.setAttribute("_userDto_", userDto);
			viewUrl = "/mainpage/main";
		} else {
			viewUrl = "/auth/LoginFail";
		}
		return viewUrl;
	}

	// 로그아웃
	@RequestMapping(value = "/auth/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session, Model model) {
		logger.info("Welcome UserController logout! ");

		session.invalidate();

		return "redirect:/auth/login.do";
	}

	// 회원가입 페이지로 이동
	@RequestMapping(value = "/user/add.do", method = RequestMethod.GET)
	public String userAdd(Model model) {
		logger.debug("Welcome UserController memberAdd! ");

		return "/user/JoinForm";
	}

	// 회원가입
	@RequestMapping(value = "/user/addCtr.do", method = RequestMethod.POST)
	public String memberAdd(UserDto userDto, Model model) {
		logger.trace("Welcome UserController memberAdd 신규등록 처리! " + userDto);

		userService.userInsertOne(userDto);

		return "redirect:/auth/login.do";
	}
}
