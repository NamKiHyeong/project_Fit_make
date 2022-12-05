package com.fm.user.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

public class UserDto {

	private int uNo = 0;
	private String nickName = "";
	private String email = "";
	private String password = "";
	private String mobile = "";
	private String zipCode = "";
	private String address = "";
	private Date createDate = null;
	private int point = 0; // 뽀인뜨
	private int salt;

	public UserDto() {
		super();
	}

	public UserDto(int uNo, String nickName, String email, String password, String mobile, String zipCode,
			String address, Date createDate, int point, int salt) {
		super();
		this.uNo = uNo;
		this.nickName = nickName;
		this.email = email;
		this.mobile = mobile;
		this.zipCode = zipCode;
		this.address = address;
		this.createDate = createDate;
		this.point = point;
//		int addSalt = addSalt();
		this.password = password;
		this.salt = salt;
//		this.password = setHashpwd(addSalt, password);
	}

	public int addSalt() {
		Date today = new Date();

		int randomSalt = (int) (Math.random() * today.getTime());

		System.out.println(randomSalt);

		return randomSalt;
	}

	public String setHashpwd(int salt, String password) {
		StringBuffer sb = new StringBuffer();
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update((password + salt).getBytes());
			byte[] data = md.digest();
			for (byte b : data) {
				sb.append(String.format("%02x", b));
			}

		} catch (NoSuchAlgorithmException e) {

			e.printStackTrace();
		}
		System.out.println(sb.toString() + "setHashpwd");
		return sb.toString();
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getSalt() {
		return salt;
	}

	public void setSalt(int salt) {
		this.salt = salt;
	}

}
