<%@ page pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<a href="/shop-model2/main.hta" class="navbar-brand">쇼핑몰</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsible-navbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsible-navbar">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item"><a href="/shop-model2/main.hta" class="nav-link">홈</a></li>
			<li class="nav-item dropdown">
      			<a class="nav-link dropdown-toggle" href="#" id="navbardrop-1" data-toggle="dropdown">
        			카테고리
		      	</a>
		      	<div class="dropdown-menu">
					<c:forEach var="category" items="${categories }">
		        		<a class="dropdown-item" href="/shop-model2/book/list.hta?catno=${category.no }">${category.name }</a>
					</c:forEach>
		      	</div>
		    </li>
		    <c:if test="${not empty LOGINED_USER_NO }">
				<li class="nav-item dropdown">
	      			<a class="nav-link dropdown-toggle" href="#" id="navbardrop-2" data-toggle="dropdown">
	        			마이 메뉴
			      	</a>
			      	<div class="dropdown-menu">
						<a class="dropdown-item"  href="/shop-model2/my/info.hta" class="nav-link">내정보</a>
						<a class="dropdown-item"  href="/shop-model2/cart/list.hta" class="nav-link">장바구니</a>
						<a class="dropdown-item"  href="/shop-model2/order/list.hta" class="nav-link">주문내역</a>
			      	</div>
			    </li>
		    </c:if>
		</ul>
		
		<c:if test="${not empty LOGINED_USER_NO }">
			<span class="navbar-text"><strong class="text-white">${LOGINED_USER_NAME }</strong>님 환영합니다.</span>
		</c:if>
		
		<ul class="navbar-nav ">
			<c:if test="${empty LOGINED_USER_NO }">
				<li class="nav-item"><a href="/shop-model2/loginform.hta" class="nav-link">로그인</a></li>
				<li class="nav-item"><a href="/shop-model2/form.hta" class="nav-link">회원가입</a></li>
			</c:if>
			<c:if test="${not empty LOGINED_USER_NO}">
				<li class="nav-item"><a href="/shop-model2/logout.hta" class="nav-link">로그아웃</a></li>
			</c:if>
		</ul>	
	</div>
</nav>