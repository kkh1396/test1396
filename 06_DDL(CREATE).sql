/*
   DDL : ������ ���� ���
   
   ����Ŭ���� �����ϴ� ��ü�� ���� ����� (CREATE)
                              �����ϰ� (ALTER)
                              ����     (DROP) �ϴ� ���
    => ���� �����Ͱ� �ƴ� ��Ģ/������ �����ϴ� ���
    
    * ����Ŭ������ ��ü(����) : ���̺�, ��, ������, �ε���, ��Ű��, Ʈ����
                            ���ν���, �Լ�, ���Ǿ�, �����, ....

*/


/*
    * CREATE : ��ü�� ���� �����ϴ� ���� 
    
        [���̺� ����]
      - ���̺� : ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                ��� �����͵��� ���̺��� ���� �����
    
      - ǥ����
           CREATE TABLE ���̺��  (
                �÷��� �ڷ���(ũ��),
                �÷��� �ڷ���,
                �÷��� �ڷ���,
                ....
           );
           
           * �ڷ���
              
               - ����  => �ݵ�� ũ�� ��������� ��!
                   + CHAR(����Ʈũ��)         : �������� (������ ������ �����͸� ���� ���)
                                                -> ������ ���̺��� ���� ������ ���� ����� ��� �������� ä���� ����
                                                �ִ� 2000����Ʈ���� ���� ����
                   + VARCHAR2(����Ʈũ��)     : �������� (�������� ���̰� ������ ���� ���� ���)
                                                ->����Ǵ� ������ ���̸�ŭ�� ������ ����
                                                �ִ� 4000����Ʈ���� ���� ����
                   
               - ���� : NUMBER
               - ��¥ : DATE
*/


/*
    -- ȸ�� ������ ������ ���̺� ����
    -- *���̺�� : MEMBER

*/

/*
   * �÷� ����
    - ȸ����ȣ      : ���� (NUMBER)
    - ȸ�����̵�    : ���� (VARCHAR2(20))
    - ȸ����й�ȣ   : ���� (VARCHAR2(20))
    - ȸ���̸�      : ���� (VARCHAR2(20))
    - ����         : ����, '��'/'��' (CHAR(3))          --> �ѱ��� 3BYTE
    - ����ó       : ����, '010-XXXX-XXXX' (CHAR(13))  --> ����,����, ��ȣ 1BYTE
    - �̸���      : ���� (VARCHAR2(50))
    - ������      : ��¥ (DATE)


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
   * �÷��� ���� �߰��ϱ�
   
      [ǥ����]
             COMMENT ON COLUMN ���̺��.�÷��� IS ' ����' ;
        
         => �߸��ۼ����� ��� �ٽ� �ۼ� �� ���� --> �������!
*/
 
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '������';

-- ���̺� �����ϱ� : DROP TABLE ���̺��;
DROP TABLE MEMBER;



-- ���̺� ������ �߰��ϱ� : INSERT INTO ���̺�� VALUES (��, ��, ��, ...)
INSERT INTO MEMBER VALUES(1, 'KH', 'KH', 'KKH', 'M', '010-XXXX-XXX5', 'KH@KH.COM', '20250307');

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(2, 'KH2', 'KH2', 'KKH2', 'F', NULL, NULL , '20250307');
INSERT INTO MEMBER VALUES('', '', '', '', '', NULL, NULL , '');

COMMIT;   --> ������� ����

---------------------------------------------------------------------------

/*
    * ���� ���� : ���ϴ� ������ ���� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
                 ������ ���Ἲ�� �����ϱ� ���� ����!
                
    - ���� ��� : �÷������椵�� / ���̺��� ���
    
    - ���� : NOT NULL, UNIQUE, CHECK, PARIMARY KEY, FOREIGN KEY

*/

--

/*
    * NOT NULL *
       : �ش� �÷��� �ݵ�� ���� �����Ͼ� �ϴ� ���
          => ���� NULL���� ����Ǹ� �ȵǴ� ���
          
    * ������ �߰�(����)/���� �� NULL���� ������� ����!
    * �÷� ���� ������θ� ���� ����!
*/

-- * NOT NULL ���� ������ �߰��� ȸ�� ���̺�
--   ���̺�� : MEMBER_NOTNULL
--   ��, ȸ����ȣ, ���̵�, ��й�ȣ, �̸��� ���� �����ʹ� NULL ���� ������� �ʴ´�.
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
-- ���� �������� ���� ȸ�����̵� ���� NULL�̶� ���� �߻� (�������ǿ� �����)


---------------------------------------------------------------------------
/*
    * UNIQUE *
     : �ش� �÷��� �ߺ��� ���� ���� ��� �����ϴ� ���� ����
     
     => ������ �߰�(����) / ���� �� ������ �ִ� ������ �� �� �ߺ��Ǵ� ���� ���� ��� ���� �߻�!

*/

-- * UNIQUE ���� ������ �߰��Ͽ� ���̺� ����
--   ���̺�� : MEMBER_UNIQUE

CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER NOT NULL ,
      MEM_ID VARCHAR2(20) NOT NULL UNIQUE ,   --  �÷��������. NOT NULL, UNIQUE ���� ����
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL ,
      GENDER CHAR(3),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
        
      -- , UNIQUE(MEM_ID)   -- ���̺� �������
);

select * from member_unique;

insert into member_unique
   values ( 1, 'kh', '1234' , 'kkh', 'f', '010-1234-5678', null, null);


insert into member_unique
   values ( 2, 'kh', '4321' , 'kkh', 'm', '010-9874-2222', null, null);
-- UNIQUE ���� ���ǿ� ����Ǿ� ������ �߰� ���� (���� �߻�)
--> ���� ���뿡 �������Ǹ����� �˷��� (  �α׷� �˾ƺ��� ����� )
--> ���� ���� ���� �� �������Ǹ��� �������� ������ �ý��ۿ��� �ڵ����� �������.

---------------------------------------------------------------------------

/*
     * �������Ǹ� �����ϱ� 
      [1] �÷� ���� ���
          
          CREATE TABLE ���̺�� (
              �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
              
          );
    
      [2] ���̺� ���� ���
          
          CREATE TABLE ���̺�� (
            
              �÷��� �ڷ��� ,
              �÷��� �ڷ��� ,
              �÷��� �ڷ���  ,
              
              [CONSTRAINT �������Ǹ�] �������� �÷��� 
          );
*/

-- MEMBER_UNIQUE ���̺� ����
DROP TABLE MEMBER_UNIQUE;


-- �������Ǹ��� �����Ͽ� �ٽ� ����
CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL ,
      MEM_ID VARCHAR2(20)CONSTRAINT MEMID_NT NOT NULL ,
      MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL ,
      MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL ,
      GENDER CHAR(3),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
        
      CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)   -- ���̺� �������
);

INSERT INTO MEMBER_UNIQUE 
     VALUES (1, 'qqqq', '1234', '�׽�Ʈ1', '��', '010-1234-1234', 'test1@test.com', sysdate);

INSERT INTO MEMBER_UNIQUE
     VALUES (2, 'test2', '1234', '�׽�Ʈ2', null, null, null, null);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE
     VALUES (3, 'qqqq', '2222', '�׽�Ʈ3', null, null, null, null);
--> ������ �������Ǹ��� Ȯ���� �� ����! (MEMID_UQ)

INSERT INTO MEMBER_UNIQUE
    VALUES (4, null, null, null, null, null, null, null);
    
INSERT INTO MEMBER_UNIQUE
     VALUES (3, 'test3', '1234', '�׽�Ʈ3', '��', null, null, null);

--------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�) *
      : �ش� �÷��� ������ �� �ִ� ���� ���� ������ ����
        ���ǿ� �����ϴ� ������ ������ �� ����
        => ������ ������ �����ϰ��� �� �� ���
*/

-- * CHECK ���� ������ �߰��� ���̺� ����
--  ���̺��: MEMBER_CHECK
--  ���� �÷��� '��' �Ǵ� '��' 

CREATE TABLE MEMBER_CHECK(
    MEM_NO NUMBER  NOT NULL ,
      MEM_ID VARCHAR2(20) NOT NULL ,
      MEM_PWD VARCHAR2(20)  NOT NULL ,
      MEM_NAME VARCHAR2(20)  NOT NULL ,
      GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
      PHONE CHAR(13),
      EMAIL VARCHAR2(50),
      ENROLLDATE DATE
        
      , UNIQUE(MEM_ID)
      --, CEHCK(GENDER IN ('��','��'))
);

SELECT * FROM MEMBER_CHECK;
INSERT INTO MEMBER_CHECK
   VALUES( 1, 'HONG22', '1234', 'ȫ�浿', '��', NULL,NULL,SYSDATE);
   
INSERT INTO MEMBER_CHECK
VALUES( 2, 'HONG22', '1234', '����', 'RRR', NULL,NULL,SYSDATE);
--> ���� �÷��� ����Ʈ ���� �°� �����͸� �߰� => üũ �������ǿ� �����! (�����߻�)
   
INSERT INTO MEMBER_CHECK
VALUES( 2, 'HONG22', '1234', 'ȫ�浿', '��', NULL,NULL,SYSDATE);



---------------------------------------------------------------------------
/*
   * PRIMARY KEY (�⺻Ű) *
      : ���̺��� �� ���� �ĺ��ϱ� ���� ���Ǵ� �÷��� �ο��ϴ� ��������
      
      EX) ȸ����ȣ, �й�, ��ǰ�ڵ�, �ֹ���ȣ, �����ȣ, ....
      
      - PRIMARY KEY => NOT NULL + UNIQUE
      - ���̺� �� ���� �Ѱ��� ���� ����
*/

-- * �⺻Ű ���������� �߰��Ͽ� ���̺� ����
--   ���̺�� ; MEMBER_PRI
--   ȸ����ȣ�� �⺻Ű�� ����

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
  VALUES (1, 'HONG123', 'QWER', 'ȫȫȫ', NULL, NULL,NULL ,SYSDATE);

INSERT INTO MEMBER_PRI
  VALUES (1, 'HONG33', 'QWER', 'ȫȫ', NULL, NULL,NULL ,SYSDATE);
--> �⺻Ű �÷�(ȸ����ȣ)�� �ߺ��� ���� ����Ƿ��� �ؼ� ���� �߻�! (=> UNIQUE �������ǿ� �����!)

INSERT INTO MEMBER_PRI
  VALUES (NULL, 'HONG33', 'QWER', 'ȫȫ', NULL, NULL,NULL ,SYSDATE);
--> �⺻Ű �÷�(ȸ����ȣ)�� NULL ���� �����Ϸ��� �ؼ� ���� �߻�! (=> NOT NULL �������ǿ� �����!)


INSERT INTO MEMBER_PRI
  VALUES (2, 'HONG33', 'QWER', 'ȫȫ', NULL, NULL,NULL ,SYSDATE);
  
SELECT * FROM MEMBER_PRI;
----------------------------------------------------------------------------
-- �� ���� �÷����� �⺻Ű�� �����Ͽ� ���̺� ����
-- ���̺�� : MEMBER_PRI2
-- ȸ����ȣ, ȸ�����̵� �⺻Ű�� ���� (=> ����Ű)

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
  --> ����Ű : �� ���� �÷��� ���ÿ� �ϳ��� �⺻Ű�� �����ϴ°�
  --> ȸ�� ��ȣ�� �����ϳ� ,ȸ�����̵� �ٸ��� ������ �����Ͱ� �߰���!
  
  -- � ȸ���� ��ǰ�� ��ٱ��Ͽ� ��� ������ �����ϴ� ���̺�
  -- ȸ����ȣ, ��ǰ��, ���峯¥ 

CREATE TABLE MEMBER_LIEK (
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(50),
    LIKE_DATE DATE,
    
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);
SELECT * FROM MEMBER_LIEK;

INSERT INTO MEMBER_LIEK
   VALUES (1, '���ű�', '25/03/01');
INSERT INTO MEMBER_LIEK
   VALUES (1, 'Ű����', '25/03/03');
  
INSERT INTO MEMBER_LIEK
   VALUES (2, '���ű�', '25/03/01');

SELECT * FROM MEMBER_LIEK;   

SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2
   JOIN MEMBER_LIEK USING (MEM_NO);
--> ������ ����!
   
---------------------------------------------------------------------------
/*
    * FOREIGN KEY (�ܷ�Ű) *
     : �ٸ� ���̺��� �����ϴ� ���� �����ϰ��� �� �� ���Ǵ� ��������
      -> �ٸ� ���̺��� �����Ѵٰ� ǥ��
      -> �ַ� �ܷ�Ű�� ���ؼ� ���̺� ���� ���踦 ����
      
      - �÷����� ���
          �÷��� �ڷ��� REFERENCES ���������̺�� [(�������÷���)]
          
 
          
     - ���̺������
     
         FOREIGN KEY (�÷���) REFERENCES ���������̺�� [(�������÷���)]
        
      => �������÷��� ���� �� �����ϴ� ���̺��� �⺻Ű �÷��� ��Ī��!
*/
-- * ȸ�� ��� ������ ������ ���̺� ����
--   ���̺�� : MEMBER_GRADE
--   ��޹�ȣ(PK), ��޸�(NOT NULL)

CREATE TABLE MEMBER_GRADE (
      GRADE_NO NUMBER PRIMARY KEY,
      GREAD_NAME VARCHAR2(20)
);

SELECT * FROM MEMBER_GRADE;

INSERT INTO MEMBER_GRADE VALUES(100, '�Ϲ�');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIP');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIP');
  
  -- MEMBER ���̺� ����
  -- MEMBER ���̺� ���� : ȸ����ȣ, ���̵�, ��й�ȣ, �̸�, ����, ������, ��޹�ȣ
  
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   
      MEM_NO NUMBER PRIMARY KEY ,
      MEM_ID VARCHAR2(20)NOT NULL UNIQUE ,
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL  ,
      GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
      ENROLLDATE DATE ,
       -- �÷� ���� ���
      GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) 
      
      -- ���̺� ���� ���
      --FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE (GRADE_NO)
);
  
INSERT INTO MEMBER 
       VALUES (1, 'SS', '1234', 'KKH', '��', SYSDATE, 100);

INSERT INTO MEMBER 
       VALUES (2, 'SSFF', '1234', 'KKH', '��', SYSDATE, 200);

INSERT INTO MEMBER 
       VALUES (3, 'SSMM', '1234', 'KKH', '��', SYSDATE, NULL);
--> �ܷ�Ű�� ������ �÷����� �⺻������ NULL���� ���� ����

INSERT INTO MEMBER 
       VALUES (7, 'SS25', '1234', 'KKH2', '��', SYSDATE, 600);
--> ���� �߻�!! "�θ�Ű�� �����ϴ�."" --> ȸ����� ���̺� ������� ���� ���� ���!

-- MEMBER_GRADE (�θ����̺�) -|-------------<- MEMBER (�ڽ����̺�)
--      1:N . 1 (�θ����̺�), N (�ڽ����̺�)

INSERT INTO MEMBER 
       VALUES (5, 'SS343123', '1234', 'KKH4', '��', SYSDATE, 300);

SELECT * FROM MEMBER;


--> �θ����̺�(MEMBER_GRADE)���� "�Ϲ�ȸ��" ����� �����Ѵٸ�?
--> * ������ ���� ; DELETE FROM ���̺� WHERE ����;
--  ȸ�� ��� ���̺��� ��޹�ȣ�� 100�� ������ ���� 

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> �ڽ����̺�(MEMBER)���� 100�̶�� ���� ����ϱ� ������ ���� �Ұ�!

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 300;
--> �ڽ����̺�(MEMBER)���� 300�̶�� ���� ������� �ʾұ� ������ ���� ����!

-- * �ڽ����̺��� �̹� ����ϰ� �ִ� ���� ���� ���
--     �θ����̺�κ��� ������ ������ ���� �ʴ� "�����ɼ�"�� ����!

ROLLBACK;   --- ��������� ����ϴ� ��

SELECT * FROM  MEMBER_GRADE;

---------------------------------------------------------------------------

/*
    * �ܷ�Ű �������� - ���� �ɼ�
     : �θ����̺��� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ����̺��� ����
       ��� �� �������� ���� �ɼ� 
       
     - ON DELETE RESTRICTED (�⺻��) : �ڽ� ���̺�κ��� ������� ���� ���� ��� 
                                      �θ� ���̺��� �����͸� ���� �Ұ�
     - ON DELETE SET NULL : �θ� ���̺� �ִ� ������ ���� �� 
                            �ش� �����͸� ����ϰ� �ִ� �ڽ����̺� ���� NULL�� ����
     - ON DELETE CASCADE : �θ� ���̺� �ִ� ������ ���� �� 
                           �ش� �����͸� ����ϰ� �ִ� �ڽ����̺� ���� ����
                           
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   
      MEM_NO NUMBER PRIMARY KEY ,
      MEM_ID VARCHAR2(20)NOT NULL UNIQUE ,
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL  ,
      GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
      ENROLLDATE DATE ,
      GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL 
);
  
INSERT INTO MEMBER 
       VALUES (1, 'SS', '1234', 'KKH', '��', SYSDATE, 100);

INSERT INTO MEMBER 
       VALUES (2, 'SSFF', '1234', 'KKH', '��', SYSDATE, 200);

INSERT INTO MEMBER 
       VALUES (3, 'SSMM', '1234', 'KKH', '��', SYSDATE, NULL);

SELECT * FROM MEMBER;

-- ȸ����� ���� �� 100���� ���� ��� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
-- > ���� �ɼǿ� ���� �ڽ����̺�(MEMBER)���� 100���� ���������� NULL�� ����

SELECT * FROM MEMBER_GRADE;


DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   
      MEM_NO NUMBER PRIMARY KEY ,
      MEM_ID VARCHAR2(20)NOT NULL UNIQUE ,
      MEM_PWD VARCHAR2(20) NOT NULL ,
      MEM_NAME VARCHAR2(20) NOT NULL  ,
      GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
      ENROLLDATE DATE ,
      GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
);
  
INSERT INTO MEMBER 
       VALUES (1, 'SS', '1234', 'KKH', '��', SYSDATE, 100);

INSERT INTO MEMBER 
       VALUES (2, 'SSFF', '1234', 'KKH', '��', SYSDATE, 200);

INSERT INTO MEMBER 
       VALUES (3, 'SSMM', '1234', 'KKH', '��', SYSDATE, NULL);

SELECT * FROM MEMBER;


-- ȸ����� ���� �� 100���� ���� ��� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> ���� �ɼǿ� ���� �ڽ����̺�(MEMBER)���� 100���� ����ϰ� �ִ� �����Ͱ� ������!

SELECT * FROM MEMBER_GRADE;

---------------------------------------------------------------------------

/*
    * �⺻�� (DEFAULT)
      : ���������� �ƴ�!
       �÷��� �������� �ʰ� ������ �߰� �� NULL���� �߰��Ǵµ�, 
       �̶�, NULL���� �ƴ� �ٸ� ������ �����ϰ��� �� ��
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
     MEM_NO NUMBER PRIMARY KEY,
     MEM_NAME VARCHAR2(20) NOT NULL,
     AGE NUMBER ,
     HOBBY VARCHAR2(30) DEFAULT '����',
     ENROLLDATE DATE
);

SELECT * FROM MEMBER;

INSERT INTO MEMBER 
    VALUES (1, 'KK', 20, '���ǰ���', SYSDATE );
INSERT INTO MEMBER 
    VALUES (2, 'KK', 20, '���ǰ���', NULL);
INSERT INTO MEMBER 
    VALUES (3, 'KK', 20, NULL, NULL);


INSERT INTO MEMBER (MEM_NO, MEM_NAME)
     VALUES(4, 'KK');
--> �������� ���� �÷��� ���� ���� �⺻������ NULL ����
--  ��, �ش� �÷��� �⺻���� �����Ǿ� ���� ��� NULL���� �ƴ� �⺻������ �����

---------------------------------------------------------------------------
-- * ���̺� ����
/*
    CREATE TABLE ���̺��
    AS ��������;

*/
-- MEMBER ���̺� ����
CREATE TABLE MEMBER_COPY AS (SELECT * FROM MEMBER);
SELECT * FROM MEMBER_COPY;
---------------------------------------------------------------------------
/*
    * ���̺��� ��������� �����ϰ��� �� �� => ALTER TABLE
         ALTER TABLE ���̺�� ������ ����
        
        - NOT NULL: MODIFY �÷��� NOT NULL;
        
        - UNIQUE : ADD UNIQUE(�÷���);
        - CHECK  : ADD CHECK(���ǽ�);
        - PRIMARY KEY : ADD PRIMARY KEY (�÷���);
        - FOREIGN KEY : ADD FOREIGN KEY (�÷���)
        - FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ���������̺�� [(�������÷���)];
        
        - DEFAULT �ɼ� : MODIFY �÷��� DEFAULT �⺻��;
*/


