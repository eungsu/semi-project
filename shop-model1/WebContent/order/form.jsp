<%@page import="kr.co.hta.shop.dao.CartItemDao"%>
<%@page import="kr.co.hta.shop.vo.CartItem"%>
<%@page import="kr.co.hta.shop.dao.UserDao"%>
<%@page import="kr.co.hta.shop.vo.User"%>
<%@page import="kr.co.hta.shop.util.NumberUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.hta.shop.dao.BookDao"%>
<%@page import="kr.co.hta.shop.vo.Book"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
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
<%
	// 바로구매 혹은 장바구니에서 특정상품 하나 구매 혹은 장바구니에서 선택한 상품 구매를 했을 때
	// 해당 상품정보,구매수량,구매가격 정보를 포함하는 Map객체를 여러 개 담을 수 있는 List객체 생성하기
	List<Map<String, Object>> orderItemList = new ArrayList<>();
	User user = UserDao.getInstance().getUserByNo(loginedUserNo);

	int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
	int amount = StringUtils.stringToInt(request.getParameter("amount"));
	
	String[] cartItemNoArr = request.getParameterValues("cartno");
	
	if (bookNo != 0) {
		Book book = BookDao.getInstance().getBookByNo(bookNo);
		
		Map<String, Object> item = new HashMap<>();
		item.put("bookNo", bookNo);
		item.put("bookCategoryNo", book.getCategoryNo());
		item.put("bookTitle", book.getTitle());
		item.put("bookPrice", book.getPrice());
		item.put("bookSalePrice", book.getSalePrice());
		item.put("bookSavePoint", book.getSavePoint());
		item.put("amount", amount);
		item.put("orderPrice", book.getSalePrice()*amount);
		
		orderItemList.add(item);
	}
	
	if (cartItemNoArr != null) {
		for (String cartItemNoStr : cartItemNoArr) {
			int cartItemNo = StringUtils.stringToInt(cartItemNoStr);
			CartItem cartItem = CartItemDao.getInstance().getCartItemByNo(cartItemNo);
			Book book = BookDao.getInstance().getBookByNo(cartItem.getBookNo());
			
			Map<String, Object> item = new HashMap<>();
			item.put("bookNo", cartItem.getBookNo());
			item.put("bookCategoryNo", book.getCategoryNo());
			item.put("bookTitle", book.getTitle());
			item.put("bookPrice", book.getPrice());
			item.put("bookSalePrice", book.getSalePrice());
			item.put("bookSavePoint", book.getSavePoint());
			item.put("amount", cartItem.getItemAmount());
			item.put("orderPrice", book.getSalePrice()*cartItem.getItemAmount());
			
			orderItemList.add(item);
		}
	}
	
%>
	<form method="post" action="/shop-model1/order/insert.jsp">
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
							<%
								int totalOrderPrice = 0;
								int totalSavePoint = 0;
							
								for (Map<String, Object> item : orderItemList) {
									int itemBookNo = (Integer) item.get("bookNo");
									int itemCategoryNo = (Integer) item.get("bookCategoryNo");
									String itemBookTitle = (String) item.get("bookTitle");
									int itemBookPrice = (Integer) item.get("bookPrice");
									int itemBookSalePrice = (Integer) item.get("bookSalePrice");
									int itemBookSavePoint = (Integer) item.get("bookSavePoint");
									int itemAmount = (Integer) item.get("amount");
									int orderPrice = (Integer) item.get("orderPrice");
									
									totalOrderPrice += orderPrice;
									totalSavePoint += itemBookSavePoint*itemAmount;
							%>
								<tr>
									<td>
										<img src="/shop-model1/resources/images/<%=itemBookNo %>.jpg" width="60px" height="88px" />
										<span class="align-top"><a href="detail.jsp?bookno=<%=itemBookNo %>&catno=<%=itemCategoryNo %>" class="text-body"><%=itemBookTitle %></a></span>
										<input type="hidden" name="bookno" value="<%=itemBookNo %>" />
										<input type="hidden" name="amount" value="<%=itemAmount %>" />
									</td>
									<td><%=NumberUtils.numberToCurrency(itemBookPrice) %>원</td>
									<td>
										<%=NumberUtils.numberToCurrency(itemBookSalePrice) %>원<br/>
										<small>(<%=NumberUtils.numberToCurrency(itemBookSavePoint) %>원 적립)</small>
									</td>
									<td><%=itemAmount %></td>
									<td><strong><%=NumberUtils.numberToCurrency(orderPrice) %>원</strong></td>
								</tr>
							<%
								}
							%>
							</tbody>
						</table>
					</div>
					<div class="card-footer text-right">
						<span>상품 총 금액 : <strong class="mr-5"><%=NumberUtils.numberToCurrency(totalOrderPrice) %>원</strong> 포인트 적립액 : <strong><%=NumberUtils.numberToCurrency(totalSavePoint) %>원</strong></span>
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
      							<textarea rows="3" class="form-control" name="memo"></textarea>
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
								<label>사용가능 포인트 <button type="button" class="btn btn-primary btn-xs" id="btn-use-point" onclick="usePoint()">사용하기</button></label>
      							<input type="text" class="form-control" name="usablePoint" id="usable-point" value="<%=user.getAvailablePoint() %>" readonly>
							</div>
							<div class="form-group col-3">
								<label>총 구매금액</label>
      							<input type="text" class="form-control" name="totalOrderPrice" id="total-order-price" value="<%=totalOrderPrice %>" readonly>
							</div>
							<div class="form-group col-3">
								<label>포인트 사용액</label>
      							<input type="text" class="form-control" name="usedPoint" id="used-point" value="0" readonly>
							</div>
							<div class="form-group col-3">
								<label>총 결재금액</label>
      							<input type="text" class="form-control" name="totalPayPrice" id="total-pay-price" value="<%=totalOrderPrice %>" readonly>
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
