package kr.co.hta.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.hta.shop.util.ConnectionUtil;
import kr.co.hta.shop.vo.User;

public class UserDao {

	private static final String GET_USER_BY_ID_QUERY = "SELECT * FROM SHOP2_USERS WHERE USER_ID = ?";
	private static final String GET_USER_BY_NO_QUERY = "SELECT * FROM SHOP2_USERS WHERE USER_NO = ?";
	private static final String INSERT_USER_QUERY = "INSERT INTO SHOP2_USERS (USER_NO, USER_NAME, USER_ID, USER_PASSWORD, USER_TEL, USER_EMAIL) VALUES (SHOP_USER_SEQ.NEXTVAL, ?,?,?,?,?)";
	private static final String UPDATE_USER_QUERY = "UPDATE SHOP2_USERS SET USER_PASSWORD = ?, USER_TEL = ?, USER_EMAIL = ?, USER_AVAILABLE_POINT = ?, USER_STATUS = ? WHERE USER_NO = ?";
	
	private static UserDao userDao = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return userDao;
	}
	
	/**
	 * 지정된 사용자아이디로 사용자정보를 조회해서 반환한다.
	 * @param userId 사용자 아이디
	 * @return 사용자정보, 사용자아이디가 올바르지 않는 경우 null이 반환된다.
	 * @throws SQLException
	 */
	public User getUserById(String userId) throws SQLException {
		User user = null;
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_ID_QUERY);
		pstmt.setString(1, userId);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setTel(rs.getString("user_tel"));
			user.setEmail(rs.getString("user_email"));
			user.setAvailablePoint(rs.getInt("user_available_point"));
			user.setStatus(rs.getString("user_status"));
			user.setCreatedDate(rs.getDate("user_created_date"));
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return user;
	}
	
	/**
	 * 지정된 사용자번호로 사용자정보를 조회해서 반환한다.
	 * @param userNo 사용자번호
	 * @return 사용자 정보
	 * @throws SQLException
	 */
	public User getUserByNo(int userNo) throws SQLException {
		User user = null;
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_NO_QUERY);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setTel(rs.getString("user_tel"));
			user.setEmail(rs.getString("user_email"));
			user.setAvailablePoint(rs.getInt("user_available_point"));
			user.setStatus(rs.getString("user_status"));
			user.setCreatedDate(rs.getDate("user_created_date"));
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return user;
	}
	
	/**
	 * 신규 사용자정보를 저장한다.
	 * @param user 사용자정보
	 * @throws SQLException
	 */
	public void insertUser(User user) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(INSERT_USER_QUERY);
		pstmt.setString(1, user.getName());
		pstmt.setString(2, user.getId());
		pstmt.setString(3, user.getPassword());
		pstmt.setString(4, user.getTel());
		pstmt.setString(5, user.getEmail());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 사용자 정보를 변경한다.
	 * @param user 수정내용이 반영된 사용자 정보
	 * @throws SQLException
	 */
	public void updateUser(User user) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(UPDATE_USER_QUERY);
		pstmt.setString(1, user.getPassword());
		pstmt.setString(2, user.getTel());
		pstmt.setString(3, user.getEmail());
		pstmt.setInt(4, user.getAvailablePoint());
		pstmt.setString(5, user.getStatus());
		pstmt.setInt(6, user.getNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
}
