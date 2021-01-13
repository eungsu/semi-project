<%@page import="kr.co.hta.shop.dao.CartItemDao"%>
<%@page import="kr.co.hta.shop.vo.CartItem"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/loginCheck.jsp" %>
<%
	int cartItemNo = StringUtils.stringToInt(request.getParameter("cartno"));
	int amount = StringUtils.stringToInt(request.getParameter("amount"));
	
	CartItem cartItem = CartItemDao.getInstance().getCartItemByNo(cartItemNo);
	cartItem.setItemAmount(amount);
	
	CartItemDao.getInstance().updateCartItem(cartItem);
	
	response.sendRedirect("list.jsp");
%>