<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/loginCheck.jsp" %>
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
	<style type="text/css">
		.btn-group-xs > .btn, .btn-xs {
		  padding: .45rem .4rem;
		  font-size: .875rem;
		  line-height: .5;
		  border-radius: .2rem;
		}
	</style>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-12">
			<%@ include file="../common/navbar.jsp" %>
		</div>
	</div>
	
	<!-- 시작 -->
	<div class="row mb-3">
<%
	String error = request.getParameter("error");
	if (error == null) {
%>
		<div class="col-12">
			<div class="alert alert-success text-center" style="font-size: 27px;">
				<span><strong><%=loginedUserName %></strong>님 비밀번호 변경이 완료되었습니다.</span><br />
				<span class="mt-2 small">보안을 위해서 비밀번호는 주기적으로 변경해주시기 바라겠습니다.</span>
			</div>
		</div>
<%
	} else {
%>
		<div class="col-12">
			<div class="alert alert-error text-center" style="font-size: 27px;">
				<span><strong><%=loginedUserName %></strong>님 비밀번호가 일치하지 않습니다.</span><br />
				<span class="mt-2 small">내 정보 보기화면에서 다시 시도해 주시기 바랍니다.</span>
			</div>
		</div>
<%
	}
%>	
	</div>
	<div class="row">
		<div class="col-12 mt-3">
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</div>
</body>
</html>