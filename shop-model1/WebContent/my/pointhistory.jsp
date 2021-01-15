<%@page import="kr.co.hta.shop.util.NumberUtils"%>
<%@page import="kr.co.hta.shop.dao.PointHistoryDao"%>
<%@page import="kr.co.hta.shop.vo.PointHistory"%>
<%@page import="kr.co.hta.shop.dao.UserDao"%>
<%@page import="kr.co.hta.shop.vo.User"%>
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
	User user = UserDao.getInstance().getUserByNo(loginedUserNo);
	List<PointHistory> pointHistories = PointHistoryDao.getInstance().getPointHistoriesByUserNo(loginedUserNo);
%>
  	<div class="row mb-3">
  		<div class="col-12">
			<div class="alert alert-info text-center" style="font-size: 27px;">
				<span><strong><%=user.getName() %></strong>님의 포인트 내역입니다..</span><br />
				<span class="mt-2 small">현재 포인트 적립액 : <%=NumberUtils.numberToCurrency(user.getAvailablePoint()) %>원</span>
			</div>
		</div>
  	</div>
 
 	<div class="row mb-3">
 		<div class="col-12">
 			<div class="card">
 				<div class="card-body">
 					<h4 class="card-title">포인트 내역</h4>
 					<table class="table">
						<colgroup>
							<col width="15%">
							<col width="*">
							<col width="15%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th>일자</th>
								<th>내용</th>
								<th class="text-center">주문번호</th>
								<th class="text-right pr-5">포인트</th>
							</tr>
						</thead>
						<tbody>
						<%
							if (pointHistories.isEmpty()) {
						%>
							<tr>
								<td class="text-center" colspan="4">포인트 변경이력이 없습니다.</td>
							</tr>
						<%
							} else {
								for (PointHistory history : pointHistories) {
						%>
									<tr>
										<td><%=history.getCreatedDate() %></td>
										<td><%=history.getContent() %></td>
										<td class="text-center"><a href="detail.jsp?orderno=<%=history.getOrderNo()%>"><%=history.getOrderNo()%></a></td>
										<td class="text-right pr-5"><strong class="<%=history.getPointAmount() > 0 ? "text-success" : "text-danger"%>"><%=NumberUtils.numberToCurrency(history.getPointAmount()) %></strong> 원</td>
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
 	
  	<div class="row">
		<div class="col-12 mt-3">
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</div>
</body>
</html>