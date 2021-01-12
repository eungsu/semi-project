<%@page import="kr.co.hta.shop.util.NumberUtils"%>
<%@page import="kr.co.hta.shop.dao.CartItemDao"%>
<%@page import="kr.co.hta.shop.dto.CartItemDto"%>
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
<!-- 로그인된 사용자의 사용자번호로 테이블에서 장바구니 아이템 정보를 조회한다. -->
<%
	List<CartItemDto> cartItemDtoList = CartItemDao.getInstance().getCartItemDtosByUserNo(loginedUserNo);

	int totalOrderPrice = 0;
	int totalSavePoint = 0;
%>
	<div class="row mb-3">
		<div class="col-12">
			<div class="card">
				<div class="card-header font-weight-bold">장바구니</div>
				<div class="card-body">
				<form id="cart-form" method="post" action="/shop-model1/order/form.jsp">
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
								<th><input type="checkbox" id="chk-all" checked /></th>
								<th>상품명</th>
								<th>정가</th>
								<th>판매가</th>
								<th>수량</th>
								<th>구매가격</th>
								<th>주문</th>
							</tr>
						</thead>
						<tbody>
						<%
							if (cartItemDtoList.isEmpty()) {
						%>
								<tr>
									<td colspan="7" class="text-center">장바구니가 비어 있습니다.</td>
								</tr>
						<%
							} else {
								for (CartItemDto dto : cartItemDtoList) {
									totalOrderPrice += dto.getBookSalePrice()*dto.getItemAmount();
									totalSavePoint += dto.getBookSavePoint()*dto.getItemAmount();
						%>
									<tr>
										<td><input type="checkbox" name="cartno" value="<%=dto.getItemNo() %>" checked onchange="updateTotal()"/></td>
										<td>
											<img src="/shop-model1/resources/images/<%=dto.getBookNo() %>.jpg" width="60px" height="88px" />
											<span class="align-top">
												<a href="/shop-model1/product/detail.jsp?bookno=<%=dto.getBookNo() %>&catno=<%=dto.getCategoryNo() %>" class="text-body"><%=dto.getBookTitle() %></a>
											</span>
										</td>
										<td><%=NumberUtils.numberToCurrency(dto.getBookPrice()) %>원</td>
										<td>
											<%=NumberUtils.numberToCurrency(dto.getBookSalePrice()) %>원<br/>
											<small>(<%=NumberUtils.numberToCurrency(dto.getBookSavePoint()) %>원 적립)</small>
										</td>
										<td>
											<input type="number" name="amount" id="amount-<%=dto.getItemNo() %>" value="<%=dto.getItemAmount() %>" style="width: 43px; height: 20px;"/><br/>
											<button type="button" class="btn btn-outline-secondary btn-xs" onclick="changeAmount()" >변경</button>
										</td>
										<td><strong><%=NumberUtils.numberToCurrency(dto.getBookSalePrice()*dto.getItemAmount()) %>원</strong></td>
										<td>
											<button type="button" class="btn btn-primary btn-xs" onclick="buy(<%=dto.getItemNo()%>)">주문하기</button><br />
											<a href="/shop-model1/cart/deleteItem.jsp?cartno=<%=dto.getItemNo() %>" class="btn btn-secondary btn-xs">삭제하기</a>
										</td>
									</tr>
						<%
								}
							}
						%>
						</tbody>
					</table>
				</form>
				</div>
				<div class="card-footer d-flex justify-content-between">
					<span>선택한 상품 <button class="btn btn-primary btn-xs">주문하기</button> <button class="btn btn-secondary btn-xs">삭제하기</button></span>
					<span>상품 총 금액 : <strong class="mr-5"><%=NumberUtils.numberToCurrency(totalOrderPrice) %>원</strong> 포인트 적립액 : <strong><%=NumberUtils.numberToCurrency(totalSavePoint) %>원</strong></span>
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
	function buy(cartItemNo) {
		location.href = "/shop-model1/order/form.jsp?cartno=" + cartItemNo;
	}
</script>
</body>
</html>