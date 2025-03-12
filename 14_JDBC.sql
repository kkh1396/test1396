
-- * JDBC �� ���� : C##JDBC /JDBC

-- ������ �������� ����
CREATE USER C##JDBC IDENTIFIED BY JDBC; -- * ���� ����
GRANT CONNECT, RESOURCE TO C##JDBC;     -- * ���� �ο�
ALTER USER C##JDBC QUOTA UNLIMITED ON USERS; -- ���̺� �����̽� ���� 

-----------------------------------------------------------------------------------------------

-- ������ JDBC�������� ����

-- ȸ�� ������ ������ ���̺� (MEMBER)

DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    MEMBERNO NUMBER PRIMARY KEY,                -- ȸ����ȣ
    MEMBERID VARCHAR2(20) NOT NULL UNIQUE,      -- ȸ�� ���̵�
    MEMBERPW VARCHAR2(20) NOT NULL,             -- ȸ�� ��й�ȣ
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')), -- ���� ('M' , 'F')
    AGE NUMBER,                                 -- ����
    EMAIL VARCHAR2(30) ,                        -- �̸���
    ADDRESS VARCHAR2(100),                      -- �ּ�
    PHONE VARCHAR2(13),                         -- ����ó (XXX-XXXX-XXXXSCOPE)
    HOBBY VARCHAR2(50),                         -- ���
    ENROLLDATE DATE DEFAULT SYSDATE NOT NULL    -- ������
);

-- ȸ�� ��ȣ�� ����� ������ ��ü ����
DROP SEQUENCE SEQ_MNO;
CREATE SEQUENCE SEQ_MNO
NOCACHE;

-- ���õ����� �߰� (2��)
INSERT INTO MEMBER VALUES (SEQ_MNO.NEXTVAL, 'ADMIN', '1234', 'M', 30, 'JDBC@KH.OR.KR'
                            , '����', '010-1234-5678', '�޽�', '2025/03/12');
                            
INSERT INTO MEMBER VALUES (SEQ_MNO.NEXTVAL, 'ADMIN2', '1234', 'F', 28, 'JDBC@KH.OR.KR'
                            , '����', '010-1234-5678', '�޽�', DEFAULT);

COMMIT;


-----------------------------------------------------------------------------------------------

-- �׽�Ʈ�� ���̺� (TEST)
DROP TABLE TEST;
CREATE TABLE TEST(
    TNO NUMBER,
    TNAME VARCHAR2(30),
    TDATE DATE
);

INSERT INTO TEST VALUES (1,'HKD',YSDATE);

COMMIT;

INSERT INTO MEMBER VALUES (SEQ_MNO.NEXTVAL
                        , 'ȸ�����̵�'
                        , 'ȸ����й�ȣ'
                        , '����'
                        , ����
                        , '�̸���'
                        , '�ּ�'
                        , '����ó'
                        , '���'
                        , SYSDATE 
                        );
                        
                        
                        
                        select * from test;
                        /*
                        INSERT INTO MEMBER "
		  		+ "   VALUES (SEQ_MNO.NEXTVAL"
		  		+ " , '" + m.getMemberId() + "'"
		  		+ " , '" + m.getMemberPw() + "'"
		  		+ ",  '" + m.getGender() +   "'"
		  		+ ",   " + m.getAge()
		  		+ ",  '" + m.getEmail() + "'"
		  		+ " , '" + m.getEmail() + "'"
		  		+ ",  '" + m.getPhone() + "'"
		  		+ ",  '" + m.getHobby() + "'"
		  		+ ", SYSDATE)"
                */
                
                SELECT * FROM MEMBER;
delete from test where tno = 3 ;
commit;