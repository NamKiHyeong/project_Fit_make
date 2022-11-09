package com.fm.member.controller;

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

import com.fm.member.model.MemberDto;
import com.fm.member.service.MemberService;
import com.fm.util.Paging;

//어노테이션 드리븐
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/auth/login.do", method = RequestMethod.GET)
	public String login(HttpSession session, Model model) {
		logger.info("환영 login!!");
		
		return "auth/LoginForm";
	}

	@RequestMapping(value = "/auth/loginCtr.do", method = RequestMethod.POST)
	public String login(String email,String password, HttpSession session, Model model) {
		logger.info("환영 loginCtr!!" + email + password);
		
		MemberDto memberDto = new memberService.memberExist(email, password);
		
		String viewUrl = null;
		if (memberDto != null) {
			session.setAttribute("_meberDto", memberDto);
			
			viewUrl = "redirect:/member/list.do"; // 요기가 main으로 가는 화면
		} else {
			viewUrl = "/auth/LoginFail";
		}
		
		re
		//여기에 메인으로 가는 리터문
		return "auth/LoginForm";
	}

}
