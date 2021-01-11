<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Shop</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
	<div class="row">
		<div class='col-12'>
			<%@ include file="common/navbar.jsp" %>
		</div>
	</div>
	<%
		String error = request.getParameter("error");
	%>
	
	<%
		if ("empty".equals(error)) {
	%>
	<div class="row">
		<div class="col-6 offset-3">
			<div class="alert alert-danger">
				<strong>오류</strong> 아이디와 비밀번호는 필수 입력값입니다.
			</div>
		</div>
	</div>
	<%
		}
	%>
	
	<%
		if ("invalid".equals(error)) {
	%>
	<div class="row">
		<div class="col-6 offset-3">
			<div class="alert alert-danger">
				<strong>오류</strong> 아이디 혹은 비밀번호가 올바르지 않습니다.
			</div>
		</div>
	</div>
	<%
		}
	%>	
	
	<%
		if ("deny".equals(error)) {
	%>
	<div class="row">
		<div class="col-6 offset-3">
			<div class="alert alert-danger">
				<strong>오류</strong> 로그인이 필요한 서비스에 접속을 시도하였습니다.
			</div>
		</div>
	</div>
	<%
		}
	%>	
	
	<div class="row">
		<div class="col-6 offset-3">
			<div class="card">
				<form id="login-form" method="post" action="login.jsp" onsubmit="checkLoginForm(event)">
					<div class="card-header"><h4>로그인 폼</h4></div>
					<div class="card-body">
						<div class="form-group">
							<label>아이디</label>
							<input type="text" class="form-control" name="id" id="user-id"/>
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="password" class="form-control" name="password" id="user-password"/>
						</div>
						<div class="text-right">
							<a href="/blog/index.jsp" class="btn btn-secondary">취소</a>
							<input type="submit" class="btn btn-primary" value="로그인" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<%@ include file="common/footer.jsp" %>
		</div>
	</div>
</div>
<script type="text/javascript">
	function checkLoginForm(event) {
		var form = document.querySelector("login-form");

		if (!document.querySelector("#user-id").value) {
			alert("아이디은 필수입력값입니다.");
			event.preventDefault();
			return;
		}


		if (!document.querySelector("#user-password").value) {
			alert("비밀번호는 필수입력값입니다.");
			event.preventDefault();
			return;
		}

		form.submit();
	}
</script>
</body>
</html>