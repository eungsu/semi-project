<%@page import="kr.co.hta.shop.dao.CategoryDao"%>
<%@page import="kr.co.hta.shop.vo.Category"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<%
// 세션에 저장된 로그인된 사용자의 번호, 아이디, 이름을 조회한다.
// 로그인되어있지 않는 사용자인 경우 전부 null값을 가진다.
	Integer loginedUserNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	String loginedUserId = (String) session.getAttribute("LOGINED_USER_ID");
	String loginedUserName = (String) session.getAttribute("LOGINED_USER_NAME");
	
// 모든 카테고리 정보를 조회한다.
// 카테고리 드롭다운 메뉴표시에 사용된다.
	List<Category> categories = CategoryDao.getInstance().getAllCategories();
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<a href="/shop-model1/index.jsp" class="navbar-brand">쇼핑몰</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsible-navbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsible-navbar">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item"><a href="/shop-model1/index.jsp" class="nav-link">홈</a></li>
			<li class="nav-item dropdown">
      			<a class="nav-link dropdown-toggle" href="#" id="navbardrop-1" data-toggle="dropdown">
        			카테고리
		      	</a>
		      	<div class="dropdown-menu">
<!-- 카테고리 드롭다운 메뉴를 표시한다. -->
		      	<%
		      		for (Category category : categories) { 
		      	%>
		        		<a class="dropdown-item" href="/shop-model1/product/list.jsp?catno=<%=category.getNo()%>"><%=category.getName() %></a>
		        <%
		      		}
		        %>
		      	</div>
		    </li>
<!-- 로그인 상태인 경우 사용자 전용 메뉴를 표시한다.  -->
			<%
		    	if (loginedUserNo != null) {
			%>
					<li class="nav-item dropdown">
		      			<a class="nav-link dropdown-toggle" href="#" id="navbardrop-2" data-toggle="dropdown">
		        			마이 메뉴
				      	</a>
				      	<div class="dropdown-menu">
							<a class="dropdown-item"  href="/shop-model1/my/info.jsp" class="nav-link">내정보</a>
							<a class="dropdown-item"  href="/shop-model1/cart/list.jsp" class="nav-link">장바구니</a>
							<a class="dropdown-item"  href="/shop-model1/order/list.jsp" class="nav-link">주문내역</a>
				      	</div>
				    </li>
			<%
		    	}
			%>
		</ul>
<!-- 로그인 상태인 경우 사용자 이름을 표시한다. -->
		<%
			if (loginedUserNo != null) {
		%>
				<span class="navbar-text"><strong class="text-white"><%=loginedUserName %></strong>님 환영합니다.</span>
		<%
			}
		%>
		
		<ul class="navbar-nav ">
<!-- 로그인여부에 따라서 메뉴 표시를 다르게 한다. -->
		<%
			if (loginedUserNo == null) {
		%>
				<li class="nav-item"><a href="/shop-model1/loginform.jsp" class="nav-link">로그인</a></li>
				<li class="nav-item"><a href="/shop-model1/form.jsp" class="nav-link">회원가입</a></li>
		<%
			} else {
		%>
				<li class="nav-item"><a href="/shop-model1/logout.jsp" class="nav-link">로그아웃</a></li>
		<%
			}
		%>
		</ul>	
	</div>
</nav>