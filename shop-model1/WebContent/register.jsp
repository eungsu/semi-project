<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.hta.shop.vo.User"%>
<%@page import="kr.co.hta.shop.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("password2");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	
	if (!password.equals(confirmPassword)) {
		response.sendRedirect("/shop-model1/form.jsp?error=pwd");
		return;
	}
	
	User savedUser = UserDao.getInstance().getUserById(id);
	if (savedUser != null) {
		response.sendRedirect("/shop-model1/form.jsp?error=dup");
		return;
	}
	
	String sha256HexPassword = DigestUtils.sha256Hex(password);
	
	User user = new User();
	user.setName(name);
	user.setId(id);
	user.setPassword(sha256HexPassword);
	user.setTel(tel);
	user.setEmail(email);
	
	UserDao.getInstance().insertUser(user);
	
	response.sendRedirect("/shop-model1/completed.jsp");
	
	
%>