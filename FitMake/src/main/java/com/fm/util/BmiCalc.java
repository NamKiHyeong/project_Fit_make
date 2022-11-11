package com.fm.util;

public class BmiCalc {
	private int bNo = 0;
	private int uNo = 0;
	private double weight = 0;
	private double height = 0;
	private String gender = "";
	private double bRaw = 0;
	private double goalBmi = 0;
	private double goalCalory = 0;

	public BmiCalc() {
		super();
	}

	public BmiCalc(int bNo, int uNo, double weight, double height, String gender, double bRaw, double goalBmi,
			double goalCalory) {
		super();
		this.bNo = bNo;
		this.uNo = uNo;
		this.weight = weight;
		this.height = height;
		this.gender = gender;
		this.bRaw = Math.round((weight / (height*height)) * 100000) / 10d;
		this.goalBmi = (Math.round((weight / (height*height)) * 100000) / 10d)-1;
		this.goalCalory = goalCalory;
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

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public double getbRaw() {
		return bRaw;
	}

	public void setbRaw(double bRaw) {
		this.bRaw = bRaw;
	}

	public double getGoalBmi() {
		return goalBmi;
	}

	public void setGoalBmi(double goalBmi) {
		this.goalBmi = goalBmi;
	}

	public double getGoalCalory() {
		return goalCalory;
	}

	public void setGoalCalory(double goalCalory) {
		this.goalCalory = goalCalory;
	}

}
