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

	<form method="post" action="insert.hta">
		<!-- 주문 상품 정보 시작 -->
		<div class="row mb-3">
			<div class="col-12">
				<div class="card">
					<div class="card-header font-weight-bold">주문상품 확인</div>
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
							<c:forEach var="item" items="${orderItemList }">
								<tr>
									<td>
										<img src="../resources/images/${item.bookNo }.jpg" width="60px" height="88px" />
										<span class="align-top"><a href="detail.hta?bookno=${item.bookNo}&catno=${item.bookCategoryNo }" class="text-body">${book.bookTitle }</a></span>
										<input type="hidden" name="bookno" value="${item.bookNo }" />
										<input type="hidden" name="salePrice" value="${item.bookSalePrice }" />
										<input type="hidden" name="amount" value="${item.amount }" />
									</td>
									<td><fmt:formatNumber value="${item.bookPrice }" />원</td>
									<td>
										<fmt:formatNumber value="${item.bookSalePrice }"/>원<br/>
										<small>(<fmt:formatNumber value="${item.bookSavePoint }"/>원 적립)</small>
									</td>
									<td>${item.amount }</td>
									<td><strong>${item.orderPrice }원</strong></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="card-footer text-right">
						<span>상품 총 금액 : <strong class="mr-5"><fmt:formatNumber value="${totalOrderPrice }"/>원</strong> 포인트 적립액 : <strong><fmt:formatNumber value="${totalSavePoint }"/>원</strong></span>
					</div>	
				</div>
			</div>
		</div>
		<!-- 주문 상품 정보 끝 -->
		
		<!-- 배송 정보 시작 -->
		<div class="row mb-3">
			<div class="col-12">
				<div class="card">
					<div class="card-header font-weight-bold">배송정보</div>
					<div class="card-body">
						<div class="form-row">
							<div class="form-group col-3">
								<label>받는사람 이름</label>
      							<input type="text" class="form-control" name="name">
							</div>
							<div class="form-group col-3">
								<label>받는사람 연락처</label>
      							<input type="text" class="form-control" name="tel">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-3">
								<label>우편번호</label>
      							<input type="text" class="form-control" name="zipcode">
							</div>
							<div class="form-group col-9">
								<label>주소</label>
      							<input type="text" class="form-control" name="address">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-12">
								<label>택배사 직원에게 남길 메세지 <small class="text-secondary">(예: 부재시 경비실에 맡겨주세요)</small></label>
      							<textarea rows="3" class="form-control" name="message"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 배송정보 끝 -->
			
		<!-- 결재정보 시작 -->
		<div class="row mt-3">
			<div class="col-12">
				<div class="card">
					<div class="card-header font-weight-bold">결재정보</div>
					<div class="card-body">
						<div class="form-row">
							<div class="form-group col-3">
								<label>사용가능 포인트 <button type="button" class="btn btn-primary btn-xs" id="btn-use-point" onclick="usePoint()" ${user.availablePoint eq 0 ? 'disabled' : '' }>사용하기</button></label>
      							<input type="text" class="form-control" name="usablePoint" id="usable-point" value="${user.availablePoint}" readonly>
							</div>
							<div class="form-group col-3">
								<label>총 구매금액</label>
      							<input type="text" class="form-control" name="totalOrderPrice" id="total-order-price" value="${totalOrderPrice }" readonly>
							</div>
							<div class="form-group col-3">
								<label>포인트 사용액</label>
      							<input type="text" class="form-control" name="usedPoint" id="used-point" value="0" readonly>
							</div>
							<div class="form-group col-3">
								<label>총 결재금액</label>
      							<input type="text" class="form-control" name="totalPayPrice" id="total-pay-price" value="${totalOrderPrice }" readonly>
      							<input type="hidden" name="totalSavedPoint" value="${totalSavePoint }" />
							</div>
						</div>
						<div class="text-right">
							<button type="submit" class="btn btn-primary btn-lg">결재하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 결재정보 끝  -->
	</form>
	
	<div class="row">
		<div class="col-12 mt-3">
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</div>
<script type="text/javascript">
	function usePoint() {
		var usablePointField = document.getElementById("usable-point");
		var totalOrderPriceField = document.getElementById("total-order-price");
		var usedPointField = document.getElementById("used-point");
		var totalPayPriceField = document.getElementById("total-pay-price");
		
		var usablePoint = parseInt(usablePointField.value);
		var totalOrderPrice = parseInt(totalOrderPriceField.value);
		var usedPoint = 0;
		var totalPayPrice = parseInt(totalPayPriceField.value);
		
		if (!usablePoint) {
			alert("사용가능한 포인트가 없습니다.");
			return;
		}
		if (usablePoint > totalOrderPrice) {
			usedPoint = usablePoint - totalOrderPrice;
			totalPayPrice = 0;
			usablePoint = usedPoint;
		} else {
			usedPoint = usablePoint;
			totalPayPrice = totalOrderPrice - usablePoint;
			usablePoint = 0;
		}
		
		usablePointField.value = usablePoint;
		usedPointField.value = usedPoint;
		totalPayPriceField.value = totalPayPrice;
		
		document.getElementById("btn-use-point").disabled = true;
	}
</script>
</body>
</html>