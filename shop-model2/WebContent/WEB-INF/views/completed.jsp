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
		<div class="col-12">
			<%@ include file="common/navbar.jsp" %>
		</div>
	</div>
	<div class="row mb-5">
		<div class="col-12">
			<div class="card bg-success text-white">
				<div class="card-body">
					<h4 class="card-title">회원가입 완료</h4>
					<p class="card-text">회원가입이 정상적으로 완료되었습니다.</p>
					<p class="card-text">로그인 후 다양한 서비스를 사용해보기 바랍니다.</p>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12 mt-5">
			<%@ include file="common/footer.jsp" %>
		</div>
	</div>
</div>
</body>
</html>