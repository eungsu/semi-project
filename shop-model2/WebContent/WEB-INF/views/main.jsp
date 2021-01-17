<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			<%@ include file="common/navbar.jsp" %>
		</div>
	</div>
	<!-- 새 상품 시작 -->
	<div class="row mb-3">
		<div class="col-12">
			<div class="card">
				<div class="card-header font-weight-bold">새 상품</div>
				<div class="card-body">
					<div class="row">
					<c:forEach var="book" items="${recentBooks }">
						<div class="col-3">
							<div class="card ">
	 							<div class="card-body">
		  							<a href="book/detail.hta?bookno=${book.no }&catno=${book.categoryNo}"><img class="img-thumbnail" src="resources/images/${book.no }.jpg" alt="Card image"></a>
	   								<strong class="book-title">${book.title }</strong>
	   								<div class="d-flex justify-content-between">
	   									<small class="text-secondary">${book.writer }</small>
	   									<small class="text-secondary">${book.publisher }</small>
	   								</div>
	   								<div class="d-flex justify-content-between">
	   									<small><strong class="text-danger">${book.salePrice }</strong> 원 (<fmt:formatNumber value="${book.discountRate *100 }" pattern="#,###"/> % 할인)</small> 
	   									<small>${book.savePoint }원 적립</small>
	   								</div>
	   								<div class="mt-3">
	   									<c:if test="${book.freeDelivery eq 'Y' }">
   											<span class="badge badge-primary">무료배송</span>
	   									</c:if>
	   									<span class="badge badge-success">새 상품</span>
	   								</div>
								</div>
							</div>		
						</div>
					</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 새 상품 끝 -->
	
	<!-- 추천 상품 시작 -->
	<div class="row mb-3">
		<div class="col-12">
			<div class="card">
				<div class="card-header font-weight-bold">추천상품</div>
				<div class="card-body">
					<div class="row">
					<c:forEach var="book" items="${bestsellerBooks }">
						<div class="col-3">
							<div class="card ">
	 							div class="card-body">
		  							<a href="book/detail.hta?bookno=${book.no }&catno=${book.categoryNo}"><img class="img-thumbnail" src="resources/images/${book.no }.jpg" alt="Card image"></a>
	   								<strong class="book-title">${book.title }</strong>
	   								<div class="d-flex justify-content-between">
	   									<small class="text-secondary">${book.writer }</small>
	   									<small class="text-secondary">${book.publisher }</small>
	   								</div>
	   								<div class="d-flex justify-content-between">
	   									<small><strong class="text-danger">${book.salePrice }</strong> 원 (<fmt:formatNumber value="${book.discountRate *100 }" pattern="#,###"/> % 할인)</small> 
	   									<small>${book.savePoint }원 적립</small>
	   								</div>
	   								<div class="mt-3">
	   									<c:if test="${book.freeDelivery eq 'Y' }">
   											<span class="badge badge-primary">무료배송</span>
	   									</c:if>
	   									<span class="badge badge-info">베스트 셀러</span>
	   								</div>
								</div>
						</div>
					</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12 mt-5">
			<%@ include file="common/footer.jsp" %>
		</div>
	</div>
</div>
</body>
</html>