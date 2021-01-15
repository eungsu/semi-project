package kr.co.hta.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.hta.shop.util.ConnectionUtil;
import kr.co.hta.shop.vo.Order;
import kr.co.hta.shop.vo.OrderItem;

public class OrderDao {

	private static OrderDao orderDao = new OrderDao();
	private OrderDao() {}
	public static OrderDao getInstance() {
		return orderDao;
	}
	
	private static final String GET_ORDER_NO_QUERY = "select shop2_order_seq.nextval seq from dual";
	
	private static final String INSERT_ORDER_QUERY = "insert into shop2_book_orders"
												   + "(order_no, user_no, order_description, order_amount, order_status, order_recipient_name, order_recipient_tel, order_recipient_zipcode, order_recipient_address, order_message, total_order_price, used_point_amount, total_payment_price, total_saved_point)"
												   + "values"
												   + "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	private static final String INSERT_ORDER_ITEMS_QUERY = "insert into shop2_book_order_items"
														 + "(order_item_no, order_no, book_no, item_price, order_item_amount)"
														 + "values"
														 + "(shop2_order_item_seq.nextval, ?, ?, ?, ?)";
	private static final String GET_ORDER_BY_NO_QUERY = "select * "
													  + "from shop2_book_orders "
													  + "where order_no = ? ";
	
	private static final String GET_ORDER_ITEMS_BY_ORDER_NO_QUERY = "select A.order_item_no, A.order_no, A.book_no, B.category_no, B.book_title, B.book_price, B.book_save_point, A.item_price, A.order_item_amount "
																  + "from shop2_book_order_items A, shop2_books B "
																  + "where A.book_no = B.book_no "
																  + "and A.order_no = ? ";
	
	private static final String GET_ORDERS_BY_USER_NO_QUERY = "select * "
															+ "from shop2_book_orders "
															+ "where user_no = ? "
															+ "order by order_no desc";
	private static final String UPDATE_ORDER_QUERY = "update shop2_book_orders "
												   + "set "
												   + "	order_status = ?, "
												   + "	order_recipient_name = ?, "
												   + "	order_recipient_tel = ?, "
												   + "	order_recipient_zipcode = ?, "
												   + "	order_recipient_address = ?, "
												   + "	order_message = ? "
												   + "where order_no = ? ";
	
	/**
	 * 새로운 주문번호를 반환한다.
	 * @return 주문번호
	 * @throws SQLException
	 */
	public int getOrderNo() throws SQLException {
		int orderNo = 0;
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_ORDER_NO_QUERY);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		orderNo = rs.getInt("seq");
		rs.close();
		pstmt.close();
		con.close();
		
		return orderNo;
	}
	
	/**
	 * 주문정보를 저장한다.
	 * @param order 주문정보
	 * @throws SQLException
	 */
	public void insertOrder(Order order) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(INSERT_ORDER_QUERY);
		pstmt.setInt(1, order.getNo());
		pstmt.setInt(2, order.getUserNo());
		pstmt.setString(3, order.getDescription());
		pstmt.setInt(4, order.getAmount());
		pstmt.setString(5, order.getStatus());
		pstmt.setString(6, order.getRecipientName());
		pstmt.setString(7, order.getRecipientTel());
		pstmt.setString(8, order.getRecipientZipcode());
		pstmt.setString(9, order.getRecipientAddress());
		pstmt.setString(10, order.getMessage());
		pstmt.setInt(11, order.getTotalOrderPrice());
		pstmt.setInt(12, order.getUsedPointAmount());
		pstmt.setInt(13, order.getTotalPaymentPrice());
		pstmt.setInt(14, order.getTotalSavedPoint());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 주문상품정보를 저장한다.
	 * @param orderItem 주문상품
	 * @throws SQLException
	 */
	public void insertOrderItem(OrderItem orderItem) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(INSERT_ORDER_ITEMS_QUERY);
		pstmt.setInt(1, orderItem.getOrderNo());
		pstmt.setInt(2, orderItem.getBookNo());
		pstmt.setInt(3, orderItem.getPrice());
		pstmt.setInt(4, orderItem.getAmount());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
		
	}

	/**
	 * 주문번호에 해당하는 주문정보를 반환한다.
	 * @param orderNo 주문번호
	 * @return 주문정보
	 * @throws SQLException
	 */
	public Order getOrderByNo(int orderNo) throws SQLException {
		Order order = null;
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_ORDER_BY_NO_QUERY);
		pstmt.setInt(1, orderNo);;
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			order = new Order();
			order.setNo(rs.getInt("order_no"));
			order.setUserNo(rs.getInt("user_no"));
			order.setDescription(rs.getString("order_description"));
			order.setAmount(rs.getInt("order_amount"));
			order.setStatus(rs.getString("order_status"));
			order.setRecipientName(rs.getString("order_recipient_name"));
			order.setRecipientTel(rs.getString("order_recipient_tel"));
			order.setRecipientZipcode(rs.getString("order_recipient_zipcode"));
			order.setRecipientAddress(rs.getString("order_recipient_address"));
			order.setMessage(rs.getString("order_message"));
			order.setTotalOrderPrice(rs.getInt("total_order_price"));
			order.setUsedPointAmount(rs.getInt("used_point_amount"));
			order.setTotalPaymentPrice(rs.getInt("total_payment_price"));
			order.setTotalSavedPoint(rs.getInt("total_saved_point"));
			order.setCreatedDate(rs.getDate("order_created_date"));
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return order;
	}
	
	/**
	 * 주문번호에 해당하는 주문상품정보들을 반환한다.
	 * @param orderNo 주문번호
	 * @return 주문상품정보들
	 * @throws SQLException
	 */
	public List<Map<String, Object>> getOrderItemsByOrderNo(int orderNo) throws SQLException {
		List<Map<String, Object>> orderItems = new ArrayList<>();
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_ORDER_ITEMS_BY_ORDER_NO_QUERY);
		pstmt.setInt(1, orderNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Map<String, Object> orderItem = new HashMap<>();
			orderItem.put("itemNo", rs.getInt("order_item_no"));
			orderItem.put("orderNo", rs.getInt("order_no"));
			orderItem.put("bookNo", rs.getInt("book_no"));
			orderItem.put("categoryNo", rs.getInt("category_no"));
			orderItem.put("bookTitle", rs.getString("book_title"));
			orderItem.put("bookPrice", rs.getInt("book_price"));
			orderItem.put("bookSavePoint", rs.getInt("book_save_point"));
			orderItem.put("itemPrice", rs.getInt("item_price"));
			orderItem.put("itemAmount", rs.getInt("order_item_amount"));
			orderItem.put("orderPrice", rs.getInt("item_price") * rs.getInt("order_item_amount"));
			
			orderItems.add(orderItem);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return orderItems;
	}
	
	/**
	 * 지정된 사용자 번호로 주문내역을 조회해서 반환한다.
	 * @param userNo 사용자번호
	 * @return 주문내역
	 * @throws SQLException
	 */
	public List<Order> getOrdersByUserNo(int userNo) throws SQLException {
		List<Order> orders = new ArrayList<>();
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_ORDERS_BY_USER_NO_QUERY);
		pstmt.setInt(1, userNo);;
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			order.setUserNo(rs.getInt("user_no"));
			order.setDescription(rs.getString("order_description"));
			order.setAmount(rs.getInt("order_amount"));
			order.setStatus(rs.getString("order_status"));
			order.setRecipientName(rs.getString("order_recipient_name"));
			order.setRecipientTel(rs.getString("order_recipient_tel"));
			order.setRecipientZipcode(rs.getString("order_recipient_zipcode"));
			order.setRecipientAddress(rs.getString("order_recipient_address"));
			order.setMessage(rs.getString("order_message"));
			order.setTotalOrderPrice(rs.getInt("total_order_price"));
			order.setUsedPointAmount(rs.getInt("used_point_amount"));
			order.setTotalPaymentPrice(rs.getInt("total_payment_price"));
			order.setTotalSavedPoint(rs.getInt("total_saved_point"));
			order.setCreatedDate(rs.getDate("order_created_date"));
			
			orders.add(order);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return orders;
	}
	
	/**
	 * 주문정보를 변경한다.
	 * @param order 변경내용이 반영된 주문정보
	 * @throws SQLException
	 */
	public void updateOrder(Order order) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(UPDATE_ORDER_QUERY);
		pstmt.setString(1, order.getStatus());
		pstmt.setString(2, order.getRecipientName());
		pstmt.setString(3, order.getRecipientTel());
		pstmt.setString(4, order.getRecipientZipcode());
		pstmt.setString(5, order.getRecipientAddress());
		pstmt.setString(6, order.getMessage());
		pstmt.setInt(7, order.getNo());
		
		pstmt.execute();
		
		pstmt.close();
		con.close();
	}
	
}













