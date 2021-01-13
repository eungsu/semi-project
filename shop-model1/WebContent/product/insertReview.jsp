<%@page import="kr.co.hta.shop.dao.BookDao"%>
<%@page import="kr.co.hta.shop.vo.Book"%>
<%@page import="kr.co.hta.shop.dao.ReviewDao"%>
<%@page import="kr.co.hta.shop.vo.Review"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 리뷰쓰기는 로그인된 사용자가 가능함으로 로그인여부를 체크하는 jsp를 포함시킨다. -->
<%@ include file="../common/loginCheck.jsp" %>
<%
// 리뷰 쓰기에 필요한 요청 파라미터값을 조회한다.
// 책번호, 제목, 평점, 리뷰내용, 로그인한 사용자번호가 필요하다
	int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
	String title = request.getParameter("title");
	int bookPoint = StringUtils.stringToInt(request.getParameter("point"), 1);
	String content = request.getParameter("content");
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

// 페이지번호는 상세페이지로 되돌아갔을 때, 상세페이지에서 리스트로 되돌아갈 때 필요한 값이어서 요청파라미터로 전달받았다.
	int pageNo = StringUtils.stringToInt(request.getParameter("pageno"), 1);

// 리뷰객체를 생성해서 리뷰 정보를 담는다.
	Review review = new Review();
	review.setUserNo(userNo);
	review.setBookNo(bookNo);
	review.setTitle(title);
	review.setBookPoint(bookPoint);
	review.setContent(content);
	
// 리뷰객체에 저장된 리뷰정보를 데이터베이스에 저장시킨다.
	ReviewDao.getInstance().insertReview(review);
	
// 리뷰작성시 입력한 평점을 책에 반영시키기 위해서 책정보를 조회한다.
	Book book = BookDao.getInstance().getBookByNo(bookNo);
// 지금 작성한 리뷰의 평점을 반영시키서 그 책의 평점을 계산한다.
// 평점 = 정수로반올림[(책의평점*리뷰갯수*10 + 지금작성한리뷰의평점*10)/(리뷰갯수 + 1)]/10.0
	double reviewPoint = Math.round((book.getReviewPoint()*book.getReviewCount()*10 + bookPoint*10)/(book.getReviewCount() + 1))/10.0;
// 책정보에 계산된 새 평점과 리뷰 갯수를 1증가시킨다.
	book.setReviewPoint(reviewPoint);
	book.setReviewCount(book.getReviewCount() + 1);
// 책정보를 데이터베이스에 반영한다.
	BookDao.getInstance().updateBook(book);
	
	response.sendRedirect("detail.jsp?bookno=" + book.getNo() + "&catno=" + book.getCategoryNo() + "&pageno=" + pageNo);
%>