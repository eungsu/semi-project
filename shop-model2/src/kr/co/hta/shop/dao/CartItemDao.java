package kr.co.hta.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.hta.shop.dto.CartItemDto;
import kr.co.hta.shop.util.ConnectionUtil;
import kr.co.hta.shop.vo.CartItem;

public class CartItemDao {
	
	private static CartItemDao cartItemDao = new CartItemDao();
	private CartItemDao() {}
	public static CartItemDao getInstance() {
		return cartItemDao;
	}

	private static final String INSERT_CART_ITEM_QUERY = "insert into SHOP2_BOOK_CART_ITEMS"
													   + "(cart_item_no, book_no, user_no, cart_item_amount)"
													   + "values"
													   + "(shop2_cart_seq.nextval, ?, ?, ?)";
	private static final String GET_CART_ITEM_BY_NO_QUERY = "select * "
														  + "from SHOP2_BOOK_CART_ITEMS "
														  + "where cart_item_no = ?";
	private static final String GET_CART_ITEM_BY_BOOKNO_USERNO_QUERY = "select * "
																	 + "from SHOP2_BOOK_CART_ITEMS "
																	 + "where book_no = ? "
																	 + "and user_no = ? ";
	private static final String GET_CART_ITEMS_BY_USER_NO_QUERY = "select A.cart_item_no, A.book_no, B.category_no, B.book_title, B.book_price, B.book_sale_price, B.book_save_point, B.book_discount_rate, A.cart_item_amount "
																+ "from SHOP2_BOOK_CART_ITEMS A, SHOP2_BOOKS B "
																+ "where user_no = ? "
																+ "and A.book_no = B.book_no";
	private static final String UPDATE_CART_ITEM_QUERY = "update SHOP2_BOOK_CART_ITEMS "
													   + " set "
													   + "	book_no = ?, "
													   + "	user_no = ?, "
													   + "	cart_item_amount = ? "
													   + "where cart_item_no = ?";
	private static final String DELETE_CART_ITEM_BY_NO_QUERY = "delete from SHOP2_BOOK_CART_ITEMS where cart_item_no = ?";
	private static final String DELETE_CART_ITEM_BY_USERNO_BOOKNO_QUERY = "delete from SHOP2_BOOK_CART_ITEMS where user_no = ? and book_no = ?";
	
	/**
	 * 장바구닌 아이템정보를 저장한다.
	 * @param cartItem
	 * @throws SQLException
	 */
	public void insertCartItem(CartItem cartItem) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(INSERT_CART_ITEM_QUERY);
		pstmt.setInt(1, cartItem.getBookNo());
		pstmt.setInt(2, cartItem.getUserNo());
		pstmt.setInt(3, cartItem.getItemAmount());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 장바구니 아이템 번호에 해당하는 아이템정보를 반환한다.
	 * @param cartItemNo 장바구니 아이템번호
	 * @return 장바구니 아이템
	 * @throws SQLException
	 */
	public CartItem getCartItemByNo(int cartItemNo) throws SQLException {
		CartItem cartItem = null;
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_CART_ITEM_BY_NO_QUERY);
		pstmt.setInt(1, cartItemNo);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			cartItem = new CartItem();
			cartItem.setItemNo(rs.getInt("cart_item_no"));
			cartItem.setBookNo(rs.getInt("book_no"));
			cartItem.setUserNo(rs.getInt("user_no"));
			cartItem.setItemAmount(rs.getInt("cart_item_amount"));
			cartItem.setCreatedDate(rs.getDate("cart_item_created_date"));
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return cartItem;
	}

	/**
	 * 장바구니에서 지정된 사용자번호와 책번호에 해당하는 장바구니 아이템정보를 조회해서 반환한다.
	 * @param bookNo 책번호
	 * @param userNo 사용자 번호
	 * @return 장바구니 아이템 번호, 조회조건에 만족하는 행이 존재하지 않는 경우 null이 반환됨
	 * @throws SQLException
	 */
	public CartItem getCartItemByBookNoAndUserNo(int bookNo, int userNo) throws SQLException {
		CartItem cartItem = null;
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_CART_ITEM_BY_BOOKNO_USERNO_QUERY);
		pstmt.setInt(1, bookNo);
		pstmt.setInt(2, userNo);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			cartItem = new CartItem();
			cartItem.setItemNo(rs.getInt("cart_item_no"));
			cartItem.setBookNo(rs.getInt("book_no"));
			cartItem.setUserNo(rs.getInt("user_no"));
			cartItem.setItemAmount(rs.getInt("cart_item_amount"));
			cartItem.setCreatedDate(rs.getDate("cart_item_created_date"));
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return cartItem;
	}
	
	/**
	 * 지정된 사용자번호로 등록된 장바구니 아이템 목록을 반환한다.
	 * @param userNo 사용자번호
	 * @return 장바구니 아이템 목록
	 * @throws SQLException
	 */
	public List<CartItemDto> getCartItemDtosByUserNo(int userNo) throws SQLException {
		List<CartItemDto> cartItemDtoList = new ArrayList<>();
		
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_CART_ITEMS_BY_USER_NO_QUERY);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			CartItemDto dto = new CartItemDto();
			dto.setItemNo(rs.getInt("cart_item_no"));
			dto.setBookNo(rs.getInt("book_no"));
			dto.setCategoryNo(rs.getInt("category_no"));
			dto.setBookTitle(rs.getString("book_title"));
			dto.setBookPrice(rs.getInt("book_price"));
			dto.setBookSalePrice(rs.getInt("book_sale_price"));
			dto.setBookSavePoint(rs.getInt("book_save_point"));
			dto.setBookDiscountRate(rs.getDouble("book_discount_rate"));
			dto.setItemAmount(rs.getInt("cart_item_amount"));
			
			cartItemDtoList.add(dto);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return cartItemDtoList;
	}
	
	/**
	 * 장바구니 아이템정보를 전달받아서 해당 장바구니 아이템정보를 변경한다.
	 * @param cartItem 변경사항이 반영된 장바구니 아이템 정보
	 * @throws SQLException
	 */
	public void updateCartItem(CartItem cartItem) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(UPDATE_CART_ITEM_QUERY);
		pstmt.setInt(1, cartItem.getBookNo());
		pstmt.setInt(2, cartItem.getUserNo());
		pstmt.setInt(3, cartItem.getItemAmount());
		pstmt.setInt(4, cartItem.getItemNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 장바구니 아이템정보 번호를 전달받아서 해당 장바구니 아이템정보를 삭제한다
	 * @param cartItemNo 장바구니 아이템 번호
	 * @param userNo 사용자번호
	 * @throws SQLException
	 */
	public void deleteCartItemByNo(int cartItemNo) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(DELETE_CART_ITEM_BY_NO_QUERY);
		pstmt.setInt(1, cartItemNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
		
	}
	
	/**
	 * 사용자번호와 책번호를 전달받아서 해당 장바구니 아이템정보를 삭제한다
	 * @param userNo 사용자번호
	 * @param bookNo 책번호
	 * @throws SQLException
	 */
	public void deleteCartItemByUserNoAndBookNo(int userNo, int bookNo) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(DELETE_CART_ITEM_BY_USERNO_BOOKNO_QUERY);
		pstmt.setInt(1, userNo);
		pstmt.setInt(2, bookNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
		
	}
}
