package com.fm.item.controller;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.item.model.ItemDto;
import com.fm.item.service.ItemService;
import com.fm.user.model.UserDto;
import com.fm.util.Paging;

@Controller
public class ItemController {
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	@Autowired
	private ItemService itemService;

	/**
	 * Create!!! Item Add
	 * 
	 * @param itemDto
	 * @param mulRequest
	 * @param model
	 * @return MultipartHttpServletRequest mulRequest 나중에 sub을 사용할 때 사용하기
	 */
	@RequestMapping(value = "/item/add.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String itemAdd(Model model, int cNo) {
		logger.trace("제품 추가해봅시다!" + model);
		logger.info("cNo {} ");

		model.addAttribute("cNo", cNo);
		return "/item/ItemAdd"; // jsp 주소로
	}

	@RequestMapping(value = "/item/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String itemAddCtr(ItemDto itemDto, Model model, MultipartHttpServletRequest mulRequest) {
		logger.trace("제품 추가합니다!" + itemDto);
		try {
			itemService.itemInsertOne(itemDto, mulRequest);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("예외임");
			e.printStackTrace();
		}
		logger.info("카테고리 번호 있나?", itemDto.getcNo());

		return "redirect:/item/list.do?cNo=" + itemDto.getcNo();
	}

	/**
	 * Read!!!
	 * 
	 * @param itemDto
	 * @param model   spirng에서 지원해준 화면 구성을 위해서 받아온 객체
	 * @return 1단계 리스트 나오는지 확인 2단계 검색 기능 넣고서 나오는지 확인 3단계 페이징 확인
	 */
	@RequestMapping(value = "/item/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String itemList(@RequestParam(defaultValue = "1") int curPage
			, ItemDto itemDto, @RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "0") int older
			, Model model, HttpSession session) {
		
		UserDto userDto = (UserDto)session.getAttribute("_userDto_");
		int uNo = userDto.getuNo();
		int cNo = itemDto.getcNo();
		int totalItemCount = 0;
		List<ItemDto> itemList = null;
		Paging itemPaging = null;
		
		if(cNo > 2) {
			
			totalItemCount = itemService.itemSelectTotalItemCount(cNo, keyword, 0);
			
			itemPaging = new Paging(totalItemCount, curPage);
			int start = itemPaging.getPageBegin();
			int end = itemPaging.getPageEnd();
			
			itemList = itemService.itemSelectList(cNo, keyword, start, end, older, 0);
			
		} else if (cNo == 2) {
			
			totalItemCount = itemService.itemSelectTotalItemCount(cNo, keyword, -1);
			
			itemPaging = new Paging(totalItemCount, curPage);
			int start = itemPaging.getPageBegin();
			int end = itemPaging.getPageEnd();
			
			itemList = itemService.viewBestItemList(cNo, keyword, start, end, older, -1);
		} else {
			
			totalItemCount = itemService.itemSelectTotalItemCount(cNo, keyword, uNo);
			
			itemPaging = new Paging(totalItemCount, curPage);
			int start = itemPaging.getPageBegin();
			int end = itemPaging.getPageEnd();
			
			itemList = itemService.viewRecommendItemList(cNo, keyword, start, end, older, uNo);
			
		}
		
		String categoryName = itemService.getCategoryName(cNo);
		
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("keyword", keyword);
		
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("itemPaging", itemPaging);
		pagingMap.put("totalItemCount", totalItemCount);
		pagingMap.put("older", older);
		pagingMap.put("cNo", cNo);
		
		model.addAttribute("itemList", itemList);
		model.addAttribute("pagingMap", pagingMap);
		model.addAttribute("searchMap", searchMap);
		model.addAttribute("categoryName", categoryName);
		return "/item/ItemList";
	}

	@RequestMapping(value = "/item/one.do", method = RequestMethod.GET)
	public String itemOne(@RequestParam(defaultValue = "0") int curPage, @RequestParam(defaultValue = "0") int cNo, 
			@RequestParam(defaultValue = "1") int iNo, Model model) {
//		RedirectAttributes redirect
		logger.trace("제품 상세정보" + model);

		Map<String, Object> prevMap = new HashMap<>();
		prevMap.put("cNo", cNo);
		prevMap.put("curPage", curPage);

		Map<String, Object> map = itemService.itemSelectOne(iNo);

		ItemDto itemDto = (ItemDto) map.get("itemDto");

		logger.debug("one.do에서 itemDto에 iNo 값이 들어가 있니?{}", itemDto);

		List<Map<String, Object>> fileList = (List<Map<String, Object>>) map.get("fileList");

		logger.info("one.do에서 cNo 확인해본다 {}", itemDto.getcNo());
		logger.info("one.do에서 curPage확인해본다 {}", curPage);

		model.addAttribute("itemDto", itemDto);
		model.addAttribute("fileList", fileList);
		model.addAttribute("prevMap", prevMap);

		return "/item/ItemOne";
	}

	/**
	 * Update!!!!!!!
	 * 
	 * @param iNo를  Service랑 Dao는 안해도 되는데 왜 여기만 꼭 마바티스에서 바꿔준 걸로 써야할까?
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/update.do", method = RequestMethod.GET)
	public String itemUpdate(int curPage, int cNo, int iNo, Model model) {
		logger.trace("수정하는 DB에 접속" + curPage);

		Map<String, Object> prevMap = new HashMap<>();
		prevMap.put("cNo", cNo);
		prevMap.put("curPage", curPage);

		Map<String, Object> map = itemService.itemSelectOne(iNo);

		ItemDto itemDto = (ItemDto) map.get("itemDto");

		List<Map<String, Object>> fileList = (List<Map<String, Object>>) map.get("fileList");

		System.out.println("update.do에서 " + iNo);

		model.addAttribute("itemDto", itemDto);
		model.addAttribute("prevMap", prevMap);
		if (fileList.size() != 0) {
			model.addAttribute("img", fileList.get(0));
//			model.addAttribute("fileList", fileList);
		}

		return "item/ItemUpdate";
	}

	@RequestMapping(value = "/item/updateCtr.do", method = RequestMethod.POST)
	public String itemUpdateCtr(int curPage, HttpSession session, ItemDto itemDto,
			@RequestParam(value = "imgNo", defaultValue = "-1") int imgNo, MultipartHttpServletRequest mulRequest,
			Model model) {
		logger.info("컨트롤러 서비스로 curPage {} ", curPage);
		logger.info("컨트롤러 서비스로 cNo {} ", itemDto);
		logger.info("컨트롤러 서비스로 imgNo {} ", imgNo);
		int cNo = itemDto.getcNo();

		try {
			itemService.itemUpdateOne(itemDto, mulRequest, imgNo);

		} catch (Exception e) {
			System.out.println("컨트롤 업데이트 예외 발생");
			e.printStackTrace();

		}

		return "redirect:/item/list.do?cNo=" + cNo;

	}

	/**
	 * Delete
	 * 
	 * @param iNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/deleteOne.do", method = RequestMethod.GET)
	public String itemDelete(int iNo, int cNo, Model model) {
		logger.info("삭제기능" + iNo);
		itemService.itemDeleteOne(iNo);
		logger.info("삭제기능");
		return "redirect:/item/list.do?cNo=" + cNo;

	}
}
