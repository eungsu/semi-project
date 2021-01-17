package kr.co.hta.shop.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hta.shop.dao.BookDao;
import kr.co.hta.shop.dao.CartItemDao;
import kr.co.hta.shop.dao.OrderDao;
import kr.co.hta.shop.dao.PointHistoryDao;
import kr.co.hta.shop.dao.UserDao;
import kr.co.hta.shop.util.StringUtils;
import kr.co.hta.shop.vo.Book;
import kr.co.hta.shop.vo.CartItem;
import kr.co.hta.shop.vo.Order;
import kr.co.hta.shop.vo.OrderItem;
import kr.co.hta.shop.vo.PointHistory;
import kr.co.hta.shop.vo.User;
import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class OrderController {

	private BookDao bookDao = BookDao.getInstance();
	private CartItemDao cartItemDao = CartItemDao.getInstance();
	private OrderDao orderDao = OrderDao.getInstance();
	private PointHistoryDao pointHistoryDao = PointHistoryDao.getInstance();
	private UserDao userDao = UserDao.getInstance();

	@RequestMapping("/order/form.hta")
	public ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		List<Map<String, Object>> orderItemList = new ArrayList<>();

		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}
		User user = userDao.getUserByNo(userNo);

		int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
		int amount = StringUtils.stringToInt(request.getParameter("amount"));

		String[] cartItemNoArr = request.getParameterValues("cartno");

		if (bookNo != 0) {
			Book book = bookDao.getBookByNo(bookNo);

			Map<String, Object> item = new HashMap<>();
			item.put("bookNo", bookNo);
			item.put("bookCategoryNo", book.getCategoryNo());
			item.put("bookTitle", book.getTitle());
			item.put("bookPrice", book.getPrice());
			item.put("bookSalePrice", book.getSalePrice());
			item.put("bookSavePoint", book.getSavePoint());
			item.put("amount", amount);
			item.put("orderPrice", book.getSalePrice()*amount);

			orderItemList.add(item);
		}

		if (cartItemNoArr != null) {
			for (String cartItemNoStr : cartItemNoArr) {
				int cartItemNo = StringUtils.stringToInt(cartItemNoStr);
				CartItem cartItem = cartItemDao.getCartItemByNo(cartItemNo);
				Book book = bookDao.getBookByNo(cartItem.getBookNo());

				Map<String, Object> item = new HashMap<>();
				item.put("bookNo", cartItem.getBookNo());
				item.put("bookCategoryNo", book.getCategoryNo());
				item.put("bookTitle", book.getTitle());
				item.put("bookPrice", book.getPrice());
				item.put("bookSalePrice", book.getSalePrice());
				item.put("bookSavePoint", book.getSavePoint());
				item.put("amount", cartItem.getItemAmount());
				item.put("orderPrice", book.getSalePrice()*cartItem.getItemAmount());

				orderItemList.add(item);
			}
		}

		int totalOrderPrice = orderItemList.stream().mapToInt(item -> ((Integer) item.get("bookSalePrice")) * ((Integer) item.get("amount"))).sum();
		int totalSavePoint = orderItemList.stream().mapToInt(item -> ((Integer) item.get("bookSavePoint")) * ((Integer) item.get("amount"))).sum();

		mav.addAttribute("user", user);
		mav.addAttribute("orderItemList", orderItemList);
		mav.addAttribute("totalOrderPrice", totalOrderPrice);
		mav.addAttribute("totalSavePoint", totalSavePoint);

		mav.setViewName("order/form.jsp");

		return mav;
	}

	@RequestMapping("/order/insert.hta")
	public ModelAndView insertOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

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
		Book firstBook = bookDao.getBookByNo(firstBookNo);
		String description = null;
		if (bookNoArr.length > 1) {
			description = firstBook.getTitle() + " 외 " + (amountArr.length - 1) + "종";		
		} else {
			description = firstBook.getTitle();
		}

		// 새 주문번호 조회
		int orderNo = orderDao.getOrderNo();
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
		orderDao.insertOrder(order);

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
			orderDao.insertOrderItem(orderItem);

			// 책의 재고 변경 및 데이터베이스 반영		
			Book book = bookDao.getBookByNo(bookNo);
			book.setStock(book.getStock() - amount);
			bookDao.updateBook(book);

			// 장바구니에서 해당 상품 삭제하기
			cartItemDao.deleteCartItemByUserNoAndBookNo(userNo, bookNo);
		}

		// 사용자 정보 조회
		User user = userDao.getUserByNo(userNo);
		// 사용자의 사용가능 포인트 변경 및 데이터베이스 반영
		user.setAvailablePoint(user.getAvailablePoint() - usedPoint + totalSavedPoint);
		userDao.updateUser(user);

		// 포인트 이력정보 저장하기
		PointHistory pointHistory = new PointHistory();
		// 결재시 포인트를 사용한 경우 포인트 사용이력을 저장한다.
		if (usedPoint != 0) {
			pointHistory.setUserNo(userNo);
			pointHistory.setContent("주문시 포인트 사용");
			pointHistory.setOrderNo(orderNo);
			pointHistory.setPointAmount(-1*usedPoint);

			pointHistoryDao.insertPointHistory(pointHistory);
		}
		// 결재 후 적립된 포인트 이력 정보를 저장한다.
		pointHistory.setUserNo(userNo);
		pointHistory.setContent("주문으로 포인트 적립");
		pointHistory.setOrderNo(orderNo);
		pointHistory.setOrderNo(orderNo);
		pointHistory.setPointAmount(totalSavedPoint);

		pointHistoryDao.insertPointHistory(pointHistory);

		// 주문완료 페이지를 재요청하는 응답을 보낸다.
		mav.setViewName("redirect:complete.hta?orderno=" + orderNo);

		return mav;
	}

	@RequestMapping("/order/complete.hta")
	public ModelAndView complete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		int orderNo = StringUtils.stringToInt(request.getParameter("orderno"));
		mav.addAttribute("order", orderDao.getOrderByNo(orderNo));
		mav.addAttribute("orderItems", orderDao.getOrderItemsByOrderNo(orderNo));

		mav.setViewName("order/complete.jsp");

		return mav;
	}

	@RequestMapping("/order/list.hta")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

		mav.addAttribute("orders", orderDao.getOrdersByUserNo(userNo));
		mav.setViewName("/order/list.jsp");

		return mav;
	}

	@RequestMapping("/order/detail.hta")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		int orderNo = StringUtils.stringToInt(request.getParameter("orderno"));
		mav.addAttribute("order", orderDao.getOrderByNo(orderNo));
		mav.addAttribute("orderItems", orderDao.getOrderItemsByOrderNo(orderNo));

		mav.setViewName("order/detail.jsp");

		return mav;
	}

	@RequestMapping("/order/cancel.hta")
	public ModelAndView cancelOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		// 요청파라미터에서 주문번호를 조회하고, 주문번호에 해당하는 주문정보를 조회한다.
		int orderNo = StringUtils.stringToInt(request.getParameter("orderno"));
		Order order = orderDao.getOrderByNo(orderNo);
		// 세션에서 로그인한 사용자의 사용자번호를 조회한다.
		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

		// 주문정보의 사용자번호와 로그인한 사용자의 사용자 번호가 다른 경우 주문취소를 할 수 없다.
		if (order.getUserNo() != userNo) {
			mav.setViewName("redirect:detail.hta?orderno=" + orderNo + "&error=fail");
			return mav;
		}
		// 주문정보의 주문상태를 변경한다.	
		order.setStatus("주문취소");
		orderDao.updateOrder(order);

		// 사용자의 포인트를 차감시킨다.
		User user = userDao.getUserByNo(userNo);
		user.setAvailablePoint(user.getAvailablePoint() - order.getTotalSavedPoint());
		userDao.updateUser(user);

		// 사용자의 포인트 변경이력을 저장한다.
		PointHistory pointHistory = new PointHistory();
		pointHistory.setUserNo(userNo);
		pointHistory.setContent("주문취로 인한 포인트 회수");
		pointHistory.setOrderNo(orderNo);
		pointHistory.setPointAmount(-1*order.getTotalSavedPoint());

		pointHistoryDao.insertPointHistory(pointHistory);

		// 주문한 도서의 재고를 변경한다.
		List<Map<String, Object>> items = orderDao.getOrderItemsByOrderNo(orderNo);
		for (Map<String, Object> item : items) {
			int bookNo = (Integer) item.get("bookNo");
			int itemAmount = (Integer) item.get("itemAmount");

			Book book = bookDao.getBookByNo(bookNo);
			book.setStock(book.getStock() + itemAmount);
			bookDao.updateBook(book);
		}
		// 주문내역 페이지를 재요청하는 URL을 보낸다.
		mav.setViewName("redirect:list.hta");

		return mav;
	}


}
