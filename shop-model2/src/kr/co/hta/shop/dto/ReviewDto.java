package kr.co.hta.shop.dto;

import java.util.Date;

public class ReviewDto {

	private int no;
	private int userNo;
	private String userName;
	private String title;
	private String content;
	private int bookPoint;
	private int likeCount;
	private String reviewLiked;
	private Date createdDate;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getBookPoint() {
		return bookPoint;
	}
	public void setBookPoint(int bookPoint) {
		this.bookPoint = bookPoint;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public String getReviewLiked() {
		return reviewLiked;
	}
	public void setReviewLiked(String reviewLiked) {
		this.reviewLiked = reviewLiked;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	
}
