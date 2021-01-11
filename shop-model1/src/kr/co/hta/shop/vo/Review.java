package kr.co.hta.shop.vo;

import java.util.Date;

public class Review {

	private int no;
	private int bookNo;
	private int userNo;
	private String title;
	private String content;
	private int bookPoint;
	private int likeCount;
	private Date createdDate;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
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
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	@Override
	public String toString() {
		return "Review [no=" + no + ", bookNo=" + bookNo + ", userNo=" + userNo + ", title=" + title + ", content="
				+ content + ", bookPoint=" + bookPoint + ", likeCount=" + likeCount + ", createdDate=" + createdDate
				+ "]";
	}
	
	
}
