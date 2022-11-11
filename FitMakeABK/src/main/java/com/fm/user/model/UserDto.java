package com.fm.user.model;

import java.util.Date;

public class UserDto {

	private int uNo = 0;
	private String nickName = "";
	private String email = "";
	private String password = "";
	private String mobile = "";
	private String zipCode = "";
	private String address = "";
	private Date createDate = null;
	private int point = 0; // 뽀인뜨

	public UserDto() {
		super();
	}

	public UserDto(int uNo, String nickName, String email, String password, String mobile, String zipCode,
			String address, Date createDate, int point) {
		super();
		this.uNo = uNo;
		this.nickName = nickName;
		this.email = email;
		this.password = password;
		this.mobile = mobile;
		this.zipCode = zipCode;
		this.address = address;
		this.createDate = createDate;
		this.point = point;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

}
