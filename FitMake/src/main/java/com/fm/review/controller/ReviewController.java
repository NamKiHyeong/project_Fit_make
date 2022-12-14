package com.fm.review.controller;

import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.review.model.ReviewDto;
import com.fm.review.service.ReviewService;
import com.fm.user.model.UserDto;
import com.fm.util.Paging;

@Controller
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ReviewService reviewService;

	/**
	 * Create 리뷰 추가 화면으로 보내는 컨트롤러인데 어느 제품의 리뷰인지를 알기위함
	 * 
	 * @param iNo   제품No
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/review/add.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String reviewAdd(@RequestParam(defaultValue = "0") int iNo, @RequestParam(defaultValue = "0") int oNo,
			Model model, HttpSession session) {
		try {
			model.addAttribute("iNo", iNo);
			model.addAttribute("oNo", oNo);
			return "/review/ReviewAdd";
		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}

	}

	/**
	 * 비동기 리뷰를 작성하고자 하는 제품 정보 확인
	 * 
	 * @param session 회원정보를 확인하기 위한 객체
	 * @return 회원이 리뷰를 작성할 수 있는 제품 정보
	 */
	@ResponseBody
	@RequestMapping(value = "/review/compose.do", method = { RequestMethod.GET, RequestMethod.POST })
	public List<Map<String, Object>> reviewCompose(HttpSession session, @RequestParam(value = "oNo") int oNo) {
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = userDto.getuNo();

		List<Map<String, Object>> myReviewOrderItemList = reviewService.getOrderList(uNo, oNo);

		return myReviewOrderItemList;
	}

	/**
	 * 비동기 리뷰 작성 확인
	 * 
	 * @param session 회원번호를 얻기 위한 객체
	 * @param oNo     리뷰 작성할 주문 번호
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/review/check.do", method = { RequestMethod.GET, RequestMethod.POST })
	public int reviewCheck(HttpSession session, @RequestParam(value = "oNo") int oNo) {
		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
		int uNo = userDto.getuNo();

		List<Map<String, Object>> myReviewOrderItemList = reviewService.getOrderList(uNo, oNo);
		int result = myReviewOrderItemList.size();
		
		return result;
	}

	/**
	 * 리뷰 추가 버튼
	 * 
	 * @param reviewDto  리뷰를 추가하기 위해서 받아야하는 값이 많은데 그 값을 한번에 받기 위한 Dto
	 * @param model
	 * @param mulRequest Info와 이미지를 한번에 요청하기 위함
	 * @return
	 */
	@RequestMapping(value = "/review/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String reviewAddCtr(ReviewDto reviewDto, Model model, MultipartHttpServletRequest mulRequest) {

		try {
			reviewService.reviewInsert(reviewDto, mulRequest);
			return "redirect:/review/list.do?iNo=" + reviewDto.getiNo();
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/auth/login.do";
		}

	}

	/**
	 * Read list
	 * 
	 * @param iNo     제품No
	 * @param curPage 현재 페이지
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/review/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String reviewSelectList(@RequestParam(defaultValue = "0") int iNo,
			@RequestParam(defaultValue = "1") int curPage, Model model) {

		try {
			// 페이지 수를 정하기 위해서 리뷰의 총 수를 정함
			int totalReviewCount = reviewService.reviewSelectTotalReviewCount(iNo);

			// 페이지를 구성하기 위한 변수명들
			Paging reviewPaging = new Paging(totalReviewCount, curPage);
			int start = reviewPaging.getPageBegin();
			int end = reviewPaging.getPageEnd();

			// 모든 리뷰를 가져온다.
			List<Map<String, Object>> reviewList = reviewService.reviewSelectList(iNo, start, end);

			Map<String, Object> searchMap = new HashMap<>();
			Map<String, Object> pagingMap = new HashMap<>();

			// 모든 리뷰를 화면에서 다른 컨트롤러로 쓸 수 있도록 보냄
			pagingMap.put("iNo", iNo);
			pagingMap.put("reviewPaging", reviewPaging);
			pagingMap.put("totalItemCount", totalReviewCount);

			model.addAttribute("reviewList", reviewList);
			model.addAttribute("pagingMap", pagingMap);
			model.addAttribute("searchMap", searchMap);

			return "/review/ReviewList";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/auth/login.do";
		}

	}

	/**
	 * Read one
	 * 
	 * @param iNo     제품No
	 * @param curPage 현제 페이지
	 * @param rNo     리뷰No
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/review/one.do", method = RequestMethod.GET)
	public String reviewSelectOne(@RequestParam int iNo, @RequestParam int curPage, int rNo, Model model) {

		try {
			Map<String, Object> prevMap = new HashMap<String, Object>();
			prevMap.put("iNo", iNo);
			prevMap.put("curPage", curPage);

			Map<String, Object> map = reviewService.reviewSelectOne(rNo);

			ReviewDto reviewDto = (ReviewDto) map.get("reviewDto");

			List<Map<String, Object>> fileList2 = (List<Map<String, Object>>) map.get("fileList2");

			model.addAttribute("reviewDto", reviewDto);
			model.addAttribute("fileList2", fileList2);
			model.addAttribute("prevMap", prevMap);

			return "/review/ReviewOne";
		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}

	}

	/**
	 * update
	 * 
	 * @param iNo
	 * @param curPage
	 * @param rNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/review/update.do", method = RequestMethod.GET)
	public String reviewUpdate(int iNo, int curPage, int rNo, Model model) {

		try {
			Map<String, Object> prevMap = new HashMap<>();
			prevMap.put("iNo", iNo);
			prevMap.put("curPage", curPage);

			// 업데이트할 하나의 리뷰를 가져옴
			Map<String, Object> map = reviewService.reviewSelectOne(rNo);

			ReviewDto reviewDto = (ReviewDto) map.get("reviewDto");

			List<Map<String, Object>> fileList2 = (List<Map<String, Object>>) map.get("fileList2");

			model.addAttribute("reviewDto", reviewDto);
			model.addAttribute("prevMap", prevMap);
			model.addAttribute("fileList2", fileList2);

			return "review/ReviewUpdate";
		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}

	}

	// 업데이트 버튼
	@RequestMapping(value = "/review/updateCtr.do", method = RequestMethod.POST)
	public String reviewUpdateCtr(HttpSession session, int curPage, ReviewDto reviewDto,
			@RequestParam(value = "fileIdx", defaultValue = "-1") int imgNo, MultipartHttpServletRequest mulRequest,
			Model model) {

		try {
			int iNo = reviewDto.getiNo();
			reviewService.reviewUpdateOne(reviewDto, mulRequest, imgNo);
			return "redirect:/review/list.do?iNo=" + iNo;

		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}

	}

	/**
	 * 삭제버튼
	 * 
	 * @param rNo
	 * @param iNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/review/deleteOne.do", method = RequestMethod.GET)
	public String reviewDelete(int rNo, int iNo, Model model) {
		try {
			reviewService.reviewDeleteOne(rNo);
			return "redirect:/review/list.do?iNo=" + iNo;
		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}

	}
}
