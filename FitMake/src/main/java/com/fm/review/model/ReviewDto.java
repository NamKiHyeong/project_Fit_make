package com.fm.review.model;

import java.util.Date;

public class ReviewDto {

	private int rNo = 0;
	private int iNo = 0;
	private int uNo = 0;
	private String rTitle = "";
	private String rContent = "";
	private Date rCreDate = null;
	private Date rModDate = null;

	public ReviewDto(int rNo, int iNo, int uNo, String rTitle, String rContent, Date rCreDate, Date rModDate) {
		super();
		this.rNo = rNo;
		this.iNo = iNo;
		this.uNo = uNo;
		this.rTitle = rTitle;
		this.rContent = rContent;
		this.rCreDate = rCreDate;
		this.rModDate = rModDate;
	}
	public ReviewDto() {
		super();
	}


	public int getrNo() {
		return rNo;
	}
	public void setrNo(int rNo) {
		this.rNo = rNo;
	}
	public int getiNo() {
		return iNo;
	}
	public void setiNo(int iNo) {
		this.iNo = iNo;
	}
	public int getuNo() {
		return uNo;
	}
	public void setuNo(int uNo) {
		this.uNo = uNo;
	}
	public String getrTitle() {
		return rTitle;
	}
	public void setrTitle(String rTitle) {
		this.rTitle = rTitle;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public Date getrCreDate() {
		return rCreDate;
	}
	public void setrCreDate(Date rCreDate) {
		this.rCreDate = rCreDate;
	}
	public Date getrModDate() {
		return rModDate;
	}
	public void setrModDate(Date rModDate) {
		this.rModDate = rModDate;
	}
	@Override
	public String toString() {
		return "ReviewDto [rNo=" + rNo + ", iNo=" + iNo + ", uNo=" + uNo + ", rTitle=" + rTitle + ", rContent="
				+ rContent + ", rCreDate=" + rCreDate + ", rModDate=" + rModDate + "]";
	}
}
