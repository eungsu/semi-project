<%@page import="kr.co.hta.shop.vo.Review"%>
<%@page import="kr.co.hta.shop.dao.ReviewDao"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 리뷰쓰기는 로그인된 사용자가 가능함으로 로그인여부를 체크하는 jsp를 포함시킨다. -->
<%@ include file="../common/loginCheck.jsp" %>
<%
// 리뷰에 대해서 좋아요를 클릭한 정보를 추가하기 위해서 요청파라미터에서 리뷰번호를 읽어오고, 세션에서 사용자번호를 조회한다.
 	int reviewNo = StringUtils.stringToInt(request.getParameter("reviewno"));
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

// 리뷰 좋아요 테이블에 리뷰번호와 그 리뷰에 대해 좋아요를 클릭한 사용자번호를 저장한다.
	ReviewDao.getInstance().insertReviewLikeUser(reviewNo, userNo);
	
// 해당 리뷰에 대한 좋아요 갯수를 증가시키기 위해 리뷰정보를 조회한다.
	Review review = ReviewDao.getInstance().getReviewByNo(reviewNo);
// 해당 리뷰에 대한 좋아요 갯수를 1증가시키고, 데이터베이스에 반영시킨다.
	review.setLikeCount(review.getLikeCount() + 1);
	ReviewDao.getInstance().updateReview(review);

// 책에 대한 상세페이지로 되돌아가기 위해서 필요한 요청파라미터 값을 조회한다.
	int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
 	int categoryNo = StringUtils.stringToInt(request.getParameter("cartno"));
 	int pageNo = StringUtils.stringToInt(request.getParameter("pageno"), 1);
// 책에 대한 리뷰리스트의 특정 페이지로 되돌아가기 위해서 리뷰전용 페이지번호도 조회한다.
 	int reviewPageNo = StringUtils.stringToInt(request.getParameter("reviewpageno")); 	
 	
	response.sendRedirect("detail.jsp?bookno="+bookNo+"&cartno="+categoryNo+"&pageno="+pageNo+"&reviewno="+reviewNo+"&reviewpageno="+reviewPageNo);
	
%>