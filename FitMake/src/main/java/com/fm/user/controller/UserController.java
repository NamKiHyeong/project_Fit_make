package com.fm.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fm.item.model.ItemDto;
import com.fm.user.model.UserDto;
import com.fm.user.service.UserService;
import com.fm.util.BmiCalc;
import com.fm.util.Paging;
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

		return "auth/LoginForm";
	}

	/**
	 * 
	 * @param session  세션에 userDto정보를 담는다 view페이지에서 현재 세션정보를 찾기 위함
	 * @param model    alret를 하기 위해 model 사용
	 * @param email    사용자가 입력한 email값
	 * @param password 사용자가 입력한 password값
	 * @return 가입된 회원 -> 메인페이지, 가입되지 않은 회원 -> 로그인실패 alert(이동후 다시 로그인페이지)
	 * @throws Exception try/catch를 사용하기 위해 생성
	 */
	@RequestMapping(value = "/auth/loginCtr.do", method = RequestMethod.POST)
	public String loginCtr(HttpSession session, Model model, String email, String password) throws Exception {

		try {
			UserDto userDto = userService.userExist(email, password);
			String viewUrl = "";
			// 회원 확인
			if (userDto == null) {
				model.addAttribute("msg", "아이디 또는 비밀번호가 잘못되었습니다");
				model.addAttribute("url", "../auth/login.do");
				return "auth/LoginFail";
			} else {
				session.setAttribute("_userDto_", userDto);
				viewUrl = "redirect:/main/main.do";
				return viewUrl;
			}
		} catch (Exception e) {
			model.addAttribute("msg", "등록되지 않은 정보입니다.");
			model.addAttribute("url", "../auth/login.do");

			return "common/UserExistAlret";
		}

	}

	/**
	 * 
	 * @param userDto    사용자가 입력한 회원정보를 담을 객체
	 * @param model      가입완료시 가입완료 알림창 사용을 위해 지정
	 * @param bmiCalc    사용자가 입력한 키,몸무게를 담을 객체
	 * @param add_1st    ---
	 * @param add_Extra  사용자가 입력한 주소값을 가져옴
	 * @param add_Detail ---
	 * @return 회원가입시 사용자가 입력한 비밀번호를 전달받아 암호화해서 db저장(salt,hash) 전달받은 3개의 주소값을 하나로 합쳐
	 *         db저장 전달받은 키, 몸무게 값을 BMI로 산정하여 db에 저장
	 */
	@RequestMapping(value = "/user/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userAdd(UserDto userDto, Model model, BmiCalc bmiCalc, String add_1st, String add_Extra,
			String add_Detail) {

		try {
			int salt = userDto.addSalt();
			String password = userDto.setHashpwd(salt, userDto.getPassword());
			String address = add_1st + add_Extra + add_Detail;

			userDto.setSalt(salt);
			userDto.setPassword(password);
			userService.userInsertOne(userDto, address);
			userService.bmiInsertOne(bmiCalc);

			model.addAttribute("msg", "가입이 완료되었습니다!");
			model.addAttribute("url", "../auth/login.do");
			return "common/UserJoinSuccess";

		} catch (Exception e) {

			return null;
		}
	}

	/**
	 * 
	 * @return 아이디 찾기 FindId.jsp로 감
	 */
	@RequestMapping(value = "/user/findId.do")
	public String viewFindId() {

		return "/user/FindId";
	}

	/**
	 * 
	 * @return 비밀번호 찾기 FindPassword.jsp로 감
	 */
	@RequestMapping(value = "/user/findPassword.do")
	public String viewFindpwd() {

		return "/user/FindPassword";
	}

	/**
	 * 
	 * @return 회원탈퇴 UserDelete.jsp로 감
	 */
	@RequestMapping(value = "/user/userDelete.do")
	public String viewDelete(HttpSession session) {

		return "/user/UserDelete";
	}

	/**
	 * 
	 * @param userDto 회원탈퇴시 입력한 비밀번호를 담을 객체
	 * @param session 세션에 userDto의 값을 저장
	 * @param ra      뷰에 alert를 사용하기 위해 사용
	 * @return 사용자가 회원탈퇴시 암호화된 사용자의 비밀번호를 대조해야하기 때문에 'existPwd'변수 사용 대조해서 값이 다르면
	 *         alert(msg)사용 값이 같으면 회원탈퇴
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/deleteCtr.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userDelete(UserDto userDto, HttpSession session, RedirectAttributes ra) throws Exception {

		UserDto uPwd = (UserDto) session.getAttribute("_userDto_");

		String oldPwd = uPwd.getPassword();
		String sessionPwd = userDto.getPassword();

		String existPwd = userDto.setHashpwd(uPwd.getSalt(), sessionPwd);
		if (existPwd.equals(oldPwd)) {
			userService.userBmiDelete(userDto);
			userService.userDelete(userDto);
			session.invalidate();
			return "redirect:/auth/login.do";
		} else {
			ra.addFlashAttribute("msg", false);
			return "redirect:/user/userDelete.do";
		}
	}

	/**
	 * 헤더 메인로고 클릭 시 로그인 상태 -> 메인페이지, 비로그인 상태 -> 로그인페이지
	 * 
	 * @param session 회원정보 유무상태를 확인
	 * @return 로그인상태 -> MainPage.jsp, 비로그인 상태 -> LoginForm.jsp
	 */
	@RequestMapping(value = "/main/main.do", method = RequestMethod.GET)
	public String main(HttpSession session, Model model) {

		String viewPage = "";
		if (session.getAttribute("_userDto_") != null) {
			UserDto userDto = (UserDto) session.getAttribute("_userDto_");
			int uNo = userDto.getuNo();

			List<ItemDto> mainRecommendItemList = userService.viewRecommendItemList(uNo);
			List<ItemDto> mainBestItemList = userService.viewBestItemList();
			List<Map<String, Object>> mainReviewList = userService.viewReviewList();

			model.addAttribute("mainRecommendItemList", mainRecommendItemList);
			model.addAttribute("mainBestItemList", mainBestItemList);
			model.addAttribute("mainReviewList", mainReviewList);

			viewPage = "main/MainPage";
		} else if (session.getAttribute("_userDto_") == null) {
			viewPage = "redirect:/auth/login.do";
		}
		return viewPage;
	}

	/**
	 * 
	 * @param session.invalidate() 를 사용해서 세션 종료
	 * @return 로그아웃시 -> 로그인페이지로 이동
	 */
	@RequestMapping(value = "/auth/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/auth/login.do";
	}

	/**
	 * 
	 * @return 회원가입 페이지로 이동
	 */
	@RequestMapping(value = "/user/add.do", method = RequestMethod.GET)
	public String userAdd() {

		return "/user/JoinForm";
	}

	/**
	 * 
	 * @param email 사용자가 입력한 Email 값
	 * @ResponseBody Ajax -> View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return 이메일이 있을시 Y 없을시 N 으로 회원가입페이지로 보냄
	 */
	@RequestMapping(value = "/user/emailCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String checkEmail(@RequestParam("emailChk") String email) {

		String result = "N";
		int flag = userService.checkEmail(email);

		if (flag == 1)
			result = "Y";

		return result;
	}

	/**
	 * 
	 * @param nickName 닉네임 중복체크를 위한 값
	 * @ResponseBody View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return 닉네임이 있을 시 Y , 없을 시 N 보냄
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
	 * @return 생성된 난수를 integer 형변환 해서 보냄
	 */
	@RequestMapping(value = "/user/phoneCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { // 휴대폰 문자보내기
		int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);// 난수 생성

		userService.certifiedPhoneNumber(userPhoneNumber, randomNumber);

		System.out.println(randomNumber);
		return Integer.toString(randomNumber);
	}

	/**
	 * 
	 * @param userPhoneNumber 입력한 핸드폰 번호
	 * @ResponseBody View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return userPhoneNumber로 DB를 통해 EMAIL값을 가져옴 (EMAIL찾기)
	 */
	@RequestMapping(value = "/user/resultFindId.do", method = RequestMethod.POST)
	@ResponseBody
	public String resultId(@RequestParam("phone") String userPhoneNumber) {

		String result = userService.fintUserId(userPhoneNumber);

		return result;
	}

	/**
	 * 
	 * @param userEmail 사용자가 입력한 입력한 이메일
	 * @ResponseBody View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return 사용자가 입력한 이메일과 db에 있는 이메일값이 같으면 값 반환
	 */
	@RequestMapping(value = "/user/resultFindPwd.do", method = RequestMethod.POST)
	@ResponseBody
	public String resultPwd(@RequestParam("email") String userEmail) {

		String result = userService.resultUserpwd(userEmail);

		return result;
	}

	/**
	 * 
	 * @param session 사용자의 정보를 담기위한 세션
	 * @ResponseBody View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return 헤더 포인트 -> db에 저장된 사용자의 포인트를 가져와서 반환
	 */
	@RequestMapping(value = "/user/pointChk.do", method = RequestMethod.GET)
	@ResponseBody
	public int myPointChk(HttpSession session) {

		UserDto userDto = (UserDto) session.getAttribute("_userDto_");

		if (userDto == null) {
			int myPointChk = 0;
			return myPointChk;
		} else {
			int uNo = (int) userDto.getuNo();

			int myPointChk = userService.myPointChk(uNo);
			return myPointChk;
		}

	}

	/**
	 * 
	 * @param session 사용자의 정보를 담기위한 세션
	 * @ResponseBody View 페이지가 아닌 응답값 그대로 반환하기 위해 사용
	 * @return 헤더 닉네임 -> db에 저장된 사용자의 닉네임을 가져와서 반환
	 */
	@RequestMapping(value = "/user/nickNameChk.do", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	@ResponseBody
	public String myNickNameChk(HttpSession session) {

		UserDto userDto = (UserDto) session.getAttribute("_userDto_");

		if (userDto == null) {
			String myNicknameChk = "";
			return myNicknameChk;
		} else {
			String nickName = userDto.getNickName();

			String myNicknameChk = userService.myNickNameChk(nickName);
			return myNicknameChk;
		}
	}

	/**
	 * 
	 * @param model   jsp에서 db값을 사용하기 위해 선언
	 * @param session 사용자의 정보를 담기위한 세션
	 * @param curPage 페이징 -> 현재 페이지 지정
	 * @return 각 페이지에 페이징 사용 (관리자,회원)회원 정보 -> uNo값이 1이면 관리자 1이 아니면 회원
	 */
	@RequestMapping(value = "/user/Info.do")
	public String userInfo(Model model, HttpSession session, @RequestParam(defaultValue = "1") int curPage) {

		UserDto userdto = new UserDto();

		userdto = (UserDto) session.getAttribute("_userDto_");

		Map<String, Object> myInfomap = userService.userSelectInfo(userdto.getuNo());
		model.addAttribute("myInfomap", myInfomap);

		int uNo = (int) userdto.getuNo();

		int totalCount = userService.getUserTotalCount(uNo);

		Paging userPaging = new Paging(totalCount, curPage);

		int start = userPaging.getPageBegin();
		int end = userPaging.getPageEnd();

		List<Map<String, Object>> userMapList = userService.viewUserList(uNo, start, end);

		Map<String, Object> uPagingMap = new HashMap<String, Object>();
		uPagingMap.put("userPaging", userPaging);
		uPagingMap.put("totalCount", totalCount);
		uPagingMap.put("start", start);
		uPagingMap.put("end", end);

		model.addAttribute("userMapList", userMapList);
		model.addAttribute("uPagingMap", uPagingMap);
		String viewUrl = "";

		if (uNo == 1) {
			viewUrl = "user/UserManage";
		} else {
			viewUrl = "user/UserMyInfo";
		}

		return viewUrl;
	}

	/**
	 * 
	 * @param userDto     사용자가 입력한 값을 담을 객체
	 * @param nickName    사용자가 입력한 닉네임
	 * @param newpassword 사용자가 입력한 신규 비밀번호
	 * @return (사용자)회원 정보 수정 -> 회원이 입력한 기존비밀번호가 일치하면 회원정보를 수정함 일치하지 않을시 alert(msg)사용
	 */
	@RequestMapping(value = "/user/userUpdate.do", method = RequestMethod.POST)
	public String userUpdate(UserDto userDto, Model model, HttpSession session, String nickName, String newpassword) {

		UserDto uPwd = (UserDto) session.getAttribute("_userDto_");

		String existingPwd = uPwd.getPassword();
		String sessionPwd = userDto.getPassword();

		if (!(sessionPwd.equals(existingPwd))) {
			model.addAttribute("msg", "기존 비밀번호와 일치하지 않습니다.");
			model.addAttribute("url", "redirect:/user/Info.do");

			return "common/UpdateAlert";
		}
		int salt = userDto.addSalt();
		String password = userDto.setHashpwd(salt, newpassword);

		userService.userUpdate(userDto, nickName, password, salt);

		return "redirect:/user/Info.do";
	}

	/**
	 * 
	 * @return 충전버튼 누를시 -> 포인트충전 팝업창 실행
	 */
	@RequestMapping(value = "/user/point.do")
	public String pointView() {
		return "/user/PointPopup";
	}

	/**
	 * 
	 * @param point    사용자가 충전할 포인트 값
	 * @param pointAdd 사용자가 입력한 포인트 값을 담을 객체
	 * @param oNo      db에 들어갈 oNo(0)
	 * @return 포인트 충전 -> 사용자가 입력 or 선택한 값을 db에 저장(회원 포인트, 포인트내역)
	 */
	@RequestMapping(value = "/user/pointAdd.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int pointAdd(@RequestParam("priceSelect") int point, PointAdd pointAdd, HttpSession session,
			@RequestParam(defaultValue = "0") int oNo) {

		UserDto userdto = new UserDto();
		userdto = (UserDto) session.getAttribute("_userDto_");
		pointAdd.setuNo(userdto.getuNo());
		pointAdd.setoNo(oNo);

		userService.addPoint(pointAdd, point);
		userService.pointHistory(pointAdd, point);

		return 1;
	}

	/**
	 * 
	 * @return (관리자,회원)포인트 내역 -> uNo가 1 == 관리자 1 != 회원 -> view 페이지
	 */
	@RequestMapping(value = "/user/pointHistory.do")
	public String viewHistory(HttpSession session, Model model, @RequestParam(defaultValue = "1") int curPage) {
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = (int) userDto.getuNo();

		int totalCount = userService.getUserTotalCount(uNo);

		Paging userPaging = new Paging(totalCount, curPage);

		int start = userPaging.getPageBegin();
		int end = userPaging.getPageEnd();

		List<Map<String, Object>> pointList = userService.pointHistoryList(uNo, start, end);

		model.addAttribute("pointList", pointList);

		List<Map<String, Object>> userMapList = userService.viewUserList(uNo, start, end);

		List<Map<String, Object>> pointManage = userService.viewPointList(uNo, start, end);

		model.addAttribute("pointManage", pointManage);

		Map<String, Object> uPagingMap = new HashMap<String, Object>();
		uPagingMap.put("userPaging", userPaging);
		uPagingMap.put("totalCount", totalCount);
		uPagingMap.put("start", start);
		uPagingMap.put("end", end);

		model.addAttribute("userMapList", userMapList);
		model.addAttribute("uPagingMap", uPagingMap);

		String viewUrl = "";

		if (uNo == 1) {
			viewUrl = "user/PointManage";
		} else {
			viewUrl = "user/PointRechargehistory";
		}

		return viewUrl;

	}

}
