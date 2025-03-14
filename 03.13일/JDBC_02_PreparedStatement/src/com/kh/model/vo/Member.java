package com.kh.model.vo;

import java.sql.Date;

/*
 * * VO (Value Object)
 *   : 저장용 객체
 *   
 * --> 한 명의 회원에 대한 데이터를 저장하기 위한 객체
 *     => DB 테이블에서 한 행의 데이터
 */
public class Member {
	// * 필드부(변수) --> Member 테이블의 컬럼 정보와 매칭시켜 정의

	private int memberNo; // MEMBERNO NUMBER
	private String memberId; // MEMBERID VARCHAR2(20 BYTE)
	private String memberPw; // MEMBERPW VARCHAR2(20 BYTE)
	private char gender; // GENDER CHAR(1 BYTE)
	private int age; // AGE NUMBER
	private String email; // EMAIL VARCHAR2(30 BYTE)
	private String address; // ADDRESS VARCHAR2(100 BYTE)
	private String phone; // PHONE VARCHAR2(13 BYTE)
	private String hobby; // HOBBY VARCHAR2(50 BYTE)
	private Date enrollDate; // ENROLLDATE DATE
	// -> java.sql.Date
	// * 생성자부 : 기본생성자, 모든 필드를 매개변수로 가지는 생성자

	public Member() {
		super();
	}

	// 회원 추가 시 사용된 생성자
	public Member(String memberId, String memberPw, char gender, int age) {
		super();
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.gender = gender;
		this.age = age;
	}

	// 회원 정보 수정 시 사용된 생성자
	public Member(String memberId, String memberPw, char gender, String address, String hobby) {
		super();
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.gender = gender;
		this.address = address;
		this.hobby = hobby;
	}

	public Member(int memberNo, String memberId, String memberPw, char gender, int age, String email, String address,
			String phone, String hobby, Date enrollDate) {
		super();
		this.memberNo = memberNo;
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.gender = gender;
		this.age = age;
		this.email = email;
		this.address = address;
		this.phone = phone;
		this.hobby = hobby;
		this.enrollDate = enrollDate;
	}

	// * 메소드부 : getter/setter, toString
	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	@Override
	public String toString() {
		return "Member [memberNo=" + memberNo + ", memberId=" + memberId + ", memberPw=" + memberPw + ", gender="
				+ gender + ", age=" + age + ", email=" + email + ", address=" + address + ", phone=" + phone
				+ ", hobby=" + hobby + ", enrollDate=" + enrollDate + "]";
	}
}
