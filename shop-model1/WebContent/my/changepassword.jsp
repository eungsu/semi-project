<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.hta.shop.dao.UserDao"%>
<%@page import="kr.co.hta.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/loginCheck.jsp" %>
<%
	// 비밀번호 변경처리 처리
	String prePassword = request.getParameter("prevPassword");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("confirmPassword");
	
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	User user = UserDao.getInstance().getUserByNo(userNo);
	
	if (!user.getPassword().equals(DigestUtils.sha256Hex(prePassword))) {
		response.sendRedirect("complete.jsp?error=mismatch");
		return;
	}
	if (!password.equals(confirmPassword)) {
		response.sendRedirect("complete.jsp?error=mismatch");
		return;
	}
	
	user.setPassword(DigestUtils.sha256Hex(password));
	UserDao.getInstance().updateUser(user);
	
	// 비빔번경 완료 처리 후 complete.jsp를 재요청하는 응답을 보낸다.
	response.sendRedirect("complete.jsp");
%>