package kr.co.hta.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.hta.shop.util.ConnectionUtil;
import kr.co.hta.shop.vo.Category;

public class CategoryDao {

	private static final String GET_ALL_CATEGORIES_QUERY = "select * from shop2_book_categories";
	private static final String GET_CATEGORY_BY_NO_QUERY = "select * from shop2_book_categories where category_no = ?";
	
	private static CategoryDao categoryDao = new CategoryDao();
	private CategoryDao() {}
	public static CategoryDao getInstance() {
		return categoryDao;
	}
	
	public List<Category> getAllCategories() throws SQLException {
		List<Category> categories = new ArrayList<>();
		
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_ALL_CATEGORIES_QUERY);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Category category = new Category();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			
			categories.add(category);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return categories;
	}
	
	public Category getCategoryByNo(int categoryNo) throws SQLException {
		Category category = null;
		
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_CATEGORY_BY_NO_QUERY);
		pstmt.setInt(1, categoryNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			category = new Category();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return category;
	}
	
	
}
