package com.fm.item.model;

public class ItemDto {
	
	private int iNo = 0;
	private int cNo = 0;
	private String iName = "";
	private int iCalory = 0;
	private int iRawprice = 0;
	private int iSellprice = 0;
	private int iCount = 0;
	private int iCGrade = 0;
	private String iOneDetail = "";
	private int uNo = 0;
	private String iImgStoredName = "";
	private int rCount = 0;
	
	public ItemDto() {
		super();
	}
	
	public ItemDto(int iNo, int cNo, String iName, int iCalory, int iRawprice, int iSellprice, int iCount, int iCGrade,
			String iOneDetail) {
		super();
		this.iNo = iNo;
		this.cNo = cNo;
		this.iName = iName;
		this.iCalory = iCalory;
		this.iRawprice = iRawprice;
		this.iSellprice = iSellprice;
		this.iCount = iCount;
		this.iCGrade = iCGrade;
		this.iOneDetail = iOneDetail;
	}
	
	public ItemDto(int iNo, int cNo, String iName, int iCalory, int iRawprice, int iSellprice, int iCount, int iCGrade,
			String iOneDetail, int uNo, String iImgStoredName, int rCount) {
		super();
		this.iNo = iNo;
		this.cNo = cNo;
		this.iName = iName;
		this.iCalory = iCalory;
		this.iRawprice = iRawprice;
		this.iSellprice = iSellprice;
		this.iCount = iCount;
		this.iCGrade = iCGrade;
		this.iOneDetail = iOneDetail;
		this.uNo = uNo;
		this.iImgStoredName = iImgStoredName;
		this.rCount = rCount;
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
	
	public String getiOneDetail() {
		return iOneDetail;
	}
	
	public void setiOneDetail(String iOneDetail) {
		this.iOneDetail = iOneDetail;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public String getiImgStoredName() {
		return iImgStoredName;
	}

	public void setiImgStoredName(String iImgStoredName) {
		this.iImgStoredName = iImgStoredName;
	}
	
	public int getrCount() {
		return rCount;
	}

	public void setrCount(int rCount) {
		this.rCount = rCount;
	}

	@Override
	public String toString() {
		return "ItemDto [iNo=" + iNo + ", cNo=" + cNo + ", iName=" + iName + ", iCalory=" + iCalory + ", iRawprice="
				+ iRawprice + ", iSellprice=" + iSellprice + ", iCount=" + iCount + ", iCGrade=" + iCGrade
				+ ", iOneDetail=" + iOneDetail + ", uNo=" + uNo + ", iImgStoredName=" + iImgStoredName + ", rCount="
				+ rCount + "]";
	}

	
}
