package com.fm.item.model;

public class ItemDto {

	private int cNo = 0;
	private int iNo = 0;
	private String iName = "";
	private int iCalory = 0;
	private int iRawprice = 0;
	private int iSellprice = 0;
	private int iCount = 0;
	private int iCGrade = 0;
	
	public ItemDto() {
		super();
	}

	public ItemDto(int cNo,int iNo, String iName, int iCalory, int iRawprice, int iSellprice, int iCount, int iCGrade) {
		super();
		this.cNo = cNo;
		this.iNo = iNo;
		this.iName = iName;
		this.iCalory = iCalory;
		this.iRawprice = iRawprice;
		this.iSellprice = iSellprice;
		this.iCount = iCount;
		this.iCGrade = iCGrade;
	}
	
	
	public int getiNo() {
		return iNo;
	}

	public void setiNo(int iNo) {
		this.iNo = iNo;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
	}

	public String getiName() {
		return iName;
	}

	public void setiName(String iName) {
		this.iName = iName;
	}

	public int getiCalory() {
		return iCalory;
	}

	public void setiCalory(int iCalory) {
		this.iCalory = iCalory;
	}

	public int getiRawprice() {
		return iRawprice;
	}

	public void setiRawprice(int iRawprice) {
		this.iRawprice = iRawprice;
	}

	public int getiSellprice() {
		return iSellprice;
	}

	public void setiSellprice(int iSellprice) {
		this.iSellprice = iSellprice;
	}

	public int getiCount() {
		return iCount;
	}

	public void setiCount(int iCount) {
		this.iCount = iCount;
	}

	public int getiCGrade() {
		return iCGrade;
	}

	public void setiCGrade(int iCGrade) {
		this.iCGrade = iCGrade;
	}

	@Override
	public String toString() {
		return "ItemDto [cNo=" + cNo + ", iName=" + iName + ", iCalory=" + iCalory + ", iRawprice=" + iRawprice
				+ ", iSellprice=" + iSellprice + ", iCount=" + iCount + ", iCGrade=" + iCGrade + "]";
	}


	
	
}
