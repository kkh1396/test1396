/*
    D : DATE, L : LANGGUAGE
    
    - DQL (QUERY, 데이터 조회) : SELECT (조회)
    - DML (MANIPULATION, 데이터 조작) : INSERT(추가/삽입), UPDATE(수정), DELETE(삭제)
    - DDL (DEFINITION, 데이터 정의) : CREATE(생성), ALTER(변경), DROP(삭제)
    - DCL (CONTROL, 데이터 제어 ) : GRANT, REVOKE
    - TCL (TRANSACTION CONTROL, 트랜젝션 제어) : COMMIT, ROLLBACK 
*/

---------------------------------------------------------------------------
/*
   * DML (데이터 조작 언어)
     : 테이블에 데이터(값)을 추가하거나 (INSERT), 
                          수정하거나 (UPDATE),
                          삭제 (DELETE)하기 위해 사용하는 언어
*/

-- * INSERT : 테이블에 새로운 행을 추가하는 구문
/*
   [ 표현법 ]
      
         (1) INSERT INTO 테이블명 VALUES (값, 값, 값, .....)
         
         -> 테이블의 모든 컬럼에 대한 값을 직접 제시하여 한 행을 추가하고자 할 때 사용
            컬럼 순서에 맞게 VALUES에 값을 나열해야 함 (* 해당 컬럼에 맞는 데이터 타입으로 제시해야함)
            
             * 값을 부족하게 제시했을 경우 => NOT ENOUGH VALUE 오류 발생!
             * 값을 더 많이 제시했을 경우 => TOO MANY VALUES 오류 발생!
*/

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE  VALUES(900, '마이유', '990307-200000', 'MY_U@KH.OR.KR', '010123456789',
                            'D4', 'J4', 3000000, 0.3, NULL, SYSDATE, NULL, 'N');

/*
     (2) INSERT INTO 테이블명 (컬럼명1, 컬럼명2, 컬럼명2)
                  VALUES (값1, 값2, 값3);
          -> 컬럼을 직접 제시하여 해당 컬럼에 값만을 추가
          
        제시되지 않은 컬럼에 대한 값은 기본적으로 NULL값이 저장되고,
        NULL값이 아닌 다른 값으로 저장하고자 할 떄 는 기본값 옵션을 설정하면 된다.
        
        --> 제시되지 않은 컬럼에 NOT NULL 제약조건이 있다면, 반드시 값을 직접 제시해야 함!
            또는 기본값 옵션을 추가해야 함!
*/


-- EMPLOYEE 테이블에 사번, 사원명, 주민번호, 이메일, 직급코드 데이터만 가지고 사원정보 추가
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE)
            VALUES (901,'오라클', '880707-250307', 'ORACLE@KH.COM', 'J7');
            
SELECT * FROM EMPLOYEE;


---------------------------------------------------------------------------
/*
    (3) INSERT INTO 테이블명 (서브쿼리);
    
     -> VALUES로 값을 직접 명시하는 대신
        서브쿼리로 조회된 결과값을 통채로 INSERT하는 방법 (여러 행 추가하는 방식)
*/
-- * EMP01 이라는 테이블에 사번, 사원명, 부서명을 저장할 테이블

CREATE TABLE EMP01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)  
);

SELECT * FROM EMP01;

-- 전체 사원의 사번, 사원명, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


-- 위의 쿼리문 결과를 가지고 EMP01 테이블에 데이터 추가
INSERT INTO EMP01
 (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID);
    
SELECT * FROM EMP01;


---------------------------------------------------------------------------

/*
        (4) INSERT ALL
           : 두개 이상의 테이블에 각각 데이터를 추가할 때
             사용되는 서브쿼리가 동일한 경우 사용하는 방법

        [표현법]
                
                INSERT ALL
                    INTO 테이블명1 VALUES (컬럼명, 컬럼명, 컬럼명, ....)
                    INTO 테이블명2 VALUES (컬럼명, 컬럼명, 컬럼명, ....)
                    서브쿼리;
*/

-- * EMP_DEPT 테이블 : 사번, 사원명, 부서코드, 입사일

CREATE TABLE EMP_DEPT
AS (
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 1 = 0 --  1 = 0  => FALSE, 의미없음! 데이터 없이 컬럼 정보만 복제하기 위해 사용
);

SELECT * FROM EMP_DEPT;

-- * EMP_MANAGER 테이블 : 사번, 사원명, 사수사번
CREATE TABLE EMP_MANAGER
AS (
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE 1 = 0
);
SELECT * FROM EMP_MANAGER;

-- 부서코드가 'D1'인 사원의 사번, 사원명, 부서코드, 사수사번, 입사일 정보 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE= 'D1';


INSERT ALL 
   INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
   INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    (
        SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
        FROM EMPLOYEE
        WHERE DEPT_CODE= 'D1'
    );
    
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

---------------------------------------------------------------------------

/*
    * UPDATE : 테이블에 저장되어 있는 기존의 데이터 값을 변경하는 구문 
    
     [표현법]
         
           UPDATE 테이블명 
             SET 컬럼명 = 변경할값,
                 컬럼명 = 변경할값, ....
            [WHERE 조건식]
            
            -> SET 절에는 여러 개의 컬럼 값을 동시에 변경 가능. (, 로 나열해야 함)
            -> WHERE 절을 생략했을 경우 테이블의 모든 행의 데이터가 변경됨. (*주의 필요*)
        * 데이터를 수정할 때(업데이트) 제약조건을 잘 확인해야 함!!

*/

-- DEPT_TABLE 이라는 테이블에 DEPARTMENT테이블을 복제(* 데이터 포함)

SELECT * FROM DEPT_TABLE;

CREATE TABLE DEPT_TABLE
AS 
(
  SELECT * FROM DEPARTMENT
);

-- 부서코드가 'D1'인 부서의 부서명을 '인사팀'으로 변경
SELECT * FROM DEPT_TABLE;
UPDATE DEPT_TABLE 
    SET DEPT_TITLE = '인사팀'
    WHERE DEPT_ID = 'D1';

-- 부서코드가 'D9'인 부서의 부서명을 '전략 기획팀'으로 변경
SELECT * FROM DEPT_TABLE;
UPDATE DEPT_TABLE 
    SET DEPT_TITLE = '전략 기획팀'
    WHERE DEPT_ID = 'D9';


-- 사원 테이블을 EMP_TABLE 테이블로 복제 (사번, 이름, 부서코드, 급여, 보너스 정보만 복제)

DROP TABLE EMP_TABLE;
CREATE TABLE EMP_TABLE
AS
(
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE
);

SELECT * FROM EMP_TABLE;

-- 사번이 900번인 사원의 급여를 400만원으로 인상(변경)
SELECT * FROM EMP_TABLE WHERE EMP_ID = '900';
UPDATE EMP_TABLE 
     SET SALARY = 4000000
     WHERE EMP_ID = 900
     ;

-- 대북혼 사원의 급여를 500만원, 보너스르 0.2로 변경

SELECT * FROM EMP_TABLE;

UPDATE EMP_TABLE 
    SET SALARY = 5000000,
        BONUS = 0.2
    WHERE EMP_NAME = '대북혼';
SELECT * FROM EMP_TABLE WHERE EMP_NAME = '대북혼';

-- 전체 사원의 급여를 기존 급여에서 10프로 인상!
SELECT * FROM EMP_TABLE;
UPDATE EMP_TABLE SET SALARY = SALARY * 1.1 ;

---------------------------------------------------------------------------

/*
    * UPDATE 문에 서브쿼리 사용
      
    [표현법]
         UPDATE 테이블명
             SET 컬럼명 = ( 서브쿼리 )
            [WHERE 조건식]
*/

-- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스 값과 동일하게 변경
   SELECT * FROM EMP_TABLE;
   
   -- 단일행으로 업데이트
      UPDATE EMP_TABLE 
        SET SALARY = (SELECT SALARY FROM EMP_TABLE WHERE EMP_NAME = '유재식')
           , BONUS = (SELECT BONUS FROM EMP_TABLE WHERE EMP_NAME = '유재식')
        WHERE EMP_NAME = '방명수';
   
   -- 다중행으로 업데이트
   UPDATE EMP_TABLE 
        SET (SALARY,BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '유재식')
        WHERE EMP_NAME = '방명수';
   
SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME IN ('유재식','방명수');


-- ASIA 지역에서 근무중인 사원들의 보너스를 0.3으로 변경 

-- [1] ASIA 지역 정보 조회 

SELECT * FROM LOCATION WHERE LOCAL_NAME LIKE '%ASIA%' ;

-- [2] ASIA 지역의 부서 정보 조회
SELECT *
FROM DEPARTMENT
  JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
WHERE LOCAL_NAME LIKE '%ASIA%';

-- [3] ASIA 지역의 부서에 속한 사원 정보 조회 (사번) --> EMP_TABLE
SELECT EMP_ID
FROM EMP_TABLE 
   JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
   JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE '%ASIA%';


UPDATE EMP_TABLE 
     SET BONUS =  0.3
     WHERE EMP_ID IN (SELECT EMP_ID
FROM EMP_TABLE 
   JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
   JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE '%ASIA%');

COMMIT;

---------------------------------------------------------------------------

/*
   * DELETE : 테이블에 저장되어 있는 데이터를 삭제할 때 사용하는 구문
   
     [표현법] 
            DELETE FROM 테이블명
            [WHERE 조건식];
            
             -> WHERE 절 생략 시 테이블의 모든 데이터(행)를 삭제함!
*/

DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
ROLLBACK;                -- 변경사항 취소. 마지막 커밋 시점으로 돌아감 

-- 901번 사원의 데이터를 삭제 
DELETE  FROM EMPLOYEE WHERE EMP_ID = 901;


-- 900번 사원의  이름으로 데이터를 삭제 
DELETE FROM EMPLOYEE WHERE EMP_NAME = '마이유';

SELECT * FROM EMPLOYEE;

COMMIT;

-- 부서 테이블에서 부서코드가 D1인 부서 삭제
SELECT * FROM DEPARTMENT;
DELETE FROM DEPARTMENT WHERE DEPT_ID = 'D1';


-- > 외래키가 설정되어 잇는 경우 사용중인 데이터가 잇을때 삭제 불가!


/*
    * TRUNCATE : 테이블의 전체 행을 삭제할 때 사용되는 구문
                 DELETE 보다 수행속도가 더 빠름
                 별도의 조건 제시 불가, ROLLBACK 불가 (되돌리수 없음!)
                 
        [표현법]
               TRUNCATE TABLE 테이블 명;
*/
