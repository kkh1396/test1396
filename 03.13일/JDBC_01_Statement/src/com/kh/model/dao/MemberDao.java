package com.kh.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.kh.model.vo.Member;

/*
 * DAO (Database Access Object)
 * : DB에 직접 접근하여 사용자의 요청에 맞는 SQL문 실행 후 결과 반환
 *   --> JDBC 사용
 */
public class MemberDao {
	// * DB 정보 : 서버주소, 사용자명, 비밀번호 
	private final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private final String USER_NAME = "C##JDBC";
	private final String PASSWORD = "JDBC";
	
	/**
	 * 회원 전체 목록을 조회하여 반환하는 메소드
	 * @return 전체 회원 목록
	 */
	public ArrayList<Member> selectAllList() {
		ArrayList<Member> list = new ArrayList<>();	// []
		
		// DQL(SELECT)문 실행 (여러 행 조회) ---> ResultSet 객체 ---> ArrayList에 담기
		
		// * JDBC용 객체 선언
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		
		// * 실행할 sql문
		String sql = "SELECT * FROM MEMBER";
		
		try {
			// 1) JDBC 드라이버 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2) Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			
			// 3) Statement 객체 생성
			stat = conn.createStatement();
			
			// 4) SQL 실행 , 5) 결과 받기
			rset = stat.executeQuery(sql);
			
			// 6) ResultSet 에 담겨져 있는 데이터를 하나하나 추출
			while(rset.next()) {
				// [1] 데이터를 추출하여 Member 객체에 담기(생성)
				Member m = new Member(
							rset.getInt("MEMBERNO"),
							rset.getString("MEMBERID"),
							rset.getString("memberpw"),
							rset.getString("gender").charAt(0),
							rset.getInt("AGE"),
							rset.getString("email"),
							rset.getString("address"),
							rset.getString("PHONE"),
							rset.getString("HOBBY"),
							rset.getDate("enrollDate")
						);
				
				// [2] Member 객체를 리스트에 추가
				list.add(m);				
			}
			// * 반복문이 끝난 시점
			//   --> 조회된 데이터가 있다면 ? 리스트에는 최소 한 개 이상의 데이터가 담겨져있을 것임!
			//   --> 조회된 데이터가 없다면 ? 리스트는 비어있을 것임!
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			// 7) 자원 반납
			try {
				rset.close();
				stat.close();
				conn.close();
			} catch(SQLException e) { e.printStackTrace(); }
		}
		
		return list;
	}

	/**
	 * 요청된 회원 정보를 DB에 추가하는 메소드
	 * @param m 사용자가 입력한 정보들이 담겨있는 Member 객체
	 * @return 추가(INSERT) 후 처리된 행 수
	 */
	public int insertMember(Member m) {
		int result = 0;
		// DML(insert)  --->  int (처리된 행 수)  --->  트랜잭션 처리
		
		String sql = "INSERT INTO MEMBER"
				+ "        VALUES (SEQ_MNO.NEXTVAL"
				+ "                , '" + m.getMemberId() + "'"
				+ "                , '" + m.getMemberPw() + "'"
				+ "                , '" + m.getGender() + "'"
				+ "                , " + m.getAge()
				+ "                , '" + m.getEmail() + "'"
				+ "                , '" + m.getAddress() + "'"
				+ "                , '" + m.getPhone() + "'"
				+ "                , '" + m.getHobby() + "'"
				+ "                , SYSDATE)";
		
		System.out.println("--------------------------");
		System.out.println(sql);
		System.out.println("--------------------------");
		
		// * JDBC용 객체 선언
		Connection conn = null;
		Statement stat = null;
		
		try {
			// 1) jdbc driver 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2) Connection 객체 생성 (DB 정보로 연결)
			conn = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			conn.setAutoCommit(false); // -> Auto commit 해제
			
			// 3) Statement 객체 생성 (Connection 객체로 생성)
			stat = conn.createStatement();
			
			// 4) SQL 실행 5) 결과 받기
			result = stat.executeUpdate(sql);
			
			// 6) 트랜잭션 처리
			if (result > 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 7) 자원 반납
			try {
				stat.close();
				conn.close();
			} catch (SQLException e) { e.printStackTrace(); }
		}
		
		
		return result;
	}
}









