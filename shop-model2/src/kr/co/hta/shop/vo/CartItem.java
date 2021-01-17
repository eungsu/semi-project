package kr.co.hta.shop.vo;

import java.util.Date;

public class CartItem {

	private int itemNo;
	private int bookNo;
	private int userNo;
	private int itemAmount;
	private Date createdDate;
	
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
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
	public int getItemAmount() {
		return itemAmount;
	}
	public void setItemAmount(int itemAmount) {
		this.itemAmount = itemAmount;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	@Override
	public String toString() {
		return "CartItem [itemNo=" + itemNo + ", bookNo=" + bookNo + ", userNo=" + userNo + ", itemAmount=" + itemAmount
				+ ", createdDate=" + createdDate + "]";
	}
}
