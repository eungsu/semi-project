<%@page import="kr.co.hta.shop.dao.BookDao"%>
<%@page import="kr.co.hta.shop.vo.Book"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.hta.shop.dao.PointHistoryDao"%>
<%@page import="kr.co.hta.shop.vo.PointHistory"%>
<%@page import="kr.co.hta.shop.dao.UserDao"%>
<%@page import="kr.co.hta.shop.vo.User"%>
<%@page import="kr.co.hta.shop.dao.OrderDao"%>
<%@page import="kr.co.hta.shop.vo.Order"%>
<%@page import="kr.co.hta.shop.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/loginCheck.jsp" %>
<%
// 요청파라미터에서 주문번호를 조회하고, 주문번호에 해당하는 주문정보를 조회한다.
	int orderNo = StringUtils.stringToInt(request.getParameter("orderno"));
	Order order = OrderDao.getInstance().getOrderByNo(orderNo);
// 세션에서 로그인한 사용자의 사용자번호를 조회한다.
	int loginedUserNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	
// 주문정보의 사용자번호와 로그인한 사용자의 사용자 번호가 다른 경우 주문취소를 할 수 없다.
	if (order.getUserNo() != loginedUserNo) {
		response.sendRedirect("detail.jsp?orderno=" + orderNo + "&error=fail");
		return;
	}
// 주문정보의 주문상태를 변경한다.	
	order.setStatus("주문취소");
	OrderDao.getInstance().updateOrder(order);
	
// 사용자의 포인트를 차감시킨다.
	User user = UserDao.getInstance().getUserByNo(loginedUserNo);
	user.setAvailablePoint(user.getAvailablePoint() - order.getTotalSavedPoint());
	UserDao.getInstance().updateUser(user);
	
// 사용자의 포인트 변경이력을 저장한다.
	PointHistory pointHistory = new PointHistory();
	pointHistory.setUserNo(loginedUserNo);
	pointHistory.setContent("주문취로 인한 포인트 회수");
	pointHistory.setOrderNo(orderNo);
	pointHistory.setPointAmount(order.getTotalSavedPoint());
	
	PointHistoryDao.getInstance().insertPointHistory(pointHistory);
	
// 주문한 도서의 재고를 변경한다.
	List<Map<String, Object>> items = OrderDao.getInstance().getOrderItemsByOrderNo(orderNo);
	for (Map<String, Object> item : items) {
		int bookNo = (Integer) item.get("bookNo");
		int itemAmount = (Integer) item.get("itemAmount");
		
		Book book = BookDao.getInstance().getBookByNo(bookNo);
		book.setStock(book.getStock() + itemAmount);
		BookDao.getInstance().updateBook(book);
	}
// 주문내역 페이지를 재요청하는 URL을 보낸다.
	response.sendRedirect("list.jsp");
%>