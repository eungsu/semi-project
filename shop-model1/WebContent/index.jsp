<%@page import="kr.co.hta.shop.util.NumberUtils"%>
<%@page import="kr.co.hta.shop.dao.BookDao"%>
<%@page import="kr.co.hta.shop.vo.Book"%>
<%@page import="java.util.List"%>
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
			<%@ include file="common/navbar.jsp" %>
		</div>
	</div>
	
	<%
		List<Book> newBookList = BookDao.getInstance().getNewBooks();
		List<Book> bestsellerBookList = BookDao.getInstance().getBestsellerBooks();
	%>
	<!-- 새 상품 시작 -->
	<div class="row mb-3">
		<div class="col-12">
			<div class="card">
				<div class="card-header font-weight-bold">새 상품</div>
				<div class="card-body">
					<div class="row">
					<%
						for (Book book : newBookList) {
					%>
						<div class="col-3">
							<div class="card ">
	 							<div class="card-body">
		  							<a href="product/detail.jsp?bookno=<%=book.getNo()%>&catno=<%=book.getCategoryNo()%>"><img class="img-thumbnail" src="resources/images/<%=book.getNo() %>.jpg" alt="Card image"></a>
	   								<strong class="book-title"><%=book.getTitle() %></strong>
	   								<div class="d-flex justify-content-between">
	   									<small class="text-secondary"><%=book.getWriter() %></small>
	   									<small class="text-secondary"><%=book.getPublisher() %></small>
	   								</div>
	   								<div class="d-flex justify-content-between">
	   									<small><strong class="text-danger"><%=NumberUtils.numberToCurrency(book.getSalePrice()) %></strong> 원 (<%=(int)(book.getDiscountRate()*100)%>% 할인)</small> 
	   									<small><%=NumberUtils.numberToCurrency(book.getSavePoint()) %>원 적립</small>
	   								</div>
	   								<div class="mt-3">
	   								<%
	   									if ("Y".equals(book.getFreeDelivery())) {
									%>
	   										<span class="badge badge-primary">무료배송</span>
	   								<%	
	   									}
	   								%>
	   									<span class="badge badge-success">새 상품</span>
	   								</div>
								</div>
							</div>		
						</div>
					<%
						}
					%>
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
					<%
						for (Book book : bestsellerBookList) {
					%>
						<div class="col-3">
							<div class="card ">
	 							<div class="card-body">
		  							<a href="product/detail.jsp?bookno=<%=book.getNo()%>&catno=<%=book.getCategoryNo()%>"><img class="img-thumbnail" src="resources/images/<%=book.getNo() %>.jpg" alt="Card image"></a>
	   								<strong class="book-title"><%=book.getTitle() %></strong>
	   								<div class="d-flex justify-content-between">
	   									<small class="text-secondary"><%=book.getWriter() %></small>
	   									<small class="text-secondary"><%=book.getPublisher() %></small>
	   								</div>
	   								<div class="d-flex justify-content-between">
	   									<small><strong class="text-danger"><%=NumberUtils.numberToCurrency(book.getSalePrice()) %></strong> 원 (<%=(int)(book.getDiscountRate()*100)%>% 할인)</small> 
	   									<small><%=NumberUtils.numberToCurrency(book.getSavePoint()) %>원 적립</small>
	   								</div>
	   								<div class="mt-3">
	   								<%
	   									if ("Y".equals(book.getFreeDelivery())) {
									%>
	   										<span class="badge badge-primary">무료배송</span>
	   								<%	
	   									}
	   								%>
	   									<span class="badge badge-info">베스트셀러</span>
	   								</div>
								</div>
							</div>		
						</div>
					<%
						}
					%>
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