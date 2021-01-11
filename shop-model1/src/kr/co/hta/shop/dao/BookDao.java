package kr.co.hta.shop.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.hta.shop.util.ConnectionUtil;
import kr.co.hta.shop.vo.Book;

public class BookDao {

	private static final String GET_NEW_BOOKS_QUERY = " select * "
													+ "	from (select * "
													+ "       from shop2_books "
													+ "		  where book_pub_date > sysdate - 90 "
													+ "		  and category_no = 100	"
													+ "       order by book_pub_date desc)"
													+ " where rownum <= 4";
	private static final String GET_BESTSELLER_BOOKS_QUERY = " select * "
															+ " from (select * "
															+ "       from shop2_books "
															+ "       where book_bestseller = 'Y'"
															+ "		  and category_no = 100	"
															+ "		  order by book_no) "
															+ " where rownum <= 4";
	private static final String GET_BOOK_BY_NO_QUERY = "select * from shop2_books where book_no = ?";
	private static final String GET_BOOKSCOUNT_BY_CATEGORY_QUERY = "select count(*) books_count from shop2_books where category_no = ?";
	private static final String GET_BOOKS_BY_CATEGORY_QUERY = "select * "
															+ "from (select row_number() over (order by A.book_no desc) rn, A.* "
															+ "      from shop2_books A"
															+ "		 where A.category_no = ?)"
															+ "where rn >= ? and rn <= ?";
	private static final String UPDATE_BOOK_QUERY = "update shop2_books "
												  + "set "
												  + " book_title = ?, "
												  + " book_writer = ?, "
												  + " book_translator = ?, "
												  + " book_publisher = ?, "
												  + " book_pub_date = ?, "
												  + " book_stock = ?, "
												  + " book_status = ?, "
												  + " book_price = ?, "
												  + " book_sale_price = ?, "
												  + " book_discount_rate = ?, "
												  + " book_save_point = ?, "
												  + " book_review_point = ?, "
												  + " book_review_count = ?, "
												  + " book_bestseller = ?, "
												  + " book_free_delivery = ? "
												  + "where book_no = ?";
	
	private static BookDao bookDao = new BookDao();
	private BookDao() {}
	public static BookDao getInstance() {
		return bookDao;
	}
	
	public List<Book> getNewBooks() throws SQLException {
		List<Book> books = new ArrayList<>();
		
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_NEW_BOOKS_QUERY);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Book book = new Book();
			book.setNo(rs.getInt("book_no"));
			book.setCategoryNo(rs.getInt("category_no"));
			book.setTitle(rs.getString("book_title"));
			book.setWriter(rs.getString("book_writer"));
			book.setTranslator(rs.getString("book_translator"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setPubDate(rs.getDate("book_pub_date"));
			book.setStock(rs.getInt("book_stock"));
			book.setStatus(rs.getString("book_status"));
			book.setPrice(rs.getInt("book_price"));
			book.setSalePrice(rs.getInt("book_sale_price"));
			book.setDiscountRate(rs.getDouble("book_discount_rate"));
			book.setSavePoint(rs.getInt("book_save_point"));
			book.setReviewPoint(rs.getDouble("book_review_point"));
			book.setReviewCount(rs.getInt("book_review_count"));
			book.setBestseller(rs.getString("book_bestseller"));
			book.setFreeDelivery(rs.getString("book_free_delivery"));
			book.setCreatedDate(rs.getDate("book_created_date"));
			
			books.add(book);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return books;
	}
	
	public List<Book> getBestsellerBooks() throws SQLException {
		List<Book> books = new ArrayList<>();
		
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_BESTSELLER_BOOKS_QUERY);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Book book = new Book();
			book.setNo(rs.getInt("book_no"));
			book.setCategoryNo(rs.getInt("category_no"));
			book.setTitle(rs.getString("book_title"));
			book.setWriter(rs.getString("book_writer"));
			book.setTranslator(rs.getString("book_translator"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setPubDate(rs.getDate("book_pub_date"));
			book.setStock(rs.getInt("book_stock"));
			book.setStatus(rs.getString("book_status"));
			book.setPrice(rs.getInt("book_price"));
			book.setSalePrice(rs.getInt("book_sale_price"));
			book.setDiscountRate(rs.getDouble("book_discount_rate"));
			book.setSavePoint(rs.getInt("book_save_point"));
			book.setReviewPoint(rs.getDouble("book_review_point"));
			book.setReviewCount(rs.getInt("book_review_count"));
			book.setBestseller(rs.getString("book_bestseller"));
			book.setFreeDelivery(rs.getString("book_free_delivery"));
			book.setCreatedDate(rs.getDate("book_created_date"));
			
			books.add(book);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return books;
	}
	
	public Book getBookByNo(int bookNo) throws SQLException {
		Book book = null;
		
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_BOOK_BY_NO_QUERY);
		pstmt.setInt(1, bookNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			book = new Book();
			book.setNo(rs.getInt("book_no"));
			book.setCategoryNo(rs.getInt("category_no"));
			book.setTitle(rs.getString("book_title"));
			book.setWriter(rs.getString("book_writer"));
			book.setTranslator(rs.getString("book_translator"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setPubDate(rs.getDate("book_pub_date"));
			book.setStock(rs.getInt("book_stock"));
			book.setStatus(rs.getString("book_status"));
			book.setPrice(rs.getInt("book_price"));
			book.setSalePrice(rs.getInt("book_sale_price"));
			book.setDiscountRate(rs.getDouble("book_discount_rate"));
			book.setSavePoint(rs.getInt("book_save_point"));
			book.setReviewPoint(rs.getDouble("book_review_point"));
			book.setReviewCount(rs.getInt("book_review_count"));
			book.setBestseller(rs.getString("book_bestseller"));
			book.setFreeDelivery(rs.getString("book_free_delivery"));
			book.setCreatedDate(rs.getDate("book_created_date"));
			
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return book;
	}
	
	public int getBooksCountByCategory(int categoryNo) throws SQLException {
		int booksCount = 0;
		
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_BOOKSCOUNT_BY_CATEGORY_QUERY);
		pstmt.setInt(1, categoryNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		booksCount = rs.getInt("books_count");
		rs.close();
		pstmt.close();
		con.close();
		
		return booksCount;
	}
	
	public List<Book> getBooksByCategory(int categoryNo, int begin, int end) throws SQLException {
		List<Book> books = new ArrayList<>();
		
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_BOOKS_BY_CATEGORY_QUERY);
		pstmt.setInt(1, categoryNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Book book = new Book();
			book.setNo(rs.getInt("book_no"));
			book.setCategoryNo(rs.getInt("category_no"));
			book.setTitle(rs.getString("book_title"));
			book.setWriter(rs.getString("book_writer"));
			book.setTranslator(rs.getString("book_translator"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setPubDate(rs.getDate("book_pub_date"));
			book.setStock(rs.getInt("book_stock"));
			book.setStatus(rs.getString("book_status"));
			book.setPrice(rs.getInt("book_price"));
			book.setSalePrice(rs.getInt("book_sale_price"));
			book.setDiscountRate(rs.getDouble("book_discount_rate"));
			book.setSavePoint(rs.getInt("book_save_point"));
			book.setReviewPoint(rs.getDouble("book_review_point"));
			book.setReviewCount(rs.getInt("book_review_count"));
			book.setBestseller(rs.getString("book_bestseller"));
			book.setFreeDelivery(rs.getString("book_free_delivery"));
			book.setCreatedDate(rs.getDate("book_created_date"));
			
			books.add(book);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return books;
	}
	
	public void updateBook(Book book) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(UPDATE_BOOK_QUERY);
		pstmt.setString(1, book.getTitle());
		pstmt.setString(2, book.getWriter());
		pstmt.setString(3, book.getTranslator());
		pstmt.setString(4, book.getPublisher());
		pstmt.setDate(5, new Date(book.getPubDate().getTime()));
		pstmt.setInt(6, book.getStock());
		pstmt.setString(7, book.getStatus());
		pstmt.setInt(8, book.getPrice());
		pstmt.setInt(9, book.getSalePrice());
		pstmt.setDouble(10, book.getDiscountRate());
		pstmt.setInt(11, book.getSavePoint());
		pstmt.setDouble(12, book.getReviewPoint());
		pstmt.setInt(13, book.getReviewCount());
		pstmt.setString(14, book.getBestseller());
		pstmt.setString(15, book.getFreeDelivery());
		pstmt.setInt(16, book.getNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
		
	}
}
