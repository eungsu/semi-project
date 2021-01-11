<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	로그인된 사용자인지 체크하고, 로그인되어있지 않는 사용자인 경우 로그인폼을 재요청하는 URL을 응답으로 보낸다.
	로그인이 반드시 필요한 JSP 페이지에 포함시켜서 로그인 여부를 체크하게 한다.
 -->
<%
	
	if (session.getAttribute("LOGINED_USER_NO") == null) {
		response.sendRedirect("/shop-model1/loginform.jsp?error=deny");
		return;
	}
%>