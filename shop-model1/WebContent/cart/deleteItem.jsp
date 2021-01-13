<%@page import="kr.co.hta.shop.dao.CartItemDao"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/loginCheck.jsp" %>
<%
// 장바구니에서 아이템을 삭제한다.
	String[] cartNoArray = request.getParameterValues("cartno");
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	
	for (String cartNoStr : cartNoArray) {
		int cartItemNo = StringUtils.stringToInt(cartNoStr);
		CartItemDao.getInstance().deleteCartItemByNo(cartItemNo, userNo);
	}
	
	response.sendRedirect("list.jsp");
%>