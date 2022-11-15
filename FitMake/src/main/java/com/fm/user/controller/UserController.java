package com.fm.user.controller;


import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fm.user.model.UserDto;
import com.fm.user.service.UserService;
import com.fm.util.BmiCalc;

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

	@RequestMapping(value = "/main/main.do", method = RequestMethod.GET)
	public String main(HttpSession session, Model model) {
		logger.info("메인로고 클릭! ");

		String viewPage = "";
		if (session.getAttribute("_userDto_") != null) {
			viewPage = "main/MainPage";
		} else if (session.getAttribute("_userDto_") == null) {
			viewPage = "redirect:/auth/login.do";
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
			viewUrl = "main/MainPage";
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

	/**
	 * 회원가입 페이지로 이동
	 * 
	 * @param model
	 * @return
	 */

	@RequestMapping(value = "/user/add.do", method = RequestMethod.GET)
	public String userAdd(Model model) {
		logger.debug("Welcome UserController memberAdd! ");

		return "/user/JoinForm";
	}

	/**
	 * 
	 * @param userDto
	 * @param model
	 * @param bmiCalc
	 * @return 회원가입 userDto정보와 bmiCalc정보 DB에 기입
	 */
	@RequestMapping(value = "/user/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userAdd(UserDto userDto, Model model, BmiCalc bmiCalc, String add_1st, String add_Extra, String add_Detail) {
		logger.trace("Welcome UserController userAdd 신규등록 처리! " + userDto);
		
		String address = add_1st + add_Extra + add_Detail;
		
		userService.userInsertOne(userDto, address);
		userService.bmiInsertOne(bmiCalc);
		return "redirect:/auth/login.do";
	}
	
	/**
	 * 
	 * @param model
	 * @return 
	 */
	@RequestMapping(value = "/user/Info.do")
		public String userInfo(Model model, HttpSession session) {
			logger.info("Welcome UserController userInfo enter! - {}");
			
			UserDto userdto = new UserDto();
			userdto = (UserDto) session.getAttribute("_userDto_");
			logger.info("Welcome UserController userInfo enter! - {}", userdto.getuNo());
			Map<String, Object> myInfomap = userService.userSelectInfo(userdto.getuNo());
			model.addAttribute("myInfomap", myInfomap);
			
			return "/user/UserMyInfo";
		}
}
