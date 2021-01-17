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
	<div class="row mb-3">
		<div class="col-12">
			<div class="card">
				<div class="card-header font-weight-bold">장바구니</div>
				<div class="card-body">
				<form id="cart-form" method="post" action="../order/form.hta">
					<table class="table">
						<colgroup>
							<col width="2%">
							<col width="*">
							<col width="10%">
							<col width="10%">
							<col width="7%">
							<col width="15%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="chk-all" checked onchange="toggleAllChecked()"/></th>
								<th>상품명</th>
								<th>정가</th>
								<th>판매가</th>
								<th>수량</th>
								<th>구매가격</th>
								<th>주문</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
							<c:when test="${empty cartItems }">
								<tr>
									<td colspan="7" class="text-center">장바구니가 비어 있습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="dto" items="${cartItems }">
									<tr>
										<td><input type="checkbox" name="cartno" value="${dto.itemNo }" checked /></td>
										<td>
											<img src="../resources/images/${dto.bookNo }.jpg" width="60px" height="88px" />
											<span class="align-top">
												<a href="../book/detail.hta?bookno=${dto.bookNo }&catno=${dto.categoryNo}" class="text-body">${dto.bookTitle }</a>
											</span>
										</td>
										<td><fmt:formatNumber value="${dto.bookPrice }" />원</td>
										<td>
											<fmt:formatNumber value="${dto.bookSalePrice }"/>원<br/>
											<small>(<fmt:formatNumber value="${dto.bookSavePoint }" />원 적립)</small>
										</td>
										<td>
											<input type="number" name="amount" id="amount-${dto.itemNo }" value="${dto.itemAmount }" style="width: 43px; height: 20px;"/><br/>
											<button type="button" class="btn btn-outline-secondary btn-xs" onclick="changeAmount(${dto.itemNo })" >변경</button>
										</td>
										<td><strong><fmt:formatNumber value="${dto.bookSalePrice * dto.itemAmount }" />원</strong></td>
										<td>
											<button type="button" class="btn btn-primary btn-xs" onclick="buy(${dto.itemNo })">주문하기</button><br />
											<a href="deleteItem.hta?cartno=${dto.itemNo }" class="btn btn-secondary btn-xs">삭제하기</a>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</tbody>
					</table>
				</form>
				</div>
				<div class="card-footer d-flex justify-content-between">
					<span>선택한 상품 <button class="btn btn-primary btn-xs" onclick="orderItems()">주문하기</button> <button class="btn btn-secondary btn-xs" onclick="deleteItems()">삭제하기</button></span>
					<span>상품 총 금액 : <strong class="mr-5"><fmt:formatNumber value="${totalOrderPrice }" /> 원</strong> 포인트 적립액 : <strong><fmt:formatNumber value="${totalSavePoint }" />원</strong></span>
				</div>	
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-12 mt-3">
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</div>
<script type="text/javascript">
	// 전체 선택/해제 체크박스의 상태가 바뀔때 마다 실행되는 함수
	function toggleAllChecked() {
		var isChecked = document.getElementById("chk-all").checked;
		var checkboxes = document.querySelectorAll("[name='cartno']");
		for (var i=0; i<checkboxes.length; i++) {
			checkboxes[i].checked = isChecked;
		}
	}
	
	// 변경하기 버튼을 클릭했을 실행되는 함수
	function changeAmount(cartItemNo) {
		var itemAmount = parseInt(document.getElementById("amount-" + cartItemNo).value);
		if (itemAmount < 1) {
			alert("수량은 1보다 작은 값을 가질 수 없습니다.");
			return;
		}
		
		location.href = "updateItem.hta?cartno=" + cartItemNo + "&amount=" + itemAmount;
	}

	// 주문하기 버튼을 클릭했을 때 실행되는 함수
	function buy(cartItemNo) {
		location.href = "../order/form.hta?cartno=" + cartItemNo;
	}
	
	// 선택한 상품 주문하기 버튼을 클릭했을 때 실행되는 함수
	function orderItems() {
		var form = document.getElementById("cart-form");
		form.setAttribute("action", "../order/form.hta");
		form.submit();
	}
	
	// 선택한 상품 삭제하기 버튼을 클릭했을 때 실행되는 함수
	function deleteItems() {
		var form = document.getElementById("cart-form");
		form.setAttribute("action", "deleteItem.hta");
		form.submit();
	}
	
</script>
</body>
</html>