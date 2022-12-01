package com.fm.board.model;

import java.util.Date;

public class ReplyDto {
	
	private int irNo = 0;
	private int uNo = 0;
	private int bNo = 0;
	private	String irContent = "";
	private	Date createDate = null;
	private int irParentNo = 0;
	
	public ReplyDto() {
		super();
	}

	public ReplyDto(int irNo, int uNo, int bNo, String irContent, Date createDate, int irParentNo) {
		super();
		this.irNo = irNo;
		this.uNo = uNo;
		this.bNo = bNo;
		this.irContent = irContent;
		this.createDate = createDate;
		this.irParentNo = irParentNo;
	}

	public int getIrNo() {
		return irNo;
	}

	public void setIrNo(int irNo) {
		this.irNo = irNo;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getIrContent() {
		return irContent;
	}

	public void setIrContent(String irContent) {
		this.irContent = irContent;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getIrParentNo() {
		return irParentNo;
	}

	public void setIrParentNo(int irParentNo) {
		this.irParentNo = irParentNo;
	}

	@Override
	public String toString() {
		return "ReplyDto [irNo=" + irNo + ", uNo=" + uNo + ", bNo=" + bNo + ", irContent=" + irContent + ", createDate="
				+ createDate + ", irParentNo=" + irParentNo + "]";
	}

	
}
