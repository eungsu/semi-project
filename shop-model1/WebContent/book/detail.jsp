<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.hta.shop.dao.ReviewDao"%>
<%@page import="kr.co.hta.shop.dto.ReviewDto"%>
<%@page import="kr.co.hta.shop.util.NumberUtils"%>
<%@page import="kr.co.hta.shop.util.DateUtils"%>
<%@page import="kr.co.hta.shop.dao.BookDao"%>
<%@page import="kr.co.hta.shop.vo.Book"%>
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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style type="text/css">
		.btn-group-xs > .btn, .btn-xs {
		  padding: .25rem .4rem;
		  font-size: .875rem;
		  line-height: .5;
		  border-radius: .2rem;
		}
	</style>
</head>
<body>
<div class="container">
	<header>
		<div class="row">
			<div class="col-12">
				<%@ include file="../common/navbar.jsp" %>
			</div>
		</div>
	</header>
<%
// 책의 상세정보 표시에 필요한 요청 파라미터 값을 조회한다.
// 페이지번호는 null인 경우 기본값을 1로 설정한다.
	int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
	int categoryNo = StringUtils.stringToInt(request.getParameter("catno"));
	int pageNo = StringUtils.stringToInt(request.getParameter("pageno"), 1);
	
// 책번호에 해당하는 책정보를 조회한다.
	Book book = BookDao.getInstance().getBookByNo(bookNo);
%>
	<main>
<!-- 책번호에 해당하는 책정보가 존재하지 않는 경우 아래 메세지를 표시한다. -->
<%
	if (book == null) {
%>
		<div class="alert alert-warning">
			<strong>오류</strong> 책정보를 찾을 수 없습니다.
		</div>
<!--  
	책번호에 해당하는 책정보가 존재하는 경우 해당 책의 카테고리 정보를 조회한다.
	책의 상세정보를 조회한다.
	가격등의 금액은 전부 금융통화방식으로 표시한다.
	날짜는 "2010년 10월 10일"같은 형식으로 표시한다.
	 
-->
<%
	} else {
		Category category = CategoryDao.getInstance().getCategoryByNo(book.getCategoryNo());
%>
<!-- 상품상세 정보 시작 -->
		<div class="row mb-3">
			<div class="col-12 mb-3">
				<div class="card">
			  		<div class="row no-gutters">
			    		<div class="col-md-3">
			      			<img src="../resources/images/<%=book.getNo() %>.jpg" class="card-img" alt="...">
			    		</div>
			    		<div class="col-md-9">
			      			<div class="card-body">
			        			<h5 class="card-title"><%=book.getTitle() %></h5>
			        			<form id="book-form" method="get" action="../order/form.jsp">
			        				<input type="hidden" name="bookno" value="<%=book.getNo() %>" />
				        			<table class="table">
				        				<colgroup>
				        					<col width="18%">
				        					<col width="32%">
				        					<col width="18%">
				        					<col width="32%">
				        				</colgroup>
				        				<tbody>
				        					<tr>
				        						<th>저자</th>
				        						<td><%=book.getWriter() %></td>
				        						<th>역자</th>
				        						<td><%=StringUtils.nullToBlank(book.getTranslator()) %></td>
				        					</tr>
				        					<tr>
				        						<th>출판사</th>
				        						<td><%=book.getPublisher() %></td>
				        						<th>출판일</th>
				        						<td><%=DateUtils.dateToLocalDateString(book.getPubDate()) %></td>
				        					</tr>
				        					<tr>
				        						<th>카테고리</th>
				        						<td><%=category.getName() %></td>
				        						<th>재고현황</th>
				        						<td><%=NumberUtils.numberWithComma(book.getStock()) %> 권</td>
				        						
				        					</tr>
				        					<tr>
				        						<th>정가</th>
				        						<td><small><%=NumberUtils.numberToCurrency(book.getPrice()) %> 원</small></td>
				        						<th>상태</th>
				        						<td><%=book.getStatus() %></td>
				        					</tr>
				        					<tr>
				        						<th>판매가</th>
				        						<td><strong  class="text-danger"><%=NumberUtils.numberToCurrency(book.getSalePrice()) %> 원</strong> <small>(<%=(int)(book.getDiscountRate()*100)%>%할인)</small></td>
				        						<th>포인트</th>
				        						<td><span class="text-danger"><%=NumberUtils.numberToCurrency(book.getSavePoint()) %>원</span> 적립</td>
				        					</tr>
				        					<tr>
				        						<th>평점</th>
				        						<td><strong class="text-danger"><%=NumberUtils.numberToOneDecimalPoint(book.getReviewPoint()) %></strong> 점</td>
				        						<th>사용자 리뷰</th>
				        						<td><%=NumberUtils.numberWithComma(book.getReviewCount()) %> 개</td>
				        					</tr>
				        					<tr>
				        						<th>구매수량</th>
				        						<td><input type="number" class="form-control" name="amount" value="1" style="width: 100px;"></td>
				        						<td colspan="2" class="text-right">
				        							<button type="button" class="btn btn-primary" onclick="buy()">바로구매</button>
				        							<button type="button" class="btn btn-info" onclick="addCartItem()">장바구니</button>
				        							<a href="list.jsp?pageno=1" class="btn btn-outline-primary">쇼핑계속</a>
				        						</td>
				        					</tr>
				        				</tbody>
				        			</table>
			        			</form>
			      			</div>
				  		</div>
					</div>
				</div>
			</div>
		</div>
<!-- 상품 상세정보 끝 -->		
<!-- 사용자 리뷰 시작 -->
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<h5>
							사용자 리뷰
						<%
							if (loginedUserNo != null) {
						%>
							<button class="btn btn-primary btn-sm float-right" data-toggle="modal" data-target="#modal-review-form">리뷰쓰기</button>
						<%
							}
						%>
						</h5>
					</div>
					<%
// 리뷰리스트를 담을 빈 List객체를 생성한다.
// (로그인한 경우와 로그인되지 않은 경우 리뷰를 조회하는 방식이 달라서 미리 리뷰리스트를 저장할 변수를 생성하고 시작함)
						List<ReviewDto> reviewDtoList = new ArrayList<>();
						final int ROWS_PER_PAGE = 5;
// 리뷰리스트 전용의 페이지번호를 조회한다.
// 조회범위를 계산한다.
						int reviewPageNo = StringUtils.stringToInt(request.getParameter("reviewpageno"), 1);
						int begin = (reviewPageNo - 1)*ROWS_PER_PAGE + 1;
						int end = reviewPageNo*ROWS_PER_PAGE;
						
// 해당 도서에 대한 리뷰 갯수를 조회하고, 총 페이지수를 계산한다.
						int totalCount = ReviewDao.getInstance().getReviewsCountByBookNo(bookNo);
						int totalPages = (int) (Math.ceil((double) totalCount/ROWS_PER_PAGE));

// 로그인되어있지 않은 경우에는 책번호와 조회범위를 이용해서 리뷰리스트를 조회한다.
						if (loginedUserNo == null) {
							reviewDtoList = ReviewDao.getInstance().getReviewDtosByRange(bookNo, begin, end);	
						} else {
// 로그인된 사용자의 경우 책번호, 사용자번호, 조회범위를 이용해서 리뷰리스트를 조회한다.
// 로그인된 사용자의 경우 리뷰 리스트 중에서 해당 사용자가 좋아요를 했는지 여부를 확인하기 위한 SQL 쿼리를 실행시킨다.
							reviewDtoList = ReviewDao.getInstance().getReviewDtosByRange(bookNo, loginedUserNo, begin, end);
						}
					%>
					<%
// 이 책에 대한 리뷰가 없는 경우 아래의 메세지를 표시하고, 리뷰가 없으므로 페이징처리도 하지 않는다.
						if (reviewDtoList.isEmpty()) {
					%>
						<div class="card-body">
							<div class="card-text text-center">작성된 리뷰가 없습니다.</div>
						</div>
					<%
// 이 책에 대한 리뷰가 존재하는 경우 리뷰를 표시하고, 페이징 처리도 수행한다.
						} else {
							for (ReviewDto dto : reviewDtoList) {
					%>
							<div class="card-body border border-left-0 border-top-0 border-right-0">
								<h5 class="card-title  d-flex justify-content-between">
									<span><%=dto.getTitle() %></span>
									<small class="text-secondary">
										<span class="mr-3">평점: <span class="text-danger"><%=dto.getBookPoint() %></span> </span> 
										<span class="mr-3"><%=dto.getUserName() %></span> <span class="mr-3"><%=dto.getCreatedDate() %></span>
									</small>
								</h5>
								<div class="card-text"><%=dto.getContent() %></div>
								<div class="mt-2 text-secondary text-right">
									<small>이 리뷰가 도움이 되셨나요? 
<!-- 
	이 리뷰에 대한 좋아요 갯수가 표시된다.
	로그인한 사용자가 이 리뷰에 대해 좋아요를 했으면 <a> 태그의 class 속성에 "disabled"가 추가되고, 버튼을 클릭할 수 없게된다.
	따라서, 해당 리뷰에 좋아요를 클릭하지 않은 경우에만 좋아요를 누를 수 있다.
	
	로그인한 사용자가 이 리뷰에 대해 좋아요를 했으면 <i class="fa fa-heart text-danger">좋아요갯수</i>로 출력되고,
	로그인한 사용자가 이 리뷰에 대해 좋아요를 하지 않았다면 <i class="fa fa-heart-ㅐ">좋아요갯수</i>로 출력된다.
	
	해당 리뷰에 좋아요를 추가하기 위해서는 책번호, 카테고리번호, 책리스트 페이지번호, 리뷰번호, 리뷰전용 페이지번호가 전달된다.
	좋아요를 추가하고 나면 다시 이 페이지로 되돌아와야하기 때문에 책번호가 필요하고,
	쇼핑계속하기를 눌러서 책 리스트 페이지로 되돌아가기 위해서 카테고리번호, 책리스트 페이지번호가 필요하다.
	어떤 리뷰에 좋아요를 눌렀는지 알려주기 위해서 리뷰번호가 필요하고, 좋아요를 추가한 다음에 해당 리뷰가 있는 리뷰 리스트로 되돌아오기 위해서 리뷰전용 페이지번호도 필요하다.
 -->
									<a href="likeReview.jsp?bookno=<%=book.getNo()%>&cartno=<%=book.getCategoryNo()%>&pageno=<%=pageNo %>&reviewno=<%=dto.getNo() %>&reviewpageno=<%=reviewPageNo%>" class="ml-3 btn btn-outline-secondary btn-xs <%="Y".equals(dto.getReviewLiked()) ? "disabled" : ""%>">
									<i class="fa <%="Y".equals(dto.getReviewLiked()) ? "fa-heart text-danger" : "fa-heart-o" %>"></i> <%=dto.getLikeCount() %></a>
									</small>
								</div>
							</div>
					<%	
							}
					%>
<!-- 
	리뷰리스트에 대한 페이징 처리는 리뷰가 존재하는 경우에만 표시된다.
	리뷰리스트의 페이지번호를 클릭하면 해당 페이지의 리뷰가 표시된다.
	리뷰리스트가 책의 상세페이지에서 표시되기 때문에 책번호, 카테고리번호, 책리스트 페이지번호, 리뷰전용 페이지번호가 요청파라미터로 전달된다.
 -->
								<!-- 페이지 처리 시작 -->
								<div class="p-3">
									<ul class="pagination justify-content-center">
								  		<li class="page-item <%=reviewPageNo == 1 ? "disabled" : ""%>">
								  			<a class="page-link  " href="detail.jsp?bookno=<%=book.getNo()%>&cartno=<%=book.getCategoryNo()%>&pageno=<%=pageNo %>&reviewpageno=<%=reviewPageNo - 1%>">이전</a>
								  		</li>
								  	<%
								  		for (int num=1; num<=totalPages; num++) {
								  	%>
								  		<li class="page-item <%=reviewPageNo == num ? "active" : ""%>"><a class="page-link" href="detail.jsp?bookno=<%=book.getNo()%>&cartno=<%=book.getCategoryNo()%>&pageno=<%=pageNo %>&reviewpageno=<%=num%>"><%=num %></a></li>
								  	<%
								  		}
								  	%>	
								  		<li class="page-item <%=reviewPageNo == totalPages ? "disabled" : ""%>">
								  			<a class="page-link  " href="detail.jsp?bookno=<%=book.getNo()%>&cartno=<%=book.getCategoryNo()%>&pageno=<%=pageNo %>&reviewpageno=<%=reviewPageNo + 1%>">다음</a>
								  		</li>
									</ul>
								</div>
								<!-- 페이지 처리 종료  -->
					<%
						}
					%>
					
				</div>
			</div>
		</div>
		
<!-- 리뷰 쓰기 폼 모달 시작 -->
<!-- 
	리뷰쓰기를 클릭하면 표시되는 모달창이다.
	책번호(숨김필드), 책리스트 페이지번호(숨김필드), 제목, 평점, 리뷰내용이 제출된다.
 -->
		<!-- Modal -->
		<div class="modal fade" id="modal-review-form" tabindex="-1" aria-hidden="true">
	  		<div class="modal-dialog">
	  			<form method="post" action="insertReview.jsp" onsubmit="submitReview(event)">
	  			<input type="hidden" name="bookno" value="<%=book.getNo() %>" />
	  			<input type="hidden" name="pageno" value="<%=pageNo %>" />
	    		<div class="modal-content">
	      			<div class="modal-header">
	        			<h5 class="modal-title">리뷰 작성하기</h5>
	        			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          				<span aria-hidden="true">&times;</span>
	        			</button>
	      			</div>
	      			<div class="modal-body">
	      				<div class="card">
	      					<div class="card-body">
			        			<div class="form-group">
			        				<label class="font-weight-bold">제목</label>
			        				<input type="text" class="form-control" name="title" id="review-title"/>
			        			</div>
			        			<div class="form-group">
			        				<label class="font-weight-bold">평점</label>
			        				<div class="form-check">
			        					<div class="form-check-inline">
											<label class="form-check-label">
										    	<input type="radio" class="form-check-input" name="point" value="1">1점
										  	</label>
										</div>
			        					<div class="form-check-inline">
											<label class="form-check-label">
										    	<input type="radio" class="form-check-input" name="point" value="2">2점
										  	</label>
										</div>
			        					<div class="form-check-inline">
											<label class="form-check-label">
										    	<input type="radio" class="form-check-input" name="point" value="3">3점
										  	</label>
										</div>
			        					<div class="form-check-inline">
											<label class="form-check-label">
										    	<input type="radio" class="form-check-input" name="point" value="4">4점
										  	</label>
										</div>
			        					<div class="form-check-inline">
											<label class="form-check-label">
										    	<input type="radio" class="form-check-input" name="point" value="5" checked>5점
										  	</label>
										</div>
			        				</div>
			        			</div>
			        			<div class="form-group">
			        				<label class="font-weight-bold">내용</label>
			        				<textarea rows="5" class="form-control" name="content" id="review-content"></textarea>
			        			</div>
	      					</div>
	      				</div>
	      			</div>
	      			<div class="modal-footer">
	        			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        			<button type="submit" class="btn btn-primary">등록</button>
	      			</div>
	    		</div>
	    		</form>
	  		</div>
		</div>
		<!-- 리뷰 쓰기 폼 모달 끝 -->
<%
	}
%>
	</main>
	
	<div class="row">
		<div class="col-12 mt-3">
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</div>
<script type="text/javascript">
	// 바로구매 버튼 클릭시 실행되는 함수다.
	function buy() {
		var form = document.getElementById("book-form");
		form.setAttribute("action", "../order/form.jsp")
		form.submit();
	}
	
	// 장바구니 추가 버튼 클릭시 실행되는 함수다.
	function addCartItem() {
		var form = document.getElementById("book-form");
		form.setAttribute("action", "../cart/insertItem.jsp");
		form.submit();
	}

	// 리뷰입력폼에서 등록버튼 클릭시 실행되는 함수다.
	function submitReview(event) {
		var titleElement = document.querySelector("#review-title");
		var contentElement = document.querySelector("#review-content");
		
		if (!titleElement.value) {
			event.preventDefault();
			alert("제목을 입력하세요");
			return;
		}
		
		if (!contentElement.value) {
			event.preventDefault();
			alert("내용을 입력하세요");
			return;
		}
	}
</script>
</body>
</html>