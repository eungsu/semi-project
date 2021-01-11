package kr.co.hta.shop.dto;

public class CartItemDto {

	private int itemNo;
	private int bookNo;
	private int categoryNo;
	private String bookTitle;
	private int bookPrice;
	private int bookSalePrice;
	private int bookSavePoint;
	private double bookDiscountRate;
	private int itemAmount;
	
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
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public int getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}
	public int getBookSalePrice() {
		return bookSalePrice;
	}
	public void setBookSalePrice(int bookSalePrice) {
		this.bookSalePrice = bookSalePrice;
	}
	public int getBookSavePoint() {
		return bookSavePoint;
	}
	public void setBookSavePoint(int bookSavePoint) {
		this.bookSavePoint = bookSavePoint;
	}
	public double getBookDiscountRate() {
		return bookDiscountRate;
	}
	public void setBookDiscountRate(double bookDiscountRate) {
		this.bookDiscountRate = bookDiscountRate;
	}
	public int getItemAmount() {
		return itemAmount;
	}
	public void setItemAmount(int itemAmount) {
		this.itemAmount = itemAmount;
	}
	@Override
	public String toString() {
		return "CartItemDto [itemNo=" + itemNo + ", bookNo=" + bookNo + ", categoryNo=" + categoryNo + ", bookTitle="
				+ bookTitle + ", bookPrice=" + bookPrice + ", bookSalePrice=" + bookSalePrice + ", bookDiscountRate="
				+ bookDiscountRate + ", itemAmount=" + itemAmount + "]";
	}
	
	
}
