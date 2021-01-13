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
	int totalOrderPrice = StringUtils.stringToInt(request.getParameter("totalOrderPrice"));
	int usedPoint = StringUtils.stringToInt(request.getParameter("usedPoint"));
	int totalPayPrice = StringUtils.stringToInt(request.getParameter("totalPayPrice"));
	int totalSavedPoint = StringUtils.stringToInt(request.getParameter("totalSavedPoint"));

// 주문이력정보 생성	
	int firstBookNo = StringUtils.stringToInt(bookNoArr[0]);
	Book firstBook = BookDao.getInstance().getBookByNo(firstBookNo);
	String description = null;
	if (bookNoArr.length > 1) {
		description = firstBook.getTitle() + " 외 " + (amountArr.length - 1) + "종";		
	} else {
		description = firstBook.getTitle();
	}
	
	int orderNo = OrderDao.getInstance().getOrderNo();
	
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
// 주문정보 저장	
	OrderDao.getInstance().insertOrder(order);
	
	for (int index=0; index<bookNoArr.length; index++) {
		int bookNo = StringUtils.stringToInt(bookNoArr[index]);
		int salePrice = StringUtils.stringToInt(salePriceArr[index]);
		int amount = StringUtils.stringToInt(amountArr[index]);
		
		OrderItem orderItem = new OrderItem();
		orderItem.setOrderNo(orderNo);
		orderItem.setBookNo(bookNo);
		orderItem.setPrice(salePrice);
		orderItem.setAmount(amount);
// 주문아이템 정보 저장		
		OrderDao.getInstance().insertOrderItem(orderItem);

		Book book = BookDao.getInstance().getBookByNo(bookNo);
// 책의 재고 변경 및 데이터베이스 반영		
		book.setStock(book.getStock() - amount);
		BookDao.getInstance().updateBook(book);
	}

// 사용자 정보 조회
	User user = UserDao.getInstance().getUserByNo(userNo);
// 사용자의 사용가능 포인트 변경 및 데이터베이스 반영
	user.setAvailablePoint(user.getAvailablePoint() - usedPoint + totalSavedPoint);
	UserDao.getInstance().updateUser(user);
	
// 포인트 사용이력 저장
	PointHistory pointHistory = new PointHistory();
	if (usedPoint != 0) {
		pointHistory.setUserNo(userNo);
		pointHistory.setContent("주문시 포인트 사용");
		pointHistory.setOrderNo(orderNo);
		pointHistory.setPointAmount(usedPoint);
		
		PointHistoryDao.getInstance().insertPointHistory(pointHistory);
	}
	
	pointHistory.setUserNo(userNo);
	pointHistory.setContent("주문으로 포인트 적립");
	pointHistory.setOrderNo(orderNo);
	pointHistory.setOrderNo(orderNo);
	pointHistory.setPointAmount(totalSavedPoint);
	
	PointHistoryDao.getInstance().insertPointHistory(pointHistory);

	response.sendRedirect("complete.jsp?orderNo=" + orderNo);
%>