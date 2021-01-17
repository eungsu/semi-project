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
			<div class="alert alert-info text-center" style="font-size: 27px;">
				<span><strong>${user.name }</strong>님의 포인트 내역입니다..</span><br />
				<span class="mt-2 small">현재 포인트 적립액 : <fmt:formatNumber value="${user.availablePoint }" />원</span>
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
						<c:choose>
							<c:when test="${empty pointHistories }">
								<tr>
									<td class="text-center" colspan="4">포인트 변경이력이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="history" items="${pointHistories }">
									<tr>
										<td><fmt:formatDate value="${history.createdDate }" /></td>
										<td>${history.content }</td>
										<td class="text-center"><a href="detail.hta?orderno=${history.orderNo }">${history.orderNo }</a></td>
										<td class="text-right pr-5"><strong class="${history.pointAmount gt 0 ? 'text-success' : 'text-danger' }"><fmt:formatNumber value="${history.pointAmount }" /></strong> 원</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
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