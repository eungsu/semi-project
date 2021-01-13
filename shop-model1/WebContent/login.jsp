<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.hta.shop.vo.User"%>
<%@page import="kr.co.hta.shop.dao.UserDao"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userId = request.getParameter("id");
	String userPassword = request.getParameter("password");
	
	if (StringUtils.isEmpty(userId)) {
		response.sendRedirect("loginform.jsp?error=empty");
		return;
	}
	if (StringUtils.isEmpty(userPassword)) {
		response.sendRedirect("loginform.jsp?error=empty");
		return;
	}
	
	User savedUser = UserDao.getInstance().getUserById(userId);
	if (savedUser == null) {
		response.sendRedirect("loginform.jsp?error=invalid");
		return;
	}
	
	String sha256HexPasssword = DigestUtils.sha256Hex(userPassword);
	if (!savedUser.getPassword().equals(sha256HexPasssword)) {
		response.sendRedirect("loginform.jsp?error=invalid");
		return;
	}
	
	session.setAttribute("LOGINED_USER_NO", savedUser.getNo());
	session.setAttribute("LOGINED_USER_ID", savedUser.getId());
	session.setAttribute("LOGINED_USER_NAME", savedUser.getName());
	
	response.sendRedirect("index.jsp");
%>