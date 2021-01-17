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
	<c:choose>
		<c:when test="${order.userNo ne LOGINED_USER_NO }">
			<div class="alert alert-warning">
				<strong>조회 실패</strong> 다른 사용자의 주문정보를 조회할 수 없습니다.
			</div>
		</c:when>
		<c:otherwise>
			<!-- 주문 상품 정보 시작 -->
			<div class="row mb-3">
				<div class="col-12">
					<div class="card">
						<div class="card-header font-weight-bold">주문 상세 정보</div>
						<div class="card-body">
							<table class="table table-bordered">
								<colgroup>
									<col width="18%">
									<col width="32%">
									<col width="18%">
									<col width="32%">
								</colgroup>
								<tbody>
									<tr>	
										<th>주문번호</th>
										<td><strong>${order.no}</strong></td>
										<th>주문상태</th>
										<td><strong>${order.status }</strong><a href="cancel.hta?orderno=${order.no }" class="btn btn-danger btn-xs float-right ${order.status eq '주문취소' ? 'disabled' : '' }">주문취소</a></td><!-- 주문취소 버튼은 결재완료 상태일 때만 표시됨 -->
									</tr>
									<tr>
										<th>주문일자</th><td><fmt:formatDate value="${order.createdDate }"/></td>
										<th>주문하신 분</th><td>${LOGINED_USER_NAME }</td>
									</tr>
									<tr>
										<th>받으시는 분</th><td>${order.recipientName }</td>
										<th>받으시는 분 연락처</th><td>${order.recipientTel }</td>
									</tr>
									<tr>
										<th>주소</th><td colspan="3"> (${order.recipientZipcode }) ${order.recipientAddress }</td>
									</tr>
									<tr>
										<th>총 주문 금액</th><td colspan="3"><strong><fmt:formatNumber value="${order.totalOrderPrice }"/></strong>원</td>
									</tr>
									<tr>
										<th>결재금액</th><td><strong class="text-danger"><fmt:formatNumber value="${order.totalPaymentPrice }"/></strong>원 (포인트: <span class="text-primary">${item.usedPointAmount }</span>원 사용)</td>
										<th>포인트 적립액</th><td><strong class="text-danger"><fmt:formatNumber value="${order.totalSavedPoint }"/></strong>원</td>
									</tr>
								</tbody>
							</table>
						</div>
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
											<span class="align-top"><a href="../book/detail.hta?bookno=${item.bookNo}&catno=${item.categoryNo }" class="text-body">${item.bookTitle}</a></span>
										</td>
										<td><fmt:formatNumber value="${item.bookPrice }"/>원</td>
										<td>
											<fmt:formatNumber value="${item.itemPrice }" />원<br/>
											<small>(<fmt:formatNumber value="${item.bookSavePoint }"/>원 적립)</small>
										</td>
										<td><fmt:formatNumber value="${item.itemAmount }"/></td>
										<td><strong><fmt:formatNumber value="${item.orderPrice }" />원</strong></td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	
	<div class="row">
		<div class="col-12 mt-3">
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</div>
</body>
</html>