package com.kh.controller;

import java.util.ArrayList;

import com.kh.model.dao.MemberDao;
import com.kh.model.vo.Member;
import com.kh.view.MemberMenu;

/*
 *	* Controller : View로부터 사용자가 요청한 기능에 대해 처리하는 역할
 *				   전달받은 데이터를 가공처리한 후 DAO로 전달하여 호출
 *				   DAO로부터 반환받은 결과에 따라 성공인지, 실패인지 판단 후 응답  
 */
public class MemberController {
	private MemberDao mDao = new MemberDao();
	/**
	 * 회원 추가 요청을 처리할 메소드
	 * @param id		신규회원아이디
	 * @param pwd		신규회원비밀번호
	 * @param gender	성별
	 * @param age		나이
	 */
	public void insertMember(String id, String pwd
								, char gender, int age) {
		// View로부터 전달받은 값들을 DAO에게 바로 전달하지 않고
		// Member 객체에 담아서 전달
		
		// * Member 객체 생성
		//   - 기본생성자로 생성 후 setter를 이용해 저장
		//	 - 매개변수가 있는 생성자를 사용하여 저장
		Member m = new Member(id, pwd, gender, age);
		
		// DAO에게 신규회원정보(Member)를 전달하여 추가 요청
		int result = mDao.insertMember(m);
		
		if (result > 0) {
			// 회원 추가 성공 출력(=> View를 이용하여)
			new MemberMenu().displaySuccess("회원 추가 성공!!");
		} else {
			// 회원 추가 실패 출력(=> View 이용)
			new MemberMenu().displayFailed("회원 추가 실패TT");
		}
	}
	
	/**
	 * 전체 회원 정보들을 조회 메소드
	 */
	public void selectAll() {
		ArrayList<Member> list = mDao.selectAllList();
		
		// * 조회된 결과에 따라 사용자에게 표시(출력)
		// if (list.size() == 0) {
		if (list.isEmpty()) {
			// 조회 결과가 없을 경우 (=> 리스트가 비어있다면)
			new MemberMenu().displayNoData();
		} else {
			// 조회 결과가 있을 경우
			new MemberMenu().displayAllMembers(list);
		}
	}
}










