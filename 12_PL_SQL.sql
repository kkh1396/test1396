/*
      * PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL
      
      오라클 자체에 내장되어 있는 절차적 언어 
      SQL 문장 내에서 변수 정의, 조건문, 반복문 등을 지원 -> 단점을 보완
      다수의 SQL문을 한번에 실행 가능

      * 구조 *
      
      [선언부]  : DECLARE 로 시작. 변수나 상수를 초기화하는 부분.
      실행부    : BEGIN으로 시작. SQL문 또는 제어문(조건문, 반복문)등의 로직을 작성하는 부분
      [예외처리부] : EXCEPTION으로 시작. 예외 발생시 해결하기 위한 부분.
*/


-- * 화면에 표시하기 위한 설정
SET SERVEROUTPUT ON;

-- "HELLO ORACLE: 출력
--> 화면에 출력하고자 할 때 : DBMS_OUTPUT.PUT_LINE(출력할내용)

BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
  --> JAVA : System.out.println("Hello Java");
end;
/
  
---------------------------------------------------------------------------
/*
    * 선언부 (DECLARE)
     : 변수 또는 상수를 선언하는 부분 (선언과 동시에 초기화도 가능)
     
     - 데이터타입 선언 종류
     * 일반 타입
     * 레퍼런스 타입
     * ROW 타입
*/
---------------------------------------------------------------------------
/*
   * 일반 타입 변수  *
   
    변수명 [CONSTANT] 자료형 [:= 값]
   
    -- 상수 선언 시 CONSTANT를 추가
    -- 초기화 시 := 기호를 사용
    
*/

DECLARE
 EID NUMBER;         -- EID 라는 이름의 NUMBER 타입 변수 
 ENAME VARCHAR2(20); -- ENAME 라는 이름의 VARCHAR2(20) 타입 변수 
 PI CONSTANT NUMBER := 3.14;  -- PI 라는 이름의 NUMBER 타입 상수 선언 및 3.14라는 값으로 초기화
BEGIN
     -- * 변수에 값을 대입
     EID := 100;      -- EID 변수에 100이라는 값을 대입
     ENAME := 'KKH';  -- ENAME 변수에 본인 이름 
     
     -- * 각 변수, 상수에 저장된 값을 화면에 출력
     DBMS_OUTPUT.PUT_LINE(EID);
     DBMS_OUTPUT.PUT_LINE(ENAME);
     DBMS_OUTPUT.PUT_LINE(PI);
     DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
       --> 특정 문자와 값(변수)을 연결하고자 할 겨우 연결연산자(||)를 사용!
END;
/


-- * 값을 입력 받아 변수에 대입

DECLARE 
   EID NUMBER;
   ENAME VARCHAR2(20);
   PI CONSTANT NUMBER := 3.14;
BEGIN
  ENAME := 'K';
  EID := &사원번호;
  --> 값을 입력받고자 할 경우 &대체변수명 형식으로 작성
  
  DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
  DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
  DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
  
END;
/
  
  
----------------------------------------------------------------------------
/*
    * 레퍼런스 타입 변수 *
       : 어떤 테이블의 어떤 컬럼의 데이터타입을 참조하여 해당 타입으로 변수를 선언
    
    변수명  테이블명.컬럼명%TYPE
*/
  
-- EID 라는 변수는 EMPLOYEE 테이블의 EMP_ID 컬럼의 타입을 참조
-- ENAME 라는 변수는 EMPLOYEE 테이블의 EMP_NAME 컬럼의 타입을 참조
-- SAL 라는 변수 EMPLOYEE 테이블의 SALARY 컬럼의 타입을 참조 

DECLARE
  EID EMPLOYEE.EMP_ID%TYPE;      -- EID 라는 변수에 EMPLOYEE테이블의 EMP_ID 컬럼의 타입 참조
  ENAME EMPLOYEE.EMP_NAME%TYPE;  -- ENAME 라는 변수에 EMPLOYEE테이블의 EMP_NAME 컬럼의 타입 참조
  SAL EMPLOYEE.SALARY%TYPE;  -- SAL 라는 변수에 EMPLOYEE테이블의 SALARY 컬럼의 타입 참조
BEGIN
    -- EMPLOYEE 테이블에서 입력받은 사번에 대한 사우너 정보를 조회 (사번, 이름, 급여)
    
    SELECT EMP_ID, EMP_NAME, SALARY 
      INTO EID, ENAME, SAL
      FROM EMPLOYEE
    WHERE EMP_ID = &사번; -- 사번을 입력받아 해당 사번에의 사원 정보를 조회
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SAL);

END;
/


-------* QUIZ * ------
/*
    * 레퍼런스 타입 변수로 EID, ENAME , JCODE, SAL, DTITLE을 선언하고
    각 자료형을 EMPLOYEE 테이블의 EMP_ID, EMP_NAME, JOB_CODE, SALARY 컬럼과
            DEPARTMENT 테이블의 DEPT_TITLE 컬럼을 참조하도록 한 뒤
        사용자가 입력한 사번의 사원 정보를 조회하여 변수에 담아 출력
        
     => 출력 형식 : {사번}, {이름} ,{직급코드} ,{급여} ,{부서명}

*/
  
  
DECLARE
  EID EMPLOYEE.EMP_ID%TYPE;      
  ENAME EMPLOYEE.EMP_NAME%TYPE;  
  JOB_CODE EMPLOYEE.JOB_CODE%TYPE;  
  SAL EMPLOYEE.SALARY%TYPE;  
  DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;  
  
BEGIN
    -- EMPLOYEE 테이블에서 입력받은 사번에 대한 사우너 정보를 조회 (사번, 이름, 급여)
    
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY , DEPT_TITLE
      INTO EID, ENAME, JOB_CODE, SAL, DEPT_TITLE
      FROM EMPLOYEE
       JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = &사번; -- 사번을 입력받아 해당 사번에의 사원 정보를 조회
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DEPT_TITLE : ' || DEPT_TITLE);

END;
/


---------------------------------------------------------------------------

/*
    * ROW 타입 변수 *
     : 테이블의 한 행에 대한 모든 컬럼값을 한번에 담을 수 있는 변수
     
     [표현법]
            변수명 테이블명%ROWTYPE;
*/
  
-- E 라는 변수에 EMPLOYEE 테이블의 ROW 타입 변수 선언

DECLARE 
    E EMPLOYEE%ROWTYPE;

BEGIN
   SELECT * 
     INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    -- 사원명, 급여, 보너스를 출력
    DBMS_OUTPUT.PUT_LINE('사원명 : '|| E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '|| E.SALARY);
    -- DBMS_OUTPUT.PUT_LINE('보너스 : '|| E.BONUS);
    --> NULL 값을 다른 값으로 표시하고 싶을 경우 : NVL 함수 사용 가능!
    DBMS_OUTPUT.PUT_LINE('보너스 : '|| TO_CHAR(NVL(E.BONUS,0), '0.0'));
    
END;
/
  

---------------------------------------------------------------------------  

/*
    * 실행부 (BEGIN)
    
    ** 조건문 **
       - 단일 IF 문 : IF 조건식 THEN 실행내용 END IF;
       - IF/ELSE 문 : IF 조건식 THEN 조건에 만족할 떄 실행내용
                      ELSE 조건을 만족하지 않을때 실행 내용 END IF;
    
       - IF/ELSEIF 문 : IF 조건식1 THEN 조건식1을 만족할시 실행내용
                        ELSEIF 조건식2 THEN 조건식2을 만족할시 실행내용
                        ......
                        [ELSE 모든 조건을 만족하지 않을시 실행내용]
                        END IF
                        
        - CASE/WHEN/THEN 문
            CASE 비교대상 WHEN 비교값1 THEN 결과값 1  -- 비교대상과 비교값1이 값을 경우 결과값 1
                         WHEN 비교값2 THEN 결과값 2 -- 비교대상과 비교값2이 값을 경우 결과값 2 
                         ....
                         ELSE 결과값N  -- 비교값들이 비교대상과 모두 다른 경우 결과값 N
            END;
*/
/*
    사용자에게 사번을 입력받아 해당 사원의 사번, 이름, 급여, 보너스 정보를 조회하여 출력
   * 각 데이터에 대한 변수 : 사번(EID), 이름(ENAME), 급여(SAL), 보너스(BONUS)
    단, 보너스 값이 0(NULL)인 사원의 경우 "보너스를 받지 않는 사원입니다" 출력
*/


DECLARE 
   
   EID EMPLOYEE.EMP_ID%TYPE;
   ENAME EMPLOYEE.EMP_NAME%TYPE;
   SAL EMPLOYEE.SALARY%TYPE;
   BONUS EMPLOYEE.BONUS%TYPE;
   
BEGIN

     SELECT EMP_ID, EMP_NAME, SALARY, 
                NVL(BONUS,0)
        INTO EID, ENAME, SAL, BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = &사번;


        DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
        DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
        DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);

     IF BONUS = 0 
        THEN  DBMS_OUTPUT.PUT_LINE('보너스를 받지 않는 사원입니다.');
     ELSE
        DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS);
     END IF;

END;
/
  
  
-----------------------------------------------------------------------------  
/*
   사용자로부터 사번을 입력받아 사원 정보를 조회하여 화면에 표시 (사번, 이름, 부서명, 국가명)
    --> 국가명 : 'KO' 인 경우 "국내팀" 표시, 그렇지 않은 경우 "해외팀" 표시
    
    * 레퍼런스 타입 변수 : 사번, 이름, 부서명, 국가코드
    * 일반 타입 변수    : 팀 정보를 저장. 문자타입. 
    
    *** 화면에 표시 ***
    사번: XX
    이름: XXX
    부서: XXX
    소속: 국내팀 또는 해외팀
*/

DECLARE

    EID  EMPLOYEE.EMP_ID%TYPE;
    ENAME  EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    N_CODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(10);

BEGIN
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
            INTO EID, ENAME, DTITLE, N_CODE
        FROM EMPLOYEE
           JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
           JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
        WHERE EMP_ID = &사번;
         
        IF N_CODE = 'KO' 
            THEN TEAM := '국내팀';
        ELSE 
            TEAM := '해외팀';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
        DBMS_OUTPUT.PUT_LINE('ENAME : '|| ENAME);
        DBMS_OUTPUT.PUT_LINE('DEPT_TITLE : '|| DTITLE);
        DBMS_OUTPUT.PUT_LINE('ENAME : '|| TEAM);
END;
/
  
  
  ---복습-------------------------------------------------------------------------
  /*
     
      점수(SCORE) : 사용자에게 입력받은 점수를 저장할 변수
      동금(GRADE) : 점수에 따라 등급 정보를 저장할 변수 ('A','B','C','D','F')
      
      사용자에게 점수를 입력받아
          90점 이상이면 'A'
          80점 이상이면 'B'
          70점 이상이면 'C'
          60점 이상이면 'D'
          그 아래면 'F'로 등급 부여
          
          ** 화면에 표시 **
          
          "점수는 XX이고, 등급은 X입니다."
          만약 F등급이라면 "재평가 대상입니다." 추가로 표시

  */
  

DECLARE
    
    SCORE NUMBER ;
    GRADE VARCHAR2(20);
    
BEGIN
      SCORE := &점수;
       IF SCORE >= 90
          THEN GRADE := 'A';
        ELSIF SCORE >= 80
          THEN GRADE := 'B';
        ELSIF SCORE >= 70
          THEN GRADE := 'C';
        ELSIF SCORE >= 60
          THEN GRADE := 'D';
        ELSE 
             GRADE := 'F';
        END IF;
         
       DBMS_OUTPUT.PUT_LINE('점수는 '||SCORE||'이고 '||'등급은 '||GRADE||'입니다.');
     
     IF GRADE = 'F'
         THEN DBMS_OUTPUT.PUT_LINE('재평가 대상입니다.');
     END IF;
END;
/
  
-----------------------------------------------------------------------------  

--* 사번을 입력받아 해당 사원의 부서코드를 기준으로 부서명을 출력 (* JOIN 사용 X)

DECLARE
   
    EMP EMPLOYEE%ROWTYPE;
    DTITLE VARCHAR2(20);
BEGIN
   -- 사번을 입력받아 해당 사원의 정보를 조회하여 변수에 대입
   
   SELECT *
       INTO EMP
     FROM EMPLOYEE 
    WHERE EMP_ID = &사번;
    
   -- 해당 사원의 부서코드 기준으로 부서명 정보를 DTITLE 변수에 저장 
   DTITLE := CASE EMP.DEPT_CODE
            WHEN 'D1' THEN '인사관리부'
            WHEN 'D2' THEN '회계관리부'
            WHEN 'D3' THEN '마케팅부'
            WHEN 'D4' THEN '국내영업부'
            WHEN 'D5' THEN '해외영업1부'
            WHEN 'D6' THEN '해외영업2부'
            WHEN 'D7' THEN '해외영업3부'
            WHEN 'D8' THEN '기술지원부'
            WHEN 'D9' THEN '총무부'
        END;
   
    -- XXX 사원의 소속부서는 XX입니다. 표시(출력)
    
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME ||' 사원의 소속부서는 '||DTITLE||'입니다.');


END;
/


-----------------------------------------------------------------------------
/*
   * 반복문 *

      - 기본 구문
          LOOP
              반복할 구문
              반목문을 종료할 구문
          END LOOP;
          
          * 반복문을 종료할 구문
           1) IF 조건식 
                THEN EXIT;
              END IF;
              
           2) EXIT WHEN 조건식;
           
           
      - FOR LOOP 문
          FOR 변수명 IN [REVERSE] 초기값...최종값
          LOOP
              반복할 구문
              [반복문ㅇ르 종료할 구문]
          END LOOP;
          
          * REVERSE : 최종값부터 초기값까지 반복
      
      - WHILE LOOP 문 
         
          WHILE 조건식
          LOOP
              반복할 구문
              [반복문을 종료할 구문]
          END LOOP;

*/

-- * 기본 구문을 사용하여 'HELLO ORACLE!' 5번을 출력
DECLARE
    
    N NUMBER := 1;
     
BEGIN
   
     LOOP 
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE!');
        N := N +1;
        
        IF N > 5
          THEN EXIT;
        END IF;
     
     END LOOP;
END;
/

-- * FOR LOOP문을 사용하여 HELLO ORACLE을 5번 출력
BEGIN
   FOR I IN 1..5
   LOOP
     DBMS_OUTPUT.PUT_LINE(I|| ') HELLO ORACLE');
    END LOOP;
END;
/
BEGIN
   FOR I IN REVERSE 1..5
   LOOP
     DBMS_OUTPUT.PUT_LINE(I|| ') HELLO ORACLE');
    END LOOP;
END;
/

-----------------------------------------------------------------------------

-- * TEST 테이블 삭제

DROP TABLE TEST;

-- * TEST 테이블을 생성 : TNO(PK), TDATE


CREATE TABLE TEST (
    TNK NUMBER PRIMARY KEY,
    TDATE DATE 

);


-- * SEQ_TNO 시퀀스 생성 - 증가값 2, 최대값 1000, 순환 X, 캐시메모리 X

CREATE SEQUENCE SEQ_TNO
INCREMENT BY 2
MAXVALUE 1000 
NOCYCLE NOCACHE;

-- * TEST 테이블에 데이터를 100개 추가. TDATE 값은 현재 날짜 정보로 추가.

SELECT SEQ_TNO.NEXTVAL FROM DUAL;
BEGIN
   FOR I IN 1..100
   LOOP
     INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/


SELECT COUNT(*) FROM TEST;


-----------------------------------------------------------------------------
/*
    * 예외처리부 (EXCEPTION)*
     -> 실행 중 발생하는 오류
     
     [표현법] 
     
          EXCEPTION
                WHEN 예외명 THEN 예외처리구문;
                WHEN 예외명 THEN 예외처리구문;
                ....
                WHEN OTHERS THEN 예외처리구문;
                
            * 오라클에서 미리 정의한 예외 => TLTMXPA DpDHL
               - NO_DATA_FOUND : 조회된 결과가 없을 떄
               - TOO_MANY_ROWS : 조회된 결과가 여러 행일 때 (=> 변수에 대입)
               - ZERO_DIVIDE : 0으로 값을 나누려고 할 때
               - DUP_VAL_ON_INDEX : UNIQUE 조건에 위배될 때 (중복이 있는 경우 )
               ......
           * OTHERS : 어떤 예외든 발생되었을 떄
*/

-- * 사용자에게 숫자를 입력받아 10을 나눈 결과를 출력

DECLARE
   NUM NUMBER;
BEGIN 
   NUM :=&숫자;
   
   DBMS_OUTPUT.PUT_LINE(10/NUM);
   
EXCEPTION 
    -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없음!');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없음!');
END;
/


-- EMPLOYEE 테이블에 EMP_ID 컬럼이 기본키로 설정  *

-- 사용자에게 사번을 입력받아 노옹철 사원의 사번을 변경 

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = &사번
    WHERE EMP_NAME = '노옹철';
    
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('중복된 사원번호입니다');
END;
/

-----------------------------------------------------------------------------
  