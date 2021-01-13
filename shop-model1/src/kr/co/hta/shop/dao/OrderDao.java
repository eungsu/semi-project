package kr.co.hta.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}













