package kr.co.hta.shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hta.shop.dao.CartItemDao;
import kr.co.hta.shop.dto.CartItemDto;
import kr.co.hta.shop.util.StringUtils;
import kr.co.hta.shop.vo.CartItem;
import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class CartController {

	private CartItemDao cartItemDao = CartItemDao.getInstance();

	@RequestMapping("/cart/list.hta")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("cart/list.jsp");

		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

		List<CartItemDto> cartItemDtoList = cartItemDao.getCartItemDtosByUserNo(userNo);

		int totalOrderPrice = cartItemDtoList.stream().mapToInt(item -> item.getBookSalePrice()*item.getItemAmount()).sum();
		int totalSavePoint = cartItemDtoList.stream().mapToInt(item -> item.getBookSavePoint()*item.getItemAmount()).sum();

		mav.addAttribute("cartItems", cartItemDtoList);
		mav.addAttribute("totalOrderPrice", totalOrderPrice);
		mav.addAttribute("totalSavePoint", totalSavePoint);

		return mav;
	}

	@RequestMapping("/cart/insertItem.hta")
	public ModelAndView insertItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
		int amount = StringUtils.stringToInt(request.getParameter("amount"), 1);

		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

		CartItem cartItem = cartItemDao.getCartItemByBookNoAndUserNo(bookNo, userNo);
		if (cartItem == null) {
			cartItem = new CartItem();
			cartItem.setBookNo(bookNo);
			cartItem.setUserNo(userNo);
			cartItem.setItemAmount(amount);
			cartItemDao.insertCartItem(cartItem);
		} else {
			cartItem.setItemAmount(cartItem.getItemAmount() + amount);
			cartItemDao.updateCartItem(cartItem);
		}
		mav.setViewName("redirect:list.hta");

		return mav;
	}

	@RequestMapping("/cart/deleteItem.hta")
	public ModelAndView deleteItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		String[] cartNoArray = request.getParameterValues("cartno");
		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

		for (String cartNoStr : cartNoArray) {
			int cartItemNo = StringUtils.stringToInt(cartNoStr);
			cartItemDao.deleteCartItemByNo(cartItemNo);
		}

		mav.setViewName("redirect:list.hta");

		return mav;
	}
	
	@RequestMapping("/cart/updateItem.hta")
	public ModelAndView updateItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		int cartItemNo = StringUtils.stringToInt(request.getParameter("cartno"));
		int amount = StringUtils.stringToInt(request.getParameter("amount"));
		
		CartItem cartItem = cartItemDao.getCartItemByNo(cartItemNo);
		cartItem.setItemAmount(amount);
		
		cartItemDao.updateCartItem(cartItem);
		
		mav.setViewName("redirect:list.hta");
		
		return mav;
	}
}
