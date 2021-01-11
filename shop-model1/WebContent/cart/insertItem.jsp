<%@page import="kr.co.hta.shop.vo.CartItem"%>
<%@page import="kr.co.hta.shop.dao.CartItemDao"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/loginCheck.jsp" %>
<%
// 장바구니에 새로운 아이템을 추가한다.
	int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
	int amount = StringUtils.stringToInt(request.getParameter("amount"), 1);
	
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	
// 책번호와 사용자번호로 이미 저장된 CartItem이 존재하는지 조회한다.
	CartItem cartItem = CartItemDao.getInstance().getCartItemByBookNoAndUserNo(bookNo, userNo);
// CartItem객체가 존재하지 않으면 CartItem객체를 생성하고, 신규 CartItem 정보를 데이터베이스에 저장한다.
	if (cartItem == null) {
		cartItem = new CartItem();
		cartItem.setBookNo(bookNo);
		cartItem.setUserNo(userNo);
		cartItem.setItemAmount(amount);
		
		CartItemDao.getInstance().insertCartItem(cartItem);
		
// CartItem객체가 존재하면 기존 CartItem에서 갯수를 업데이트 한다.
	} else {
		cartItem.setItemAmount(cartItem.getItemAmount() + amount);
		
		CartItemDao.getInstance().updateCartItem(cartItem);
	}

// 장바구니 리스트를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("/shop-model1/cart/list.jsp");
%>