package com.fm.board.model;

import java.util.Date;

public class BoardDto {
	
	private int bNo = 0;
	private int uNo = 0;
	private String bTitle = "";
	private String bContent = "";
	private Date bqDate = null;
	private int rCount = 0;
	
	public BoardDto() {
		super();
	}

	public BoardDto(int bNo, int uNo, String bTitle, String bContent, Date bqDate, int rCount) {
		super();
		this.bNo = bNo;
		this.uNo = uNo;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bqDate = bqDate;
		this.rCount = rCount;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public Date getBqDate() {
		return bqDate;
	}

	public void setBqDate(Date bqDate) {
		this.bqDate = bqDate;
	}

	public int getrCount() {
		return rCount;
	}

	public void setrCount(int rCount) {
		this.rCount = rCount;
	}
	
}
