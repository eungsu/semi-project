<%@page import="kr.co.hta.shop.util.DateUtils"%>
<%@page import="kr.co.hta.shop.util.NumberUtils"%>
<%@page import="kr.co.hta.shop.vo.Book"%>
<%@page import="kr.co.hta.shop.dao.BookDao"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
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
<%
// 특정 카테고리에 속하는 책의 목록을 표시하다.

// 한 페이지에 표시할 책 갯수, 기본 페이지 번호, 기본 카테고리 번호를 상수로 정의한다.
	final int ROWS_PER_PAGE = 8;
	final int DEFAULT_PAGE_NO = 1;
	final int DEFAULT_CATEGORY_NO = 100;
	
// 카테고리번호와 페이지번호를 요청파라미터에서 조회한다.
	int categoryNo = StringUtils.stringToInt(request.getParameter("catno"), DEFAULT_CATEGORY_NO);
	int pageNo = StringUtils.stringToInt(request.getParameter("pageno"), DEFAULT_PAGE_NO);
	
// 해당 카테고리에 속하는 책의 갯수를 조회하고, 해당 카테고리에 대한 책정보를 표시하는데 필요한 총 페이지갯수도 게산한다.
	int totalCount = BookDao.getInstance().getBooksCountByCategory(categoryNo);
	int totalPages = (int) (Math.ceil((double) totalCount/ROWS_PER_PAGE));
// 페이지번호가 0이하이거나 총페이지를 초과한 경우에 페이지번호를 1로 설정한다.
	if (pageNo <= 0 || pageNo > totalPages) {
		pageNo = DEFAULT_PAGE_NO;
	}
// 페이지번호에 해당하는 조회범위를 조회한다.
	int begin = (pageNo - 1)*ROWS_PER_PAGE + 1;
	int end = pageNo*ROWS_PER_PAGE;
// 조회범위에 해당하는 책목록을 조회한다.
// 특정 카테고리에 해당하는 책목록을 표시하기 때문에 목록을 조회할 때 카테고리번호와 조회범위를 전달한다.
	List<Book> books = BookDao.getInstance().getBooksByCategory(categoryNo, begin, end);
// 목록을 표시할 때 어떤 카테고리의 책인지를 표시하기 위해서 카테고리번호로 카테고리정보를 조회한다.
	Category category = CategoryDao.getInstance().getCategoryByNo(categoryNo);
%>
	
	<div class="row mb-3">
		<div class="col-12">
			<div class="card">
				<div class="card-header font-weight-bold"><%=category.getName() %> 리스트</div>
				<div class="card-body">
<!-- 책 리스트 시작 -->
					<div class="row">
					<%
						for (Book book : books) {
					%>
						<div class="col-3 mb-3">
							<div class="card">
	 							<div class="card-body" style="height: 475.61px;" >
		  							<a href="detail.jsp?bookno=<%=book.getNo() %>&pageno=<%=pageNo%>&catno=<%=categoryNo%>">
		  								<img class="img-thumbnail" src="../resources/images/<%=book.getNo() %>.jpg" alt="Card image">
		  							</a>
	   								<strong class="mb-2 book-title"><%=book.getTitle() %></strong>
	   								<div class="d-flex justify-content-between">
	   									<small class="text-secondary"><%=book.getWriter() %></small>
	   									<small class="text-secondary"><%=book.getPubDate() %></small>
	   									<small class="text-secondary"><%=book.getPublisher() %></small>
	   								</div>
	   								<div class="d-flex justify-content-between">
	   									<small><strong class="text-danger"><%=NumberUtils.numberToCurrency(book.getSalePrice()) %></strong> 원 (<%=(int)(book.getDiscountRate()*100)%>% 할인)</small> 
	   									<small><%=NumberUtils.numberToCurrency(book.getSavePoint()) %>원 적립</small>
	   								</div>
<!-- 새 상품, 무료배송, 베스트셀러 정보 표시 시작 -->
	   								<div class="mt-3">
	   								<%
	   									if (DateUtils.isWithinOneMonth(book.getPubDate())) {
	   								%>
	   									<span class="badge badge-success align-bottom">새 상품</span>
	   								<%
	   									}
	   									if ("Y".equals(book.getFreeDelivery())) {
									%>
	   										<span class="badge badge-primary">무료배송</span>
	   								<%	
	   									}
	   									if ("Y".equals(book.getBestseller())) {
	   								%>
	   									<span class="badge badge-info align-bottom">베스트셀러</span>
	   								<%
	   									}
	   								%>
	   								</div>
<!-- 새 상품, 무료배송, 베스트셀러 정보 표시 끝 -->
								</div>
							</div>		
						</div>
					<%
						}
					%>
					</div>
<!-- 책 리스트 끝 -->

<!-- 페이징 처리 시작-->
					<div class="row">
						<div class="col-12">
							<ul class="pagination justify-content-center">
						  		<li class="page-item <%=pageNo > 1 ? "" : "disabled"%>">
						  			<a class="page-link" href="list.jsp?pageno=<%=pageNo - 1 %>&catno=<%=categoryNo %>">이전</a>
						  		</li>
						  	<%
						  		for (int num=1; num<=totalPages; num++) {
						  	%>
						  		<li class="page-item <%=num == pageNo ? "active" : "" %>">
						  			<a class="page-link" href="list.jsp?pageno=<%=num %>&catno=<%=categoryNo %>"><%=num %></a>
						  		</li>
						  	<%
						  		}
						  	%>
						  		<li class="page-item <%=pageNo < totalPages ? "" : "disabled" %>">
						  			<a class="page-link" href="list.jsp?pageno=<%=pageNo + 1 %>&catno=<%=categoryNo %>">다음</a>
						  		</li>
							</ul>
						</div>
					</div>
<!-- 페이징 처리 끝 -->
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