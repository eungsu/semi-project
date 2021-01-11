package kr.co.hta.shop.vo;

import java.util.Date;

public class User {

	private int no;
	private String name;
	private String id;
	private String password;
	private String tel;
	private String email;
	private int availablePoint;
	private String status;
	private Date createdDate;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getAvailablePoint() {
		return availablePoint;
	}
	public void setAvailablePoint(int availablePoint) {
		this.availablePoint = availablePoint;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	@Override
	public String toString() {
		return "User [no=" + no + ", name=" + name + ", id=" + id + ", password=" + password + ", tel=" + tel
				+ ", email=" + email + ", availablePoint=" + availablePoint + ", status=" + status + ", createdDate="
				+ createdDate + "]";
	}
	
	
}
