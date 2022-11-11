package com.fm.util;

public class BmiCalc {
	private int bNo = 0;
	private int uNo = 0;
	private int weight = 0;
	private int height = 0;
	private String gender = "";
	private int bRaw = 0;
	private int goalBmi = 0;
	private int goalCalory = 0;

	public BmiCalc() {
		super();
	}

	public BmiCalc(int bNo, int uNo, int weight, int height, String gender, int bRaw, int goalBmi, int goalCalory) {
		super();
		this.bNo = bNo;
		this.uNo = uNo;
		this.weight = weight;
		this.height = height;
		this.gender = gender;
		this.bRaw = bRaw;
		this.goalBmi = goalBmi;
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

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getbRaw() {
		return bRaw;
	}

	public void setbRaw(int bRaw) {
		this.bRaw = bRaw;
	}

	public int getGoalBmi() {
		return goalBmi;
	}

	public void setGoalBmi(int goalBmi) {
		this.goalBmi = goalBmi;
	}

	public int getGoalCalory() {
		return goalCalory;
	}

	public void setGoalCalory(int goalCalory) {
		this.goalCalory = goalCalory;
	}

		
}
