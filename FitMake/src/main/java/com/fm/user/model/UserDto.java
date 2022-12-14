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
	private long salt;

	public UserDto() {
		super();
	}

	public UserDto(int uNo, String nickName, String email, String password, String mobile, String zipCode,
			String address, Date createDate, int point, long salt) {
		super();
		this.uNo = uNo;
		this.nickName = nickName;
		this.email = email;
		this.mobile = mobile;
		this.zipCode = zipCode;
		this.address = address;
		this.createDate = createDate;
		this.point = point;
		this.password = password;
		// 사용자가 입력한 비밀번호 salt화
		this.salt = salt;
	}
	
	//salt 로직(함수화)
	public long addSalt() {
		Date today = new Date();

		long randomSalt = (long) (Math.random() * today.getTime());

		System.out.println(randomSalt);

		return randomSalt;
	}
	
	// SHA-256사용 16진수로 패스워드 해시화
	public String setHashpwd(long salt, String password) {
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

	public long getSalt() {
		return salt;
	}

	public void setSalt(long salt) {
		this.salt = salt;
	}

}
