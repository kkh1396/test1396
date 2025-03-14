package com.kh.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.model.vo.Member;

/*
 * DAO (Database Access Object)
 * : DB에 직접 접근하여 사용자의 요청에 맞는 SQL문 실행 후 결과 반환
 *   --> JDBC 사용
 */
public class MemberDao {
	// * 기존 상수 필드 정보는 JDBCTemplate 클래스에서 사용되어 제거 *
	
	
	/**
	 * 회원 정보 추가 메소드
	 * @param conn 생성되어 있는 Connection 객체
	 * @param m 회원 정보가 저장된 Member 객체
	 * @return 처리된 결과(처리된 행 수)
	 */
	public int insertMember(Connection conn, Member m) {
		int result = 0;
		
		// 1) jdbc driver 등록		-- Service 객체가 완료
		// 2) Connection 객체 생성    -- Service 객체가 완료
		// ----------------------------------------------
		PreparedStatement pstmt = null;
		try {
			// 3) Statement 객체 생성
			String sql = "INSERT INTO MEMBER "
					   + " VALUES (SEQ_MNO.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, m.getMemberId());
			pstmt.setString(2, m.getMemberPw());
			pstmt.setString(3, m.getGender());
			pstmt.setInt(4, m.getAge());
			pstmt.setString(5, m.getEmail()); 	// 이메일
			pstmt.setString(6, m.getAddress()); // 주소
			pstmt.setString(7, m.getPhone());	// 연락처
			pstmt.setString(8, m.getHobby());   // 취미
			
			// 4) SQL문 실행 5) 결과 받기
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 6) 결과에 대한 처리:트랜잭션처리	--> Service 객체에서 담당
			// 7) 자원 반납
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	/**
	 * 전체 회원에 대한 정보를 DB에서 조회
	 * @param conn Connection 객체
	 * @return 조회된 결과(회원목록)
	 */
	public ArrayList<Member> selectAll(Connection conn) {
		// TODO Auto-generated method stub
		return null;
	}
}









