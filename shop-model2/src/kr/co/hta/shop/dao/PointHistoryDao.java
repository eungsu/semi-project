package kr.co.hta.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.hta.shop.util.ConnectionUtil;
import kr.co.hta.shop.vo.PointHistory;

public class PointHistoryDao {

	private static PointHistoryDao pointHistoryDao = new PointHistoryDao();
	private PointHistoryDao() {}
	public static PointHistoryDao getInstance() {
		return pointHistoryDao;
	}
	
	private static final String INSERT_POINT_HISTORY_QUERY = "insert into shop2_user_point_histories"
														   + "(history_no, user_no, history_content, order_no, history_point_amount)"
														   + "values"
														   + "(shop2_history_seq.nextval, ?, ?, ?, ?)";
	private static final String GET_POINT_HISTROIES_BY_USERNO_QUERY = "select * "
																	+ "from shop2_user_point_histories "
																	+ "where user_no = ? "
																	+ "order by history_no desc";
	
	/**
	 * 포인트변경이력정보를 저장한다.
	 * @param pointHistory 포인트변경이력 정보
	 * @throws SQLException
	 */
	public void insertPointHistory(PointHistory pointHistory) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(INSERT_POINT_HISTORY_QUERY);
		pstmt.setInt(1, pointHistory.getUserNo());
		pstmt.setString(2, pointHistory.getContent());
		pstmt.setInt(3, pointHistory.getOrderNo());
		pstmt.setInt(4, pointHistory.getPointAmount());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 지정된 사용자번호로 저장된 포인트이력정보 목록을 반환한다.
	 * @param userNo 사용자 번호
	 * @return 포인트 이력정보 목록
	 * @throws SQLException
	 */
	public List<PointHistory> getPointHistoriesByUserNo(int userNo) throws SQLException {
		List<PointHistory> pointHistories = new ArrayList<>();
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_POINT_HISTROIES_BY_USERNO_QUERY);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			PointHistory pointHistory = new PointHistory();
			pointHistory.setNo(rs.getInt("history_no"));
			pointHistory.setUserNo(rs.getInt("user_no"));
			pointHistory.setContent(rs.getString("history_content"));
			pointHistory.setOrderNo(rs.getInt("order_no"));
			pointHistory.setPointAmount(rs.getInt("history_point_amount"));
			pointHistory.setCreatedDate(rs.getDate("history_created_date"));
			
			pointHistories.add(pointHistory);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return pointHistories;
	}
}
