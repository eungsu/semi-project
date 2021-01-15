package kr.co.hta.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.hta.shop.dto.ReviewDto;
import kr.co.hta.shop.util.ConnectionUtil;
import kr.co.hta.shop.vo.Review;

public class ReviewDao {

	private static ReviewDao reviewDao = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {
		return reviewDao;
	}

	private static final String GET_REVIEW_BY_NO_QUERY = "select * "
			                                           + "from shop2_book_reviews "
			                                           + "where review_no = ?";
	
	private static final String INSERT_REVIEW_QUERY = "insert into shop2_book_reviews"
													+ "(review_no, book_no, user_no, review_title, review_content, review_book_point)"
													+ "values"
													+ "(shop_review_seq.nextval, ?, ?, ?, ?, ?)";
	
	private static final String UPDATE_REVIEW_QUERY = "update shop2_book_reviews "
													+ "set "
													+ "	review_title = ?,"
													+ " review_content = ?, "
													+ " review_book_point = ?, "
													+ " review_like_count = ? "
													+ "where review_no = ?";
	
	private static final String GET_REVIEWSCOUNT_BY_BOOK_NO_QUERY = "select count(*) cnt "
			                                                      + "from shop2_book_reviews "
			                                                      + "where book_no = ? ";
	private static final String GET_REVIEWDTOS_BY_RAGNGE_QUERY = "select * "
			                                                + "from (select row_number() over (order by A.review_no desc) rn, "
			                                                + "              A.review_no, A.user_no, B.user_name, A.review_title, A.review_content, A.review_book_point, "
			                                                + "              A.review_like_count, A.review_created_date, "
			                                                + "              nvl2((select X.user_no "
			                                                + "                    from shop2_book_review_like_users X "
			                                                + "                    where X.review_no = A.review_no "
			                                                + "                    and X.user_no = ?), 'Y', 'N') review_liked "
			                                                + "      from shop2_book_reviews A, shop2_users B "
			                                                + "      where A.book_no = ?"
			                                                + "      and A.user_no = B.user_no) "
			                                                + "where rn >= ? and rn <= ? ";

	private static final String GET_REVIEWDTOS_BY_RAGNGE_WITHOUT_USERNO_QUERY = "select * "
			+ "from (select row_number() over (order by A.review_no desc) rn, "
			+ "              A.review_no, A.user_no, B.user_name, A.review_title, A.review_content, A.review_book_point, "
			+ "              A.review_like_count, A.review_created_date "
			+ "      from shop2_book_reviews A, shop2_users B "
			+ "      where A.book_no = ?"
			+ "      and A.user_no = B.user_no) "
			+ "where rn >= ? and rn <= ? ";
	
	private static final String INSERT_REVIEW_LIKE_USER_QUERY = "insert into shop2_book_review_like_users"
			                                                  + "(review_no, user_no)"
			                                                  + "values"
			                                                  + "(?, ?)";
	
	/**
	 * 지정된 책번호에 해당하는 책에 대한 리뷰 중에서 지정된 범위에 속하는 리뷰목록을 반환한다.
	 * @param bookNo 책번호
	 * @param begin 조회시작 행 번호
	 * @param end 조회종료 행 번호
	 * @return 리뷰목록
	 * @throws SQLException
	 */
	public List<ReviewDto> getReviewDtosByRange(int bookNo, int begin, int end) throws SQLException {
		List<ReviewDto> reviewDtoList = new ArrayList<>();
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_REVIEWDTOS_BY_RAGNGE_WITHOUT_USERNO_QUERY);
		pstmt.setInt(1, bookNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setContent(rs.getString("review_content"));
			reviewDto.setBookPoint(rs.getInt("review_book_point"));
			reviewDto.setLikeCount(rs.getInt("review_like_count"));
			reviewDto.setCreatedDate(rs.getDate("review_created_date"));
			
			reviewDtoList.add(reviewDto);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return reviewDtoList;
	}
	
	/**
	 * 지정된 책번호에 해당하는 책에 대한 리뷰 중에서 지정된 범위에 속하는 리뷰목록을 반환한다.<br />
	 * 지정된 사용자번호에 해당하는 사용자가 좋아요를 클릭한 리뷰에 대해서는 review_liked 값이 "Y"로 반환된다.
	 * @param bookNo 책번호
	 * @param userNo 사용자번호
	 * @param begin 조회시작 행번호
	 * @param end 조회끝 행번호
	 * @return 리뷰 목록
	 * @throws SQLException
	 */
	public List<ReviewDto> getReviewDtosByRange(int bookNo, int userNo, int begin, int end) throws SQLException {
		List<ReviewDto> reviewDtoList = new ArrayList<>();
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_REVIEWDTOS_BY_RAGNGE_QUERY);
		pstmt.setInt(1, userNo);
		pstmt.setInt(2, bookNo);
		pstmt.setInt(3, begin);
		pstmt.setInt(4, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setContent(rs.getString("review_content"));
			reviewDto.setBookPoint(rs.getInt("review_book_point"));
			reviewDto.setLikeCount(rs.getInt("review_like_count"));
			reviewDto.setCreatedDate(rs.getDate("review_created_date"));
			reviewDto.setReviewLiked(rs.getString("review_liked"));
			
			reviewDtoList.add(reviewDto);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return reviewDtoList;
	}
	
	/**
	 * 지정된 리뷰번호의 리뷰정보를 반환한다.
	 * @param reviewNo 리뷰번호
	 * @return 리뷰정보
	 * @throws SQLException
	 */
	public Review getReviewByNo(int reviewNo) throws SQLException {
		Review review = null;
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_REVIEW_BY_NO_QUERY);
		pstmt.setInt(1, reviewNo);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			//(review_no, book_no, user_no, review_title, review_content, review_book_point)
			review = new Review();
			review.setNo(rs.getInt("review_no"));
			review.setBookNo(rs.getInt("book_no"));
			review.setUserNo(rs.getInt("user_no"));
			review.setTitle(rs.getString("review_title"));
			review.setContent(rs.getString("review_content"));
			review.setBookPoint(rs.getInt("review_book_point"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setCreatedDate(rs.getDate("review_created_date"));
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return review;
		
	}
	
	/**
	 * 지정된 책번호에 해당하는 책에 대해 작성된 리뷰갯수를 반환한다.
	 * @param bookNo 책번호
	 * @return 리뷰갯수
	 * @throws SQLException
	 */
	public int getReviewsCountByBookNo(int bookNo) throws SQLException {
		int cnt = 0;
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(GET_REVIEWSCOUNT_BY_BOOK_NO_QUERY);
		pstmt.setInt(1, bookNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		cnt = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		con.close();
		
		return cnt;
	}

	/**
	 * 신규 리뷰정보를 저장한다.
	 * @param review 리뷰정보
	 * @throws SQLException
	 */
	public void insertReview(Review review) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(INSERT_REVIEW_QUERY);
		pstmt.setInt(1, review.getBookNo());
		pstmt.setInt(2, review.getUserNo());
		pstmt.setString(3, review.getTitle());
		pstmt.setString(4, review.getContent());
		pstmt.setInt(5, review.getBookPoint());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 리뷰정보를 수정한다.
	 * @param review 수정사항이 반영된 리뷰정보
	 * @throws SQLException
	 */
	public void updateReview(Review review) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(UPDATE_REVIEW_QUERY);
		pstmt.setString(1, review.getTitle());
		pstmt.setString(2, review.getContent());
		pstmt.setInt(3, review.getBookPoint());
		pstmt.setInt(4, review.getLikeCount());
		pstmt.setInt(5, review.getNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 리뷰번호와 사용자번호를 전달받아서 리뷰 좋아요 정보를 저장한다.
	 * @param reviewNo 리뷰번호
	 * @param userNo 사용자번호
	 * @throws SQLException
	 */
	public void insertReviewLikeUser(int reviewNo, int userNo) throws SQLException {
		Connection con = ConnectionUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(INSERT_REVIEW_LIKE_USER_QUERY);
		pstmt.setInt(1, reviewNo);
		pstmt.setInt(2, userNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
}
