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
	<!-- 주문 상품 정보 시작 -->
	<div class="row mb-3">
		<div class="col-12">
			<div class="alert alert-success text-center" style="font-size: 27px;">
				<span><strong>${LOGINED_USER_NAME }</strong>님 주문이 완료되었습니다.</span><br />
				<span class="mt-2 small">주문번호 : ${param.orderNo } 포인트 적립액 : ${order.totalSavedPoint }원</span>
			</div>
		</div>
		<div class="col-12">
			<div class="card">
				<div class="card-header font-weight-bold">주문상품</div>
				<div class="card-body">
					<table class="table">
						<colgroup>
							<col width="*">
							<col width="10%">
							<col width="10%">
							<col width="7%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th>상품명</th>
								<th>정가</th>
								<th>판매가</th>
								<th>수량</th>
								<th>구매가격</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="item" items="${orderItems }">
							<tr>
								<td>
									<img src="../resources/images/${item.bookNo }.jpg" width="60px" height="88px" />
									<span class="align-top"><a href="../book/detail.hta?bookno=${item.bookNo }&catno=${item.categoryNo}" class="text-body">${item.bookTitle }</a></span>
								</td>
								<td><fmt:formatNumber value="${item.bookPrice }"/>원</td>
								<td>
									<fmt:formatNumber value="${item.itemPrice }"/>원<br/>
									<small>(<fmt:formatNumber value="${item.bookSavePoint }"/>원 적립)</small>
								</td>
								<td><fmt:formatNumber value="${item.itemAmount }"/></td>
								<td><strong><fmt:formatNumber value="${item.orderPrice }"/>원</strong></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="card-footer text-right">
					<span>
					상품 총 금액 : <strong class="mr-5"><fmt:formatNumber value="${order.totalOrderPrice }"/>원</strong> 
					포인트 사용액 : <strong class="mr-5"><fmt:formatNumber value="${order.usedPointAmount }"/>원</strong>
					총 결재 금액 : <strong class="mr-5 text-danger"><fmt:formatNumber value="${order.totalPaymentPrice }"/>원</strong> 
					</span>
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