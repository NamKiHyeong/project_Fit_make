package com.fm.order.model;

import java.util.Date;

public class OrderDto {
	
	private int oNo = 0;
	private int uNo = 0;
	private Date createDate = null;
	private String oStatus = "";
	private String uNickname = "";
	private int totalPrice = 0;
	
	public OrderDto() {
		super();
	}

	public OrderDto(int oNo, int uNo, Date createDate, String oStatus, String uNickname, int totalPrice) {
		super();
		this.oNo = oNo;
		this.uNo = uNo;
		this.createDate = createDate;
		this.oStatus = oStatus;
		this.uNickname = uNickname;
		this.totalPrice = totalPrice;
	}

	public int getoNo() {
		return oNo;
	}

	public void setoNo(int oNo) {
		this.oNo = oNo;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getoStatus() {
		return oStatus;
	}

	public void setoStatus(String oStatus) {
		this.oStatus = oStatus;
	}

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	
}
