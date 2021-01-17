package kr.co.hta.shop.vo;

import java.util.Date;

public class Order {

	private int no;
	private int userNo;
	private String description;
	private int amount;
	private String status;
	private String recipientName;
	private String recipientTel;
	private String recipientZipcode;
	private String recipientAddress;
	private String message;
	private int totalOrderPrice;
	private int usedPointAmount;
	private int totalPaymentPrice;
	private int totalSavedPoint;
	private Date createdDate;
	
	public Order() {}

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getRecipientTel() {
		return recipientTel;
	}

	public void setRecipientTel(String recipientTel) {
		this.recipientTel = recipientTel;
	}

	public String getRecipientZipcode() {
		return recipientZipcode;
	}

	public void setRecipientZipcode(String recipientZipcode) {
		this.recipientZipcode = recipientZipcode;
	}

	public String getRecipientAddress() {
		return recipientAddress;
	}

	public void setRecipientAddress(String recipientAddress) {
		this.recipientAddress = recipientAddress;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getTotalOrderPrice() {
		return totalOrderPrice;
	}

	public void setTotalOrderPrice(int totalOrderPrice) {
		this.totalOrderPrice = totalOrderPrice;
	}

	public int getUsedPointAmount() {
		return usedPointAmount;
	}

	public void setUsedPointAmount(int usedPointAmount) {
		this.usedPointAmount = usedPointAmount;
	}

	public int getTotalPaymentPrice() {
		return totalPaymentPrice;
	}

	public void setTotalPaymentPrice(int totalPaymentPrice) {
		this.totalPaymentPrice = totalPaymentPrice;
	}

	public int getTotalSavedPoint() {
		return totalSavedPoint;
	}

	public void setTotalSavedPoint(int totalSavedPoint) {
		this.totalSavedPoint = totalSavedPoint;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
}
