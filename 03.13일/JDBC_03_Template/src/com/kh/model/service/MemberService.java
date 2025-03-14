package com.kh.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.model.dao.MemberDao;
import com.kh.model.vo.Member;

public class MemberService {
	/*
	 * [1] Connection 객체 생성
	 * 		- jdbc driver 등록
	 * 		- Connection 객체 생성
	 * [2] DML문 실행했을 경우 트랜잭션 처리
	 * 		- commit
	 * 		- rollback
	 * [3] Connection 객체 반납
	 * 		- close
	 */
	
	/**
	 * 회원 추가 기능에 대한 메소드
	 * @param m 추가할 회원 정보
	 * @return 처리 결과
	 */
	public int insertMember(Member m) {
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnection();
		
		// 2) DAO 객체에게 전달받은 데이터(Member m)와 
		//				생성한 Connection 객체를 전달하여 결과 받기
		int result = new MemberDao().insertMember(conn, m);
		
		// 3) 실행한 SQL문 확인 => DML, insert
		//		- DML 이므로 트랜잭션 처리
		if (result > 0) {
			// 커밋처리
			JDBCTemplate.commit(conn);
		} else {
			// 롤백처리
			JDBCTemplate.rollback(conn);
		}
		
		// 4) Connection 객체 반납
		JDBCTemplate.close(conn);
		
		// 5) 결과 반환
		return result;
	}

	/**
	 * 전체 회원 목록을 조회 메소드
	 * @return 전체 회원 목록 정보
	 */
	public ArrayList<Member> selectAllList() {
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnection();
		
		// 2) DAO에게 전체회원 목록 요청 --> 생성된 Connection 객체 전달
		ArrayList<Member> list = new MemberDao().selectAll(conn);
		
		// 3) Connection 객체 반납
		JDBCTemplate.close(conn);
		
		// 4) 조회 결과 반환
		return list;
	}
}






