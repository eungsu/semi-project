<%@ page import="kr.co.hta.shop.util.DateUtils" %>
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
		.book-title {
			display: block;
    		height: 52px;
    		overflow: hidden;
		}
		.img-thumbnail {
			width: 202.5px;
			height: 289px;
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
				<div class="card-header font-weight-bold">${category.name } 리스트</div>
				<div class="card-body">
					<div class="row">
					<c:forEach var="book" items="${books }">
						<div class="col-3 mb-3">
							<div class="card">
	 							<div class="card-body" style="height: 475.61px;" >
		  							<a href="detail.hta?bookno=${book.no }&pageno=${pageNo }&catno=${param.catno }">
		  								<img class="img-thumbnail" src="../resources/images/${book.no }.jpg" alt="Card image">
		  							</a>
	   								<strong class="mb-2 book-title">${book.title }</strong>
	   								<div class="d-flex justify-content-between">
	   									<small class="text-secondary">${book.writer }</small>
	   									<small class="text-secondary"><fmt:formatDate value="${book.pubDate }" /></small>
	   									<small class="text-secondary">${book.publisher }</small>
	   								</div>
	   								<div class="d-flex justify-content-between">
	   									<small><strong class="text-danger"><fmt:formatNumber value="${book.salePrice }" /></strong> 원 (<fmt:formatNumber value="${book.discountRate*100}" pattern="###"/>% 할인)</small> 
	   									<small><fmt:formatNumber value="${book.savePoint }"/>원 적립</small>
	   								</div>
	   								<div class="mt-3">
		   								<c:if test="${DateUtils.isWithinMonths(book.pubDate, 3) }">
		   									<span class="badge badge-success align-bottom">새 상품</span>
		   								</c:if>
		   								<c:if test="${book.freeDelivery eq 'Y' }">
		   										<span class="badge badge-primary">무료배송</span>
		   								</c:if>
										<c:if test="${book.bestseller eq 'Y' }">
		   									<span class="badge badge-info align-bottom">베스트셀러</span>
										</c:if>
	   								</div>
								</div>
							</div>		
						</div>
						</c:forEach>
					</div>

					<div class="row">
						<div class="col-12">
							<ul class="pagination justify-content-center">
						  		<li class="page-item ${pageNo gt 1 ? '' : 'disabled' }">
						  			<a class="page-link" href="list.hta?pageno=${pageNo - 1 }&catno=${param.catno }">이전</a>
						  		</li>
						  		<c:forEach var="num" begin="1" end="${totalPages }">
							  		<li class="page-item ${num eq pageNo ? 'active' : '' }">
							  			<a class="page-link" href="list.hta?pageno=${num }&catno=${param.catno }">${num }</a>
							  		</li>
						  		</c:forEach>
						  		<li class="page-item ${pageNo lt totalPages ? '' : 'disabled' }">
						  			<a class="page-link" href="list.hta?pageno=${pageNo + 1 }&catno=${param.catno }">다음</a>
						  		</li>
							</ul>
						</div>
					</div>
					
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