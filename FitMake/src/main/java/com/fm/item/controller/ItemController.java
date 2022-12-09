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

	/** Create
	 * 
	 * @param model
	 * @param cNo	카테고리No	카테고리에 맞는 제품을 추가하기 위함
	 * @return
	 */
	@RequestMapping(value = "/item/add.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String itemAdd(Model model, int cNo) {
		try {
			model.addAttribute("cNo", cNo);
			return "/item/ItemAdd"; 
		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}
	}
	//아이템 추가 버튼
	@RequestMapping(value = "/item/addCtr.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String itemAddCtr(ItemDto itemDto, Model model, MultipartHttpServletRequest mulRequest) {
		try {
			itemService.itemInsertOne(itemDto, mulRequest);
			return "redirect:/item/list.do?cNo=" + itemDto.getcNo();
		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}

	}

	/** Read
	 * list
	 * @param curPage	현재 페이지
	 * @param itemDto	제품Dto로 많은 것을 받아야 함으로 Dto로 받음
	 * @param keyword	검색 기능
	 * @param older		높은 , 낮은 가격순으로 정렬하기 위한 변수
	 * @param model
	 * @param session	유저의 정보만 담겨 있는데 사용하기 위해서 가져옴
	 * @return
	 */
	@RequestMapping(value = "/item/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String itemList(@RequestParam(defaultValue = "1") int curPage
			, ItemDto itemDto, @RequestParam(defaultValue = "") String keyword
			, @RequestParam(defaultValue = "1") int cNo
			, @RequestParam(defaultValue = "0") int older
			, Model model, HttpSession session
			, @RequestParam(defaultValue = "1") int start
			, @RequestParam(defaultValue = "6") int end) {
		
		UserDto userDto = (UserDto)session.getAttribute("_userDto_");
		int uNo = userDto.getuNo();
		cNo = itemDto.getcNo();
		int totalItemCount = 0;
		List<ItemDto> itemList = null;
		Paging itemPaging = null;
		
		try {
			
			if(cNo > 2) {
				
				totalItemCount = itemService.itemSelectTotalItemCount(cNo, keyword, 0);
				
				itemPaging = new Paging(totalItemCount, curPage);
				start = itemPaging.getPageBegin();
				end = itemPaging.getPageEnd();
				
				itemList = itemService.itemSelectList(cNo, keyword, start, end, older, 0);
				
			} else if (cNo == 2) {
				
				totalItemCount = itemService.itemSelectTotalItemCount(cNo, keyword, -1);
				
				itemPaging = new Paging(totalItemCount, curPage);
				start = itemPaging.getPageBegin();
				end = itemPaging.getPageEnd();
				
				itemList = itemService.viewBestItemList(cNo, keyword, start, end, older, -1);
			} else {
				
				totalItemCount = itemService.itemSelectTotalItemCount(cNo, keyword, uNo);
				
				itemPaging = new Paging(totalItemCount, curPage);
				start = itemPaging.getPageBegin();
				end = itemPaging.getPageEnd();
				
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
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/auth/login.do";
		}
		
	}
	/**
	 * one
	 * @param curPage
	 * @param cNo
	 * @param iNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/one.do", method = RequestMethod.GET)
	public String itemOne(@RequestParam(defaultValue = "0") int curPage, @RequestParam(defaultValue = "0") int cNo
			, @RequestParam(defaultValue = "1") int iNo, Model model) {
		
		try {
			Map<String, Object> prevMap = new HashMap<>();
			prevMap.put("cNo", cNo);
			prevMap.put("curPage", curPage);

			Map<String, Object> map = itemService.itemSelectOne(iNo);

			ItemDto itemDto = (ItemDto) map.get("itemDto");

			List<Map<String, Object>> fileList = (List<Map<String, Object>>) map.get("fileList");

			model.addAttribute("itemDto", itemDto);
			model.addAttribute("fileList", fileList);
			model.addAttribute("prevMap", prevMap);

			return "/item/ItemOne";
		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}
		
	}

	/** Update
	 * 
	 * @param curPage
	 * @param cNo
	 * @param iNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/update.do", method = RequestMethod.GET)
	public String itemUpdate(int curPage, int cNo, int iNo, Model model) {
		
		try {
			Map<String, Object> prevMap = new HashMap<>();
			prevMap.put("cNo", cNo);
			prevMap.put("curPage", curPage);

			Map<String, Object> map = itemService.itemSelectOne(iNo);

			ItemDto itemDto = (ItemDto) map.get("itemDto");

			List<Map<String, Object>> fileList = (List<Map<String, Object>>) map.get("fileList");

			model.addAttribute("itemDto", itemDto);
			model.addAttribute("prevMap", prevMap);
			if (fileList.size() != 0) {
				model.addAttribute("img", fileList.get(0));
			}

			return "item/ItemUpdate";
		} catch (Exception e) {
			return "redirect:/auth/login.do";
		}
		
	}

	// 업데이트 버튼
	@RequestMapping(value = "/item/updateCtr.do", method = RequestMethod.POST)
	public String itemUpdateCtr(int curPage, HttpSession session, ItemDto itemDto,
			@RequestParam(value = "imgNo", defaultValue = "-1") int imgNo
			, MultipartHttpServletRequest mulRequest , Model model) {
		
		int cNo = itemDto.getcNo();

		try {
			itemService.itemUpdateOne(itemDto, mulRequest, imgNo);
			return "redirect:/item/list.do?cNo=" + cNo;
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/auth/login.do";
		}
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
		try {
			itemService.itemDeleteOne(iNo);
			return "redirect:/item/list.do?cNo=" + cNo;
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/auth/login.do";
		}
	}
}
