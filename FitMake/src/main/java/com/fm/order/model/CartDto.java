package com.fm.order.model;

public class CartDto {
	
	private int cNo = 0;
	private int uNo = 0;
	private int iNo = 0;
	private int cCount = 0;
	
	public CartDto() {
		super();
	}

	public CartDto(int cNo, int uNo, int iNo, int cCount) {
		super();
		this.cNo = cNo;
		this.uNo = uNo;
		this.iNo = iNo;
		this.cCount = cCount;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public int getiNo() {
		return iNo;
	}

	public void setiNo(int iNo) {
		this.iNo = iNo;
	}

	public int getcCount() {
		return cCount;
	}

	public void setcCount(int cCount) {
		this.cCount = cCount;
	}
	
	
}
