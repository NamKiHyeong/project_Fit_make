package com.fm.util;

import java.sql.Date;

public class PointAdd {
	private int uNo = 0;
	private int pNo = 0;
	private int pHistory = 0;
	private Date pcreateDate = null;
	private int oNo = 0;

	public PointAdd() {
		super();
	}

	public PointAdd(int uNo, int pNo, int pHistory, Date pcreateDate) {
		super();
		this.uNo = uNo;
		this.pNo = pNo;
		this.pHistory = pHistory;
		this.pcreateDate = pcreateDate;
	}
	
	public PointAdd(int uNo, int pNo, int pHistory, Date pcreateDate, int oNo) {
		super();
		this.uNo = uNo;
		this.pNo = pNo;
		this.pHistory = pHistory;
		this.pcreateDate = pcreateDate;
		this.oNo = oNo;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public int getpHistory() {
		return pHistory;
	}

	public void setpHistory(int pHistory) {
		this.pHistory = pHistory;
	}

	public Date getPcreateDate() {
		return pcreateDate;
	}

	public void setPcreateDate(Date pcreateDate) {
		this.pcreateDate = pcreateDate;
	}

	public int getoNo() {
		return oNo;
	}

	public void setoNo(int oNo) {
		this.oNo = oNo;
	}
	
	
}
