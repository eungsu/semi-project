<%@page import="kr.co.hta.shop.util.NumberUtils"%>
<%@page import="kr.co.hta.shop.dao.OrderDao"%>
<%@page import="kr.co.hta.shop.vo.Order"%>
<%@page import="kr.co.hta.shop.vo.User"%>
<%@page import="kr.co.hta.shop.dao.UserDao"%>
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
  	<div class="row mb-3">
  		<div class="col-12">
			<div class="alert alert-info text-center" style="font-size: 27px;">
				<span><strong>홍길동</strong>님 즐겁고 행복한 하루 보내세요</span><br />
			</div>
		</div>
  	</div>
 <%
 	User user = UserDao.getInstance().getUserByNo(loginedUserNo);
 %>
 	<div class="row mb-3">
 		<div class="col-12">
 			<div class="card">
 				<div class="card-body">
 					<h4 class="card-title">나의 정보</h4>
 					<table class="table">
 						<tbody>
 							<tr>
 								<th>이름</th>
 								<td><%=user.getName() %></td>
 								<th>적립 포인트</th>
 								<td><span class="mr-5"><strong class="text-danger"><%=NumberUtils.numberToCurrency(user.getAvailablePoint()) %></strong> 원</span> <a href="pointhistory.jsp" class="btn btn-primary btn-xs">상세내용</a></td>
 							</tr>
 							<tr>
 								<th>아이디</th>
 								<td><%=user.getId() %></td>
 								<th>비밀번호</th>
 								<td><button class="btn btn-outline-primary btn-xs" data-toggle="modal" data-target="#modal-password-form">비밀번호 변경</button></td>
 							</tr>
 							<tr>
 								<th>연락처</th>
 								<td><%=user.getTel() %></td>
 								<th>이메일</th>
 								<td><%=user.getEmail() %></td>
 							</tr>
 						</tbody>
 					</table>
 					<%
 // 로그인한 사용자의 사용자번호로 주문내역정보를 조회한다.
 					List<Order> orders = OrderDao.getInstance().getOrdersByUserNo(loginedUserNo);
 					%>
 					<h4 class="card-title">최근 주문내역</h4>
 					<table class="table">
						<thead>
							<tr>
								<th>주문번호</th>
								<th>주문일자</th>
								<th>주문내역</th>
								<th>주문금액/수량</th>
								<th>주문상태</th>
								<th>수령자</th>
							</tr>
						</thead>
						<tbody>
						<%
							if (orders.isEmpty()) {
						%>
								<tr>
									<td class="text-center" colspan="6">주문내역이 존재하지 않습니다.</td>
								</tr>
						<%
							} else {
								for (Order order : orders) {
						%>
									<tr>
										<td><a href="detail.jsp?orderno=<%=order.getNo()%>"><%=order.getNo() %></a></td>
										<td><%=order.getCreatedDate() %></td>
										<td><a href="detail.jsp?orderno=<%=order.getNo()%>"><%=order.getDescription() %></a></td>
										<td><%=NumberUtils.numberToCurrency(order.getTotalOrderPrice()) %>원/<%=order.getAmount() %></td>
										<td><span class="text-success"><%=order.getStatus() %></span></td>
										<td><%=order.getRecipientName() %></td>
									</tr>
						<%										
								}
							}
						%>
						</tbody>
					</table>
 				</div>
 			</div>
 		</div>
 	</div>
 	
 	<!-- 비밀번호 변경 폼 모달 시작 -->
	<!-- Modal -->
	<div class="modal fade" id="modal-password-form" tabindex="-1" aria-hidden="true">
  		<div class="modal-dialog">
  			<form method="post" action="changepassword.jsp">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title">비밀번호 변경하기</h5>
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          				<span aria-hidden="true">&times;</span>
        			</button>
      			</div>
      			<div class="modal-body">
      				<div class="card">
      					<div class="card-body">
		        			<div class="form-group">
		        				<label class="font-weight-bold">이전 비밀번호</label>
		        				<input type="password" class="form-control" name="prevPassword" />
		        			</div>
		        			<div class="form-group">
		        				<label class="font-weight-bold">새 비밀번호</label>
		        				<input type="password" class="form-control" name="password" />
		        			</div>
		        			<div class="form-group">
		        				<label class="font-weight-bold">새 비밀번호 확인</label>
		        				<input type="password" class="form-control" name="confirmPassword" />
		        			</div>
      					</div>
      				</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        			<button type="submit" class="btn btn-primary">변경하기</button>
      			</div>
    		</div>
    		</form>
  		</div>
	</div>
	<!-- 비밀번호 변경 폼 모달 끝 -->
 	
  	<div class="row">
		<div class="col-12 mt-3">
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</div>
</body>
</html>