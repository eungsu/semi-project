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
	
	<form method="post" action="insert.jsp">
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
								<tr>
									<td>
										<img src="../resources/images/book.jpg" width="60px" height="88px" />
										<span class="align-top"><a href="detail.jsp" class="text-body">불안한 마음을 잠재우는 방법</a></span>
										<input type="hidden" name="price" value="<%=23000 %>" />
										<input type="hidden" name="amount" value="<%=1 %>" />
										<input type="hidden" name="bookno" value="<%=100 %>" />
									</td>
									<td>10,000원</td>
									<td>
										9,000원<br/>
										<small>(500원 적립)</small>
									</td>
									<td>1</td>
									<td><strong>9,000원</strong></td>
								</tr>
								<tr>
									<td>
										<img src="../resources/images/book.jpg" width="60px" height="88px" />
										<span class="align-top"><a href="detail.jsp" class="text-body">불안한 마음을 잠재우는 방법</a></span>
										<input type="hidden" name="wineno" value="<%=179 %>" />
										<input type="hidden" name="price" value="<%=45000 %>" />
										<input type="hidden" name="amount" value="<%=3 %>" />
									</td>
									<td>10,000원</td>
									<td>
										9,000원<br/>
										<small>(500원 적립)</small>
									</td>
									<td>1</td>
									<td><strong>9,000원</strong></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="card-footer text-right">
						<span>상품 총 금액 : <strong class="mr-5">18,000원</strong> 포인트 적립액 : <strong>1,000원</strong></span>
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
								<label>사용가능 포인트 <button type="button" class="btn btn-primary btn-xs" id="btn-use-point">사용하기</button></label>
      							<input type="text" class="form-control" name="usablePoint" value="5800" readonly>
							</div>
							<div class="form-group col-3">
								<label>총 구매금액</label>
      							<input type="text" class="form-control" name="totalPrice" value="18000" readonly>
							</div>
							<div class="form-group col-3">
								<label>포인트 사용액</label>
      							<input type="text" class="form-control" name="usedPoint" value="0" readonly>
							</div>
							<div class="form-group col-3">
								<label>총 결재금액</label>
      							<input type="text" class="form-control" name="orderPrice" value="18000" readonly>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-6">
								<label>은행 및 카드사</label>
      							<select name="bank" class="form-control">
                                	<option value="" selected disabled>카드사 및 은행 선택</option>
                                    <option value="카카오뱅크" > 카카오뱅크</option>
                                    <option value="롯데카드" > 롯데카드</option>
                                    <option value="신한카드" > 신한카드</option>
                                    <option value="국민카드" > 국민카드</option>
                                    <option value="삼성카드" > 삼성카드</option>
                                    <option value="씨티카드" > 씨티카드</option>
                                    <option value="BC카드" > BC카드/우리카드</option>
                                    <option value="국민은행" > 국민은행</option>
                                    <option value="신한은행" > 신한은행</option>
                                    <option value="하나은행" > 하나은행</option>
                                    <option value="기업은행" > 기업은행</option>
                                    <option value="농협" > 농협</option>
                                    <option value="수협" > 수협</option>
                                    <option value="새마을금고" > 새마을금고</option>
                            	</select>
							</div>
							<div class="form-group col-6">
								<label>카드번호 및 계좌번호</label>
      							<input type="text" class="form-control" name="account">
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
</body>
</html>