package com.fm.order.model;

public class CartDto {
	
	private int ctNo = 0;
	private int uNo = 0;
	private int iNo = 0;
	private int ctCount = 0;
	
	public CartDto() {
		super();
	}

	public CartDto(int ctNo, int uNo, int iNo, int ctCount) {
		super();
		this.ctNo = ctNo;
		this.uNo = uNo;
		this.iNo = iNo;
		this.ctCount = ctCount;
	}

	public int getCtNo() {
		return ctNo;
	}

	public void setCtNo(int ctNo) {
		this.ctNo = ctNo;
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

	public int getCtCount() {
		return ctCount;
	}

	public void setCtCount(int ctCount) {
		this.ctCount = ctCount;
	}

	@Override
	public String toString() {
		return "CartDto [ctNo=" + ctNo + ", uNo=" + uNo + ", iNo=" + iNo + ", ctCount=" + ctCount + "]";
	}

}
