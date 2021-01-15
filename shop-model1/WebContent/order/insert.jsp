<%@page import="kr.co.hta.shop.dao.CartItemDao"%>
<%@page import="kr.co.hta.shop.dao.PointHistoryDao"%>
<%@page import="kr.co.hta.shop.vo.PointHistory"%>
<%@page import="kr.co.hta.shop.dao.UserDao"%>
<%@page import="kr.co.hta.shop.vo.User"%>
<%@page import="kr.co.hta.shop.vo.OrderItem"%>
<%@page import="kr.co.hta.shop.vo.Book"%>
<%@page import="kr.co.hta.shop.dao.BookDao"%>
<%@page import="kr.co.hta.shop.vo.Order"%>
<%@page import="kr.co.hta.shop.dao.OrderDao"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/loginCheck.jsp" %>
<%
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

	String[] bookNoArr = request.getParameterValues("bookno");
	String[] salePriceArr = request.getParameterValues("salePrice");
	String[] amountArr = request.getParameterValues("amount");
	
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String zipcode = request.getParameter("zipcode");
	String address = request.getParameter("address");
	String message = request.getParameter("message");
	int totalOrderPrice = StringUtils.stringToInt(request.getParameter("totalOrderPrice"));	// 총 구매금액
	int usedPoint = StringUtils.stringToInt(request.getParameter("usedPoint"));				// 사용포인트
	int totalPayPrice = StringUtils.stringToInt(request.getParameter("totalPayPrice"));		// 총 결재금액
	int totalSavedPoint = StringUtils.stringToInt(request.getParameter("totalSavedPoint"));	// 총 적립포인트
	
// 주문도서 중 첫번째 책정보로 주문이력정보 생성	
	int firstBookNo = StringUtils.stringToInt(bookNoArr[0]);
	Book firstBook = BookDao.getInstance().getBookByNo(firstBookNo);
	String description = null;
	if (bookNoArr.length > 1) {
		description = firstBook.getTitle() + " 외 " + (amountArr.length - 1) + "종";		
	} else {
		description = firstBook.getTitle();
	}

// 새 주문번호 조회
	int orderNo = OrderDao.getInstance().getOrderNo();
// 주문정보 객체에 저장
	Order order = new Order();
	order.setNo(orderNo);
	order.setUserNo(userNo);
	order.setDescription(description);
	order.setAmount(amountArr.length);
	order.setStatus("결재완료");
	order.setRecipientName(name);
	order.setRecipientTel(tel);
	order.setRecipientZipcode(zipcode);
	order.setRecipientAddress(address);
	order.setMessage(message);
	order.setTotalOrderPrice(totalOrderPrice);
	order.setUsedPointAmount(usedPoint);
	order.setTotalPaymentPrice(totalPayPrice);
	order.setTotalSavedPoint(totalSavedPoint);
// 주문정보를 데이터베이스에 저장한다.
	OrderDao.getInstance().insertOrder(order);
	
// 주문정보에 해당하는 주문도서정보로 주문도서정보를 생성하고 데이터베이스 저장한다.
	for (int index=0; index<bookNoArr.length; index++) {
		int bookNo = StringUtils.stringToInt(bookNoArr[index]);
		int salePrice = StringUtils.stringToInt(salePriceArr[index]);
		int amount = StringUtils.stringToInt(amountArr[index]);
// 주문 도서 정보 생성	
		OrderItem orderItem = new OrderItem();
		orderItem.setOrderNo(orderNo);
		orderItem.setBookNo(bookNo);
		orderItem.setPrice(salePrice);
		orderItem.setAmount(amount);
// 주문도서 정보를 데이터베이스에 저장한다.
		OrderDao.getInstance().insertOrderItem(orderItem);
 
// 책의 재고 변경 및 데이터베이스 반영		
		Book book = BookDao.getInstance().getBookByNo(bookNo);
		book.setStock(book.getStock() - amount);
		BookDao.getInstance().updateBook(book);
		
// 장바구니에서 해당 상품 삭제하기
		CartItemDao.getInstance().deleteCartItemByUserNoAndBookNo(userNo, bookNo);
	}

// 사용자 정보 조회
	User user = UserDao.getInstance().getUserByNo(userNo);
// 사용자의 사용가능 포인트 변경 및 데이터베이스 반영
	user.setAvailablePoint(user.getAvailablePoint() - usedPoint + totalSavedPoint);
	UserDao.getInstance().updateUser(user);
	
// 포인트 이력정보 저장하기
	PointHistory pointHistory = new PointHistory();
// 결재시 포인트를 사용한 경우 포인트 사용이력을 저장한다.
	if (usedPoint != 0) {
		pointHistory.setUserNo(userNo);
		pointHistory.setContent("주문시 포인트 사용");
		pointHistory.setOrderNo(orderNo);
		pointHistory.setPointAmount(-1*usedPoint);
		
		PointHistoryDao.getInstance().insertPointHistory(pointHistory);
	}
// 결재 후 적립된 포인트 이력 정보를 저장한다.
	pointHistory.setUserNo(userNo);
	pointHistory.setContent("주문으로 포인트 적립");
	pointHistory.setOrderNo(orderNo);
	pointHistory.setOrderNo(orderNo);
	pointHistory.setPointAmount(totalSavedPoint);
	
	PointHistoryDao.getInstance().insertPointHistory(pointHistory);

// 주문완료 페이지를 재요청하는 응답을 보낸다.
	response.sendRedirect("complete.jsp?orderno=" + orderNo);
%>