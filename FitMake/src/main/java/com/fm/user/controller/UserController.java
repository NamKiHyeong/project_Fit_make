package com.fm.user.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fm.user.model.UserDto;
import com.fm.user.service.UserService;
import com.fm.util.BmiCalc;
import com.fm.util.PointAdd;

//어노테이션 드리븐
@Controller
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	/**
	 * index.jsp에서 로그인 페이지로 이동 나중에 없앨듯
	 * 
	 * @return LoginForm.jsp로 이동
	 */
	@RequestMapping(value = "/auth/login.do", method = RequestMethod.GET)
	public String login() {
		logger.info("Welcome UserController login! ");

		return "auth/LoginForm";
	}

	/**
	 * 헤더 메인로고 클릭 시 로그인 상태 -> 메인페이지, 비로그인 상태 -> 로그인페이지
	 * 
	 * @param session 회원정보 유무상태를 확인
	 * @return 로그인상태 -> MainPage.jsp, 비로그인 상태 -> LoginForm.jsp
	 */
	@RequestMapping(value = "/main/main.do", method = RequestMethod.GET)
	public String main(HttpSession session) {
		logger.info("메인로고 클릭! ");

		String viewPage = "";
		if (session.getAttribute("_userDto_") != null) {
			viewPage = "main/MainPage";
		} else if (session.getAttribute("_userDto_") == null) {
			viewPage = "redirect:/auth/login.do";
		}
		return viewPage;
	}

	/**
	 * 
	 * @param email    사용자가 입력한 email값
	 * @param password 사용자가 입력한 password값
	 * @param session  세션에 userDto정보를 담는다 view페이지에서 현재 세션정보를 찾기 위함
	 * @return 가입된 회원 -> 메인페이지, 가입되지 않은 회원 -> 로그인실패 페이지(이동후 다시 로그인페이지)
	 */
	@RequestMapping(value = "/auth/loginCtr.do", method = RequestMethod.POST)
	public String loginCtr(String email, String password, HttpSession session) {
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

	/**
	 * 
	 * @param session.invalidate() 를 사용해서 세션 종료
	 * @return 로그인페이지로 다시 이동
	 */
	@RequestMapping(value = "/auth/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
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
	 * @param email 이메일 중복체크를 위한 밸류값
	 * @ResponseBody View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return
	 */
	@RequestMapping(value = "/user/emailCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String checkEmail(@RequestParam("emailChk") String email) {

		String result = "N";
		int flag = userService.checkEmail(email);
		// 이메일이 있을시 Y 없을시 N 으로 회원가입페이지로 보냄
		if (flag == 1)
			result = "Y";

		return result;
	}

	/**
	 * 
	 * @param nickName 닉네임 중복체크를 위한 값
	 * @ResponseBody View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return
	 */
	@RequestMapping(value = "/user/nickNameChk.do", method = RequestMethod.POST)
	@ResponseBody
	public String checkNickName(@RequestParam("nickNameChk") String nickName) {

		String result = "N";
		int flag = userService.checkNickName(nickName);
		// 닉네임이 있을시 Y 없을시 N 으로 회원가입페이지로 보냄
		if (flag == 1)
			result = "Y";

		return result;
	}

	/**
	 * 
	 * @param userPhoneNumber 수신번호
	 * @ResponseBody View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return
	 */
	@RequestMapping(value = "/user/phoneCheck.do", method = RequestMethod.GET)
//	@GetMapping("/user/phoneCheck.do")
	@ResponseBody
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { // 휴대폰 문자보내기
		int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);// 난수 생성

		userService.certifiedPhoneNumber(userPhoneNumber, randomNumber);

		System.out.println(randomNumber);
		return Integer.toString(randomNumber);
	}

	/**
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/user/pointChk.do", method = RequestMethod.GET)
	@ResponseBody
	public int myPointChk(HttpSession session) {

		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();

		int myPointChk = userService.myPointChk(uNo);

		return myPointChk;
	}

	/**
	 * 
	 * @param userDto
	 * @param model
	 * @param bmiCalc
	 * @return 회원가입 userDto정보와 bmiCalc정보 DB에 기입
	 */
	@ResponseBody
	@RequestMapping(value = "/user/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userAdd(UserDto userDto, Model model, BmiCalc bmiCalc, String add_1st, String add_Extra,
			String add_Detail) {
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
		
		UserDto userdto = new UserDto();
		
		userdto = (UserDto) session.getAttribute("_userDto_");
		logger.info("Welcome UserController userInfo enter! - {}", userdto.getuNo());
		
		
		Map<String, Object> myInfomap = userService.userSelectInfo(userdto.getuNo());
		model.addAttribute("myInfomap", myInfomap);

		return "/user/UserMyInfo";
	}

	/**
	 * 
	 * @return 충전버튼 누를시 -> 포인트충전 팝업창 실행
	 */
	@RequestMapping(value = "/user/point.do")
	public String pointView() {
		;
		logger.info("포인트 페이지로 갑니다");

		return "/user/PointPopup";
	}

	@RequestMapping(value = "/user/pointAdd.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int pointAdd(@RequestParam("priceSelect") int point, PointAdd pointAdd, HttpSession session) {
		logger.info("포인트 충전 - {}", point);

		UserDto userdto = new UserDto();
		userdto = (UserDto) session.getAttribute("_userDto_");
		pointAdd.setuNo(userdto.getuNo());

		userService.addPoint(userdto, point);
		userService.pointHisoty(pointAdd, point);

		return 1;
	}

	/**
	 * 
	 * @return 충전/사용내역 View
	 */
	@RequestMapping(value = "/user/pointHistory.do")
	public String viewHistory() {
		logger.info("충전/사용내역");

		return "/user/PointRechargehistory";
	}
}
