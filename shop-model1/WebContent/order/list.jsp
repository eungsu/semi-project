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
	
	<!-- 주문 내역 시작 -->
	<div class="row mb-3">
		<div class="col-12">
			<div class="card">
				<div class="card-header font-weight-bold">주문 내역</div>
				<div class="card-body">
					<table class="table">
						<thead>
							<tr>
								<th>주문번호</th>
								<th>주문일자</th>
								<th>주문내역</th>
								<th>주문금액/수량</th>
								<th>주문상태</th>
								<th>주문자</th>
								<th>수령자</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><a href="detail.jsp">100000410</a></td>
								<td>2020-12-20</td>
								<td><a href="detail.jsp">이것이 자바다 외 2종</a></td>
								<td>45,000원/3</td>
								<td><span class="text-success">결재완료</span></td>
								<td>홍길동</td>
								<td>홍길동</td>
							</tr>
							<tr>
								<td><a href="detail.jsp">100000410</a></td>
								<td>2020-12-20</td>
								<td><a href="detail.jsp">이것이 자바다 외 2종</a></td>
								<td>45,000원/3</td>
								<td><span class="text-success">결재완료</span></td>
								<td>홍길동</td>
								<td>홍길동</td>
							</tr>
							<tr>
								<td><a href="detail.jsp">100000410</a></td>
								<td>2020-12-20</td>
								<td><a href="detail.jsp">이것이 자바다 외 2종</a></td>
								<td>45,000원/3</td>
								<td><span class="text-success">결재완료</span></td>
								<td>홍길동</td>
								<td>홍길동</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 주문 상품 정보 끝 -->
	
	<div class="row">
		<div class="col-12 mt-3">
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</div>
</body>
</html>