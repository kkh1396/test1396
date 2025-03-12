/*
   DDL : 데이터 정의 언어
   
   오라클에서 제공하는 객체를 새로 만들고 (CREATE)
                              변경하고 (ALTER)
                              삭제     (DROP) 하는 언어
    => 실제 데이터가 아닌 규칙/구조를 정의하는 언어
    
    * 오라클에서의 객체(구조) : 테이블, 뷰, 시퀸스, 인덱스, 패키지, 트리거
                            프로시저, 함수, 동의어, 사용자, ....

*/


/*
    * CREATE : 객체를 새로 생성하는 구문 
    
        [테이블 생성]
      - 테이블 : 행과 열로 구성되는 가장 기본적인 데이터베이스 객체
                모든 데이터들을 테이블을 통해 저장됨
    
      - 표현법
           CREATE TABLE 테이블명  (
                컬럼명 자료형(크기),
                컬럼명 자료형,
                컬럼명 자료형,
                ....
           );
           
           * 자료형
              
               - 문자  => 반드시 크기 지정해줘야 함!
                   + CHAR(바이트크기)         : 고정길이 (고정된 길이의 데이터를 담을 경우)
                                                -> 지정한 길이보다 작은 길이의 값이 저장될 경우 공백으로 채워서 저장
                                                최대 2000바이트까지 지정 가능
                   + VARCHAR2(바이트크기)     : 가변길이 (데이터의 길이가 정해져 있지 않은 경우)
                                                ->저장되는 데이터 길이만큼만 공간이 사용됨
                                                최대 4000바이트까지 지정 가능
                   
               - 숫자 : NUMBER
               - 날짜 : DATE
*/


/*
    -- 회원 정보를 저장할 테이블 생성
    -- *테이블명 : MEMBER

*/

/*
   * 컬럼 정보
    - 회원번호      : 숫자 (NUMBER)
    - 회원아이디    : 문자 (VARCHAR2(20))
    - 회원비밀번호   : 문자 (VARCHAR2(20))
    - 회원이름      : 문자 (VARCHAR2(20))
    - 성별         : 문자, '남'/'여' (CHAR(3))          --> 한글은 3BYTE
    - 연락처       : 문자, '010-XXXX-XXXX' (CHAR(13))  --> 영문,숫자, 기호 1BYTE
    - 이메일      : 문자 (VARCHAR2(50))
    - 가입일      : 날짜 (DATE)


*/


CREATE TABLE MEMBER (
      MEM_NO NUMBER,
      MEM_ID VARCHAR2(20),
      MEM_PWD VARCHAR2(20),
      MEM_NAME VARCHAR2(20),
      GENDER CHAR(3),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
    
);

SELECT * FROM MEMBER;
---------------------------------------------------------------------------
/*
   * 컬럼에 설명 추가하기
   
      [표현법]
             COMMENT ON COLUMN 테이블명.컬럼명 IS ' 설명' ;
        
         => 잘못작성했을 경우 다시 작성 후 실행 --> 덮어씌워짐!
*/
 
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '가입일';

-- 테이블 삭제하기 : DROP TABLE 테이블명;
DROP TABLE MEMBER;



-- 테이블에 데이터 추가하기 : INSERT INTO 테이블명 VALUES (값, 값, 값, ...)
INSERT INTO MEMBER VALUES(1, 'KH', 'KH', 'KKH', 'M', '010-XXXX-XXX5', 'KH@KH.COM', '20250307');

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(2, 'KH2', 'KH2', 'KKH2', 'F', NULL, NULL , '20250307');
INSERT INTO MEMBER VALUES('', '', '', '', '', NULL, NULL , '');

COMMIT;   --> 변경사항 적용

---------------------------------------------------------------------------

/*
    * 제약 조건 : 원하는 데이터 값만 유지하기 위해서 특정 컬럼에 설정하는 제약
                 데이터 무결성을 보장하기 위한 목적!
                
    - 설정 방식 : 컬럼레벨방ㅅ힉 / 테이블레벨 방식
    
    - 종류 : NOT NULL, UNIQUE, CHECK, PARIMARY KEY, FOREIGN KEY

*/

--

/*
    * NOT NULL *
       : 해당 컬럼에 반드시 값이 존재하야 하는 경우
          => 절대 NULL값이 저장되면 안되는 경우
          
    * 데이터 추가(삽입)/수정 시 NULL값을 허용하지 않음!
    * 컬럼 레벨 방식으로만 설정 가능!
*/

-- * NOT NULL 제약 조건을 추가한 회원 테이블
--   테이블명 : MEMBER_NOTNULL
--   단, 회원번호, 아이디, 비밀번호, 이름에 대한 데이터는 NULL 값을 허용하지 않는다.
CREATE TABLE MEMBER_NOTNULL (
      MEM_NO NUMBER NOT NULL ,
      MEM_ID VARCHAR2(20) NOT NULL ,
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL ,
      GENDER CHAR(3),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
);

SELECT * FROM MEMBER_NOTNULL;
INSERT INTO MEMBER_NOTNULL VALUES(1, 'TEST', 'TEST', 'TEST', 'F', NULL, NULL , '');
INSERT INTO MEMBER_NOTNULL VALUES(2, 'TEST', 'TEST', 'TEST', NULL, NULL, NULL , '');
INSERT INTO MEMBER_NOTNULL VALUES(3, NULL, 'TEST', 'TEST', NULL, NULL, NULL , '');
-- 제약 조건으로 인해 회원아이디 값이 NULL이라서 오류 발생 (제약조건에 위배됨)


---------------------------------------------------------------------------
/*
    * UNIQUE *
     : 해당 컬럼에 중복된 값이 있을 경우 제한하는 제약 조건
     
     => 데이터 추가(삽입) / 수정 시 기존에 있는 데이터 값 중 중복되는 값이 있을 경우 오류 발생!

*/

-- * UNIQUE 제약 조건을 추가하여 테이블 생성
--   테이블명 : MEMBER_UNIQUE

CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER NOT NULL ,
      MEM_ID VARCHAR2(20) NOT NULL UNIQUE ,   --  컬럼레벨방식. NOT NULL, UNIQUE 제약 설정
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL ,
      GENDER CHAR(3),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
        
      -- , UNIQUE(MEM_ID)   -- 테이블 레벨방식
);

select * from member_unique;

insert into member_unique
   values ( 1, 'kh', '1234' , 'kkh', 'f', '010-1234-5678', null, null);


insert into member_unique
   values ( 2, 'kh', '4321' , 'kkh', 'm', '010-9874-2222', null, null);
-- UNIQUE 제약 조건에 위배되어 데이터 추가 실패 (오류 발생)
--> 오류 내용에 제약조건명으로 알려줌 (  로그로 알아보기 어려움 )
--> 제약 조건 설정 시 제약조건명을 지정하지 않으면 시스템에서 자동으로 만들어줌.

---------------------------------------------------------------------------

/*
     * 제약조건명 설정하기 
      [1] 컬럼 레벨 방식
          
          CREATE TABLE 테이블명 (
              컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건
              
          );
    
      [2] 테이블 레벨 방식
          
          CREATE TABLE 테이블명 (
            
              컬럼명 자료형 ,
              컬럼명 자료형 ,
              컬럼명 자료형  ,
              
              [CONSTRAINT 제약조건명] 제약조건 컬럼명 
          );
*/

-- MEMBER_UNIQUE 테이블 삭제
DROP TABLE MEMBER_UNIQUE;


-- 제약조건명을 설정하여 다시 생성
CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL ,
      MEM_ID VARCHAR2(20)CONSTRAINT MEMID_NT NOT NULL ,
      MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL ,
      MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL ,
      GENDER CHAR(3),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
        
      CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)   -- 테이블 레벨방식
);

INSERT INTO MEMBER_UNIQUE 
     VALUES (1, 'qqqq', '1234', '테스트1', '남', '010-1234-1234', 'test1@test.com', sysdate);

INSERT INTO MEMBER_UNIQUE
     VALUES (2, 'test2', '1234', '테스트2', null, null, null, null);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE
     VALUES (3, 'qqqq', '2222', '테스트3', null, null, null, null);
--> 설정한 제약조건명을 확인할 수 있음! (MEMID_UQ)

INSERT INTO MEMBER_UNIQUE
    VALUES (4, null, null, null, null, null, null, null);
    
INSERT INTO MEMBER_UNIQUE
     VALUES (3, 'test3', '1234', '테스트3', '담', null, null, null);

--------------------------------------------------------------------------------
/*
    * CHECK(조건식) *
      : 해당 컬럼에 저장할 수 있는 값에 대한 조건을 제시
        조건에 만족하는 값만을 저장할 수 있음
        => 정해진 값만을 저장하고자 할 때 사용
*/

-- * CHECK 제약 조건을 추가한 테이블 생성
--  테이블명: MEMBER_CHECK
--  성별 컬럼에 '남' 또는 '여' 

CREATE TABLE MEMBER_CHECK(
    MEM_NO NUMBER  NOT NULL ,
      MEM_ID VARCHAR2(20) NOT NULL ,
      MEM_PWD VARCHAR2(20)  NOT NULL ,
      MEM_NAME VARCHAR2(20)  NOT NULL ,
      GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
        
      , UNIQUE(MEM_ID)
      --, CEHCK(GENDER IN ('남','여'))
);

SELECT * FROM MEMBER_CHECK;
INSERT INTO MEMBER_CHECK
   VALUES( 1, 'HONG22', '1234', '홍길동', '남', NULL,NULL,SYSDATE);
   
INSERT INTO MEMBER_CHECK
VALUES( 2, 'HONG22', '1234', '강유', 'RRR', NULL,NULL,SYSDATE);
--> 성별 컬럼에 바이트 수에 맞게 데이터를 추가 => 체크 제약조건에 위배됨! (오류발생)
   
INSERT INTO MEMBER_CHECK
VALUES( 2, 'HONG22', '1234', '홍길동', '남', NULL,NULL,SYSDATE);



---------------------------------------------------------------------------
/*
   * PRIMARY KEY (기본키) *
      : 테이블에서 각 행을 식별하기 위해 사용되는 컬럼에 부여하는 제약조건
      
      EX) 회원번호, 학번, 제품코드, 주문번호, 예약번호, ....
      
      - PRIMARY KEY => NOT NULL + UNIQUE
      - 테이블 당 오직 한개만 설정 가능
*/

-- * 기본키 제약조건을 추가하여 테이블 생성
--   테이블명 ; MEMBER_PRI
--   회원번호에 기본키를 설정

CREATE TABLE MEMBER_PRI(
      MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY ,
      MEM_ID VARCHAR2(20) NOT NULL ,
      MEM_PWD VARCHAR2(20)  NOT NULL ,
      MEM_NAME VARCHAR2(20)  NOT NULL ,
      GENDER CHAR(3),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
        
      , UNIQUE(MEM_ID)
);

SELECT * FROM MEMBER_PRI;


INSERT INTO MEMBER_PRI
  VALUES (1, 'HONG123', 'QWER', '홍홍홍', NULL, NULL,NULL ,SYSDATE);

INSERT INTO MEMBER_PRI
  VALUES (1, 'HONG33', 'QWER', '홍홍', NULL, NULL,NULL ,SYSDATE);
--> 기본키 컬럼(회원번호)에 중복된 값이 저장되려고 해서 오류 발생! (=> UNIQUE 제약조건에 위배됨!)

INSERT INTO MEMBER_PRI
  VALUES (NULL, 'HONG33', 'QWER', '홍홍', NULL, NULL,NULL ,SYSDATE);
--> 기본키 컬럼(회원번호)에 NULL 값을 저장하려고 해서 오류 발생! (=> NOT NULL 제약조건에 위배됨!)


INSERT INTO MEMBER_PRI
  VALUES (2, 'HONG33', 'QWER', '홍홍', NULL, NULL,NULL ,SYSDATE);
  
SELECT * FROM MEMBER_PRI;
----------------------------------------------------------------------------
-- 두 개의 컬럼으로 기본키로 설정하여 테이블 생성
-- 테이블명 : MEMBER_PRI2
-- 회원번호, 회원아이디를 기본키로 설정 (=> 복합키)

CREATE TABLE MEMBER_PRI2(

      MEM_NO NUMBER  ,
      MEM_ID VARCHAR2(20) NOT NULL ,
      MEM_PWD VARCHAR2(20)  NOT NULL ,
      MEM_NAME VARCHAR2(20)  NOT NULL ,
      GENDER CHAR(3),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
        
      , UNIQUE(MEM_ID)
      , CONSTRAINT MEMPRI2_PK PRIMARY KEY (MEM_NO, MEM_ID)
);
SELECT * FROM MEMBER_PRI2;

INSERT INTO MEMBER_PRI2
   VALUES (1, 'HONG12' , '1234', 'HHH', NULL, NULL, NULL, SYSDATE);

INSERT INTO MEMBER_PRI2
   VALUES (1, 'KONG12' , '1234', 'HJ', NULL, NULL, NULL, SYSDATE);
  --> 복합키 : 두 개의 컬럼에 동시에 하나의 기본키로 지정하는것
  --> 회원 번호는 동일하나 ,회원아이디가 다르기 때문에 데이터가 추가됨!
  
  -- 어떤 회원이 제품을 장바구니에 담는 정보를 저장하는 테이블
  -- 회원번호, 제품명, 저장날짜 

CREATE TABLE MEMBER_LIEK (
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(50),
    LIKE_DATE DATE,
    
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);
SELECT * FROM MEMBER_LIEK;

INSERT INTO MEMBER_LIEK
   VALUES (1, '제거기', '25/03/01');
INSERT INTO MEMBER_LIEK
   VALUES (1, '키보드', '25/03/03');
  
INSERT INTO MEMBER_LIEK
   VALUES (2, '제거기', '25/03/01');

SELECT * FROM MEMBER_LIEK;   

SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2
   JOIN MEMBER_LIEK USING (MEM_NO);
--> 데이터 무시!
   
---------------------------------------------------------------------------
/*
    * FOREIGN KEY (외래키) *
     : 다른 테이블에서 존재하는 값을 저장하고자 할 때 사용되는 제약조건
      -> 다른 테이블을 참조한다고 표현
      -> 주로 외래키를 통해서 테이블 간의 관계를 형성
      
      - 컬럼레벨 방식
          컬럼명 자료형 REFERENCES 참조할테이블명 [(참조할컬럼명)]
          
 
          
     - 테이블레벨방식
     
         FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 [(참조할컬럼명)]
        
      => 참조할컬럼명 생략 시 참조하는 테이블의 기본키 컬럼이 매칭됨!
*/
-- * 회원 등급 정보를 저장할 테이블 생성
--   테이블명 : MEMBER_GRADE
--   등급번호(PK), 등급명(NOT NULL)

CREATE TABLE MEMBER_GRADE (
      GRADE_NO NUMBER PRIMARY KEY,
      GREAD_NAME VARCHAR2(20)
);

SELECT * FROM MEMBER_GRADE;

INSERT INTO MEMBER_GRADE VALUES(100, '일반');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIP');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIP');
  
  -- MEMBER 테이블 삭제
  -- MEMBER 테이블 생성 : 회원번호, 아이디, 비밀번호, 이름, 성별, 가입일, 등급번호
  
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   
      MEM_NO NUMBER PRIMARY KEY ,
      MEM_ID VARCHAR2(20)NOT NULL UNIQUE ,
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL  ,
      GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
      ENROLLDATE DATE ,
       -- 컬럼 레벨 방식
      GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) 
      
      -- 테이블 레벨 방식
      --FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE (GRADE_NO)
);
  
INSERT INTO MEMBER 
       VALUES (1, 'SS', '1234', 'KKH', '남', SYSDATE, 100);

INSERT INTO MEMBER 
       VALUES (2, 'SSFF', '1234', 'KKH', '여', SYSDATE, 200);

INSERT INTO MEMBER 
       VALUES (3, 'SSMM', '1234', 'KKH', '남', SYSDATE, NULL);
--> 외래키로 설정한 컬럼에는 기본적으로 NULL값은 저장 가능

INSERT INTO MEMBER 
       VALUES (7, 'SS25', '1234', 'KKH2', '남', SYSDATE, 600);
--> 오류 발생!! "부모키가 없습니다."" --> 회원등급 테이블에 저장되지 않은 값을 사용!

-- MEMBER_GRADE (부모테이블) -|-------------<- MEMBER (자식테이블)
--      1:N . 1 (부모테이블), N (자식테이블)

INSERT INTO MEMBER 
       VALUES (5, 'SS343123', '1234', 'KKH4', '남', SYSDATE, 300);

SELECT * FROM MEMBER;


--> 부모테이블(MEMBER_GRADE)에서 "일반회원" 등급을 삭제한다면?
--> * 데이터 삭제 ; DELETE FROM 테이블 WHERE 조건;
--  회원 등급 테이블에서 등급번호가 100인 데이터 삭제 

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> 자식테이블(MEMBER)에서 100이라는 값을 사용하기 때문에 삭제 불가!

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 300;
--> 자식테이블(MEMBER)에서 300이라는 값은 사용하지 않았기 때문에 삭제 가능!

-- * 자식테이블에서 이미 사용하고 있는 값이 있을 경우
--     부모테이블로부터 모조건 삭제가 되지 않는 "삭제옵션"이 있음!

ROLLBACK;   --- 변경사항을 취소하는 것

SELECT * FROM  MEMBER_GRADE;

---------------------------------------------------------------------------

/*
    * 외래키 제약조건 - 삭제 옵션
     : 부모테이블의 데이터 삭제 시 해당 데이터를 사요하고 있는 자식테이블의 값을
       어떻게 할 것인지에 대한 옵션 
       
     - ON DELETE RESTRICTED (기본값) : 자식 테이블로부터 사용중인 값이 있을 경우 
                                      부모 테이블에서 데이터를 삭제 불가
     - ON DELETE SET NULL : 부모 테이블에 있는 데이터 삭제 시 
                            해당 데이터를 사용하고 있는 자식테이블 값을 NULL로 변경
     - ON DELETE CASCADE : 부모 테이블에 있는 데이터 삭제 시 
                           해당 데이터를 사용하고 있는 자식테이블 값도 삭제
                           
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   
      MEM_NO NUMBER PRIMARY KEY ,
      MEM_ID VARCHAR2(20)NOT NULL UNIQUE ,
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL  ,
      GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
      ENROLLDATE DATE ,
      GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL 
);
  
INSERT INTO MEMBER 
       VALUES (1, 'SS', '1234', 'KKH', '남', SYSDATE, 100);

INSERT INTO MEMBER 
       VALUES (2, 'SSFF', '1234', 'KKH', '여', SYSDATE, 200);

INSERT INTO MEMBER 
       VALUES (3, 'SSMM', '1234', 'KKH', '남', SYSDATE, NULL);

SELECT * FROM MEMBER;

-- 회원등급 정보 중 100번에 대한 등급 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
-- > 삭제 옵션에 의해 자식테이블(MEMBER)에서 100번을 삭제했을시 NULL로 변경

SELECT * FROM MEMBER_GRADE;


DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   
      MEM_NO NUMBER PRIMARY KEY ,
      MEM_ID VARCHAR2(20)NOT NULL UNIQUE ,
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL  ,
      GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
      ENROLLDATE DATE ,
      GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
);
  
INSERT INTO MEMBER 
       VALUES (1, 'SS', '1234', 'KKH', '남', SYSDATE, 100);

INSERT INTO MEMBER 
       VALUES (2, 'SSFF', '1234', 'KKH', '여', SYSDATE, 200);

INSERT INTO MEMBER 
       VALUES (3, 'SSMM', '1234', 'KKH', '남', SYSDATE, NULL);

SELECT * FROM MEMBER;


-- 회원등급 정보 중 100번에 대한 등급 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> 삭제 옵션에 의해 자식테이블(MEMBER)에서 100번을 사용하고 있던 데이터가 삭제됨!

SELECT * FROM MEMBER_GRADE;

---------------------------------------------------------------------------

/*
    * 기본값 (DEFAULT)
      : 제약조건은 아님!
       컬럼을 제시하지 않고 데이터 추가 시 NULL값이 추가되는데, 
       이때, NULL값이 아닌 다른 값으로 저장하고자 할 때
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
     MEM_NO NUMBER PRIMARY KEY,
     MEM_NAME VARCHAR2(20) NOT NULL,
     AGE NUMBER ,
     HOBBY VARCHAR2(30) DEFAULT '없음',
     ENROLLDATE DATE
);

SELECT * FROM MEMBER;

INSERT INTO MEMBER 
    VALUES (1, 'KK', 20, '음악감상', SYSDATE );
INSERT INTO MEMBER 
    VALUES (2, 'KK', 20, '음악감상', NULL);
INSERT INTO MEMBER 
    VALUES (3, 'KK', 20, NULL, NULL);


INSERT INTO MEMBER (MEM_NO, MEM_NAME)
     VALUES(4, 'KK');
--> 지정하지 않은 컬럼에 대한 값은 기본적으로 NULL 저장
--  단, 해당 컬럼에 기본값이 설정되어 있을 경우 NULL값이 아닌 기본값으로 저장됨

---------------------------------------------------------------------------
-- * 테이블 복제
/*
    CREATE TABLE 테이블명
    AS 서브쿼리;

*/
-- MEMBER 테이블 복제
CREATE TABLE MEMBER_COPY AS (SELECT * FROM MEMBER);
SELECT * FROM MEMBER_COPY;
---------------------------------------------------------------------------
/*
    * 테이블의 변경사항을 적용하고자 할 때 => ALTER TABLE
         ALTER TABLE 테이블명 변경할 내용
        
        - NOT NULL: MODIFY 컬럼명 NOT NULL;
        
        - UNIQUE : ADD UNIQUE(컬럼명);
        - CHECK  : ADD CHECK(조건식);
        - PRIMARY KEY : ADD PRIMARY KEY (컬럼명);
        - FOREIGN KEY : ADD FOREIGN KEY (컬럼명)
        - FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 [(참조할컬럼명)];
        
        - DEFAULT 옵션 : MODIFY 컬럼명 DEFAULT 기본값;
*/


