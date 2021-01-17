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
	<main>
	<c:choose>
		<c:when test="${empty book }">
			<div class="alert alert-warning">
				<strong>오류</strong> 책정보를 찾을 수 없습니다.
			</div>
		</c:when>
		<c:otherwise>
			<div class="row mb-3">
				<div class="col-12 mb-3">
					<div class="card">
				  		<div class="row no-gutters">
				    		<div class="col-md-3">
				      			<img src="../resources/images/${book.no }.jpg" class="card-img" alt="...">
				    		</div>
				    		<div class="col-md-9">
				      			<div class="card-body">
				        			<h5 class="card-title">${book.title }</h5>
				        			<form id="book-form" method="get" action="../order/form.hta">
				        				<input type="hidden" name="bookno" value="${book.no }" />
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
					        						<td>${book.writer }</td>
					        						<th>역자</th>
					        						<td>${book.translator }</td>
					        					</tr>
					        					<tr>
					        						<th>출판사</th>
					        						<td>${book.publisher }</td>
					        						<th>출판일</th>
					        						<td><fmt:formatDate value="${book.pubDate }" pattern="yyyy년 M월 d일"/></td>
					        					</tr>
					        					<tr>
					        						<th>카테고리</th>
					        						<td>${category.name }</td>
					        						<th>재고현황</th>
					        						<td><fmt:formatNumber value="${book.stock }" /> 권</td>
					        						
					        					</tr>
					        					<tr>
					        						<th>정가</th>
					        						<td><small><fmt:formatNumber value="${book.price }" /> 원</small></td>
					        						<th>상태</th>
					        						<td>${book.status }</td>
					        					</tr>
					        					<tr>
					        						<th>판매가</th>
					        						<td><strong  class="text-danger"><fmt:formatNumber value="${book.salePrice }" /> 원</strong> <small>(<fmt:formatNumber value="${book.discountRate * 100 }" pattern="###" />%할인)</small></td>
					        						<th>포인트</th>
					        						<td><span class="text-danger">${book.savePoint }원</span> 적립</td>
					        					</tr>
					        					<tr>
					        						<th>평점</th>
					        						<td><strong class="text-danger"><fmt:formatNumber value="${book.reviewPoint }" pattern="#.0" /></strong> 점</td>
					        						<th>사용자 리뷰</th>
					        						<td><fmt:formatNumber value="${book.reviewCount }" /> 개</td>
					        					</tr>
					        					<tr>
					        						<th>구매수량</th>
					        						<td><input type="number" class="form-control" name="amount" value="1" style="width: 100px;"></td>
					        						<td colspan="2" class="text-right">
					        							<button type="button" class="btn btn-primary" onclick="buy()">바로구매</button>
					        							<button type="button" class="btn btn-info" onclick="addCartItem()">장바구니</button>
					        							<a href="list.hta?pageno=1" class="btn btn-outline-primary">쇼핑계속</a>
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
		</c:otherwise>
	</c:choose>

		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<h5>
							<c:if test="${not empty LOGINED_USER_NO }">
								<button class="btn btn-primary btn-sm float-right" data-toggle="modal" data-target="#modal-review-form">리뷰쓰기</button>
							</c:if>
							사용자 리뷰
						</h5>
					</div>
					<c:choose>
						<c:when test="${empty reviews }">
							<div class="card-body">
								<div class="card-text text-center">작성된 리뷰가 없습니다.</div>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="review" items="${reviews }">
								<div class="card-body border border-left-0 border-top-0 border-right-0">
									<h5 class="card-title  d-flex justify-content-between">
										<span>${review.title }</span>
										<small class="text-secondary">
											<span class="mr-3">평점: <span class="text-danger">${review.bookPoint }</span> </span> 
											<span class="mr-3">${review.userName }</span> <span class="mr-3"><fmt:formatDate value="${review.createdDate }"/></span>
										</small>
									</h5>
									<div class="card-text">${review.content }</div>
									<div class="mt-2 text-secondary text-right">
										<small>이 리뷰가 도움이 되셨나요? 
											<a href="likeReview.hta?bookno=${book.no }&cartno=${book.categoryNo }&pageno=${pageNo }&reviewno=${review.no }&reviewpageno=${reviewPageNo }" class="ml-3 btn btn-outline-secondary btn-xs ${review.reviewLiked eq 'Y' ? 'disabled' : '' }">
											<i class="fa ${review.reviewLiked eq 'Y' ? 'fa-heart text-danger' : 'fa-heart-o' }"></i> <fmt:formatNumber value="${review.likeCount }"/> </a>
										</small>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="card-body border border-left-0 border-top-0 border-right-0">
					<!-- 페이지 처리 시작 -->
					<div class="p-3">
						<ul class="pagination justify-content-center">
					  		<li class="page-item ${reviewPageNo eq 1 ? 'disabled' : '' }">
					  			<a class="page-link  " href="detail.hta?bookno=${book.no }&cartno=${book.categoryNo }&pageno=${pageNo }&reviewpageno=${reviewPageNo-1 }">이전</a>
					  		</li>
					  		<c:forEach var="num" begin="1" end="${totalPages }" >
						  		<li class="page-item ${reviewPageNo eq num ? 'active' : '' }"><a class="page-link" href="detail.jsp?bookno=${book.no }&cartno=${book.categoryNo}&pageno=${pageNo}&reviewpageno=${num }">${num }</a></li>
					  		</c:forEach>
					  		<li class="page-item ${reviewPage eq totalPages ? 'disabled' : '' }">
					  			<a class="page-link  " href="detail.hta?bookno=${book.no }&cartno=${book.categoryNo }&pageno=${pageNo }&reviewpageno=${reviewPageNo + 1}">다음</a>
					  		</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="modal-review-form" tabindex="-1" aria-hidden="true">
	  		<div class="modal-dialog">
	  			<form method="post" action="insertReview.hta" onsubmit="submitReview(event)">
	  			<input type="hidden" name="bookno" value="${book.no }" />
	  			<input type="hidden" name="pageno" value="${pageNo }" />
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
		form.setAttribute("action", "../order/form.hta")
		form.submit();
	}
	
	// 장바구니 추가 버튼 클릭시 실행되는 함수다.
	function addCartItem() {
		var form = document.getElementById("book-form");
		form.setAttribute("action", "../cart/insertItem.hta");
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