<%@page import="kr.co.hta.shop.dao.CartItemDao"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/loginCheck.jsp" %>
<%
// 장바구니에서 아이템을 삭제한다.
// 요청파라미터에서 선택된 장바구니 아이템번호를 조회한다.
	String[] cartNoArray = request.getParameterValues("cartno");
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

// 배열을 순회하면서 장바구니 아이템번호에 해당하는 아이텀 정보를 삭제한다. 
	for (String cartNoStr : cartNoArray) {
		int cartItemNo = StringUtils.stringToInt(cartNoStr);
		CartItemDao.getInstance().deleteCartItemByNo(cartItemNo);
	}
	
	response.sendRedirect("list.jsp");
%>