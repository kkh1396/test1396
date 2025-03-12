/*
	오라클(DB)에는 다양한 객체들이 있다.
	다음은 어떤 객체에 대한 설명인가? 해당 객체의 생성 구문도 작성해보자.
	
	* _VIEW_ : 테이블과 다르게 물리적으로 데이터를 저장하지 않으며,
						   기존 테이블의 특정 컬럼이나 조건을 적용하여 데이터를 볼 수 있다.
						   
	* __시퀀스______ : 자동 증가 값을 생성하는 객체. 주로 기본 키 관리 시 사용.
	
	* __트리거______ : 특정 이벤트 발생 시 자동으로 실행되도록 설정한 객체.
	
	* __사용자(USER)______ : 테이블, 뷰, 시퀀스 등의 객체를 소유할 수 있는 객체. 특정 권한을 부여 받아 다른 객체에 접근할 수 있음.
*/
-- * ---------------------------------------------------------------------- * --
/*
    * 사수의 사번을 입력받아 해당 사원의 사번, 이름을 출력
      - 사번 : XXX
      - 이름 : XXX
      
      단, 조회된 결과가 없을 경우 '입력한 사수 사번을 가진 사원이 없습니다.' 출력
      조회된 결과가 많을 경우 '해당 사수에 대한 사원이 많습니다.' 출력
      그 외의 예외 발생 시 '오류가 발생했습니다. 관리자에게 문의하세요.' 출력
      
      
*/


DECLARE
   E_ID EMPLOYEE.EMP_ID%TYPE;
   ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN

     SELECT EMP_ID, EMP_NAME
      INTO E_ID, ENAME
      FROM EMPLOYEE
      WHERE EMP_ID = &사번;


            DBMS_OUTPUT.PUT_LINE('E_ID : '|| E_ID);
             DBMS_OUTPUT.PUT_LINE('ENAME : '|| ENAME);


EXCEPTION 
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('입력한 사수 사번을 가진 사원이 없습니다.');
  
  WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('해당 사수에 대한 사원이 많습니다.');
  
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다. 관리자에게 문의하세요.');

END;
/


CREATE USER C##INDEXTEST IDENTIFIED BY INDEXTEST;
GRANT CONNECT, RESOURCE TO C##INDEXTEST;
ALTER USER C##INDEXTEST QUOTA 200M ON USERS;
   

