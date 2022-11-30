import javax.servlet.http.HttpSession;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fm.order.model.CartDto;
import com.fm.user.model.UserDto;

public class bin {
//	/**
//	 * 유효성 검사 추가 필요 장바구니 추가 기능
//	 * 
//	 * @param session 세션에 있는uNo를 가지고 오기 위한 객체
//	 * @param model   화면 구성을 위한 객체
//	 * @param iNo     장바구니에 추가할 제품번호
//	 * @param iCount  장바구니에 추가할 제품갯수
//	 * @return 화면에서 이동할 것인지 아닌지 선택한 값을 통해 다르게 리턴
//	 */
//	@Transactional
//	@RequestMapping(value = "/cart/add.do", method = { RequestMethod.GET, RequestMethod.POST })
//	public String addCart(HttpSession session, Model model, @RequestParam(defaultValue = "0") int iNo,
//			@RequestParam(defaultValue = "0") int ctCount) {
//		logger.info("Welcome addCart!");
//
//		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
//		int uNo = (int) userDto.getuNo();
//
//		orderService.addCart(uNo, iNo, ctCount);
//
//		// 화면에서 남아 있을것인지 아닌지 확인 받아서 들어온 값에 따라 리턴을 다르게 한다
//		return "redirect:/cart/list.do";
//	}
	
//	/**
//	 * 유효성 검사 추가 필요 / ctNo와 ino를 통해 장바구니 번호를 검색해야하는 지의 여부는 생각해 볼것 장바구니에 있는 물품을 지우는 기능
//	 * 
//	 * @param session 세션에 저장된 uNo를 가져오기 위한 객체
//	 * @param ctNo     장바구니 물품의 고유 값
//	 * @return 장바구니리스트 페이지 호출
//	 */
//	@RequestMapping(value = "/cart/delete.do", method = { RequestMethod.GET, RequestMethod.POST })
//	public String deleteCart(HttpSession session, Model model, int ctNo) {
//		logger.debug("welcome cartDelete");
//
//		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
//		int uNo = (int) userDto.getuNo();
//		
//		orderService.deleteCart(uNo, ctNo);
//
//		return "redirect:/cart/list.do";
//	}
	
//	/**
//	 * cart 수량 업데이트 기능
//	 * 
//	 * @param session 세션에 저장된 uNo를 가져오기 위한 객체
//	 * @param cartDto 화면에서 cCount를 가져오기 위한 객체
//	 * @return 성공하면 1 실패하면 -1를 리턴
//	 * @throws Exception
//	 */
//	@RequestMapping(value = "/cart/update.do", method = RequestMethod.POST)
//	public String updateCart(HttpSession session, CartDto cartDto, Model model) throws Exception {
//		logger.debug("Welcome cartUpdate" + cartDto.getCtNo() + "" + cartDto.getCtCount());
//
//		int count = 0;
//
//		UserDto userDto = (UserDto) session.getAttribute("_userDto_");
//
//		cartDto.setuNo(userDto.getuNo());
//
//		count = orderService.updateCart(cartDto);
//
//		return "redirect:/cart/list.do";
//	}
}
