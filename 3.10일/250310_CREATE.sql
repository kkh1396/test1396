/*
��ĭ�� ������ �ܾ �ۼ��Ͻÿ�.
( DDL   ) :CREATE, ALTER, DROP

(  DML  ): INSERT,DELETE,UPDATE

( DQL   ): SELECT
*/

 CREATE USER C##TEST250305 IDENTIFIED BY TEST0305  ;
 ALTER USER C##TEST250305 IDENTIFIED BY TEST0305  ;

/*
-- ���� ����� ���� ���� �� �Ʒ� ������ �ۼ����ּ���.
-- ID/PW  :  TEST250305 / test0305
    
  
 
 �ּ����� ���� �ο� (CONNECT, RESOURCE)
    GRANT CONNECT, RESOURCE TO C##TEST0305;
 

-- �Ʒ� ������ �߰��ϱ� ���� ���̺��� �������ּ���.

CREATE TABLE BOOK (
     
    B_NO NUMBER PRIMARY KEY,
    B_NAME VARCHAR2(200)NOT NULL ,
    B_AUTHOR VARCHAR2(200) NOT NULL,
    B_DATE DATE ,
    ISBN NUMBER DISTINCT

);

INSERT INTO BOOK VALUES (1, '�ﱹ��,',����,14/02/14,9780394502946);

-- �� �÷��� ������ �߰����ּ���.


COMMENT ON COLUMN BOOK.B_NO IS '������ȣ';
COMMENT ON COLUMN BOOK.B_NAME IS '������';
COMMENT ON COLUMN BOOK.B_AUTHOR IS '�����';
COMMENT ON COLUMN BOOK.B_DATE IS '������';
COMMENT ON COLUMN BOOK.ISBN IS 'ISBN';

-- ���� �����͸� �߰��ϱ� ���� ���� �������� �ۼ����ּ���.
--  ex) ����: �ﱹ��, ����: ����, ������: 14/02/14, ISBN : 9780394502946
------------------------------------------------------------
*/
/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/

------------------------------------------------------------
CREATE TABLE BOOK (
     
    B_NO NUMBER PRIMARY KEY,
    B_NAME VARCHAR2(200)NOT NULL ,
    B_AUTHOR VARCHAR2(200) NOT NULL,
    B_DATE DATE ,
    ISBN NUMBER UNIQUE

);


COMMENT ON COLUMN BOOK.B_NO IS '������ȣ';
COMMENT ON COLUMN BOOK.B_NAME IS '������';
COMMENT ON COLUMN BOOK.B_AUTHOR IS '�����';
COMMENT ON COLUMN BOOK.B_DATE IS '������';
COMMENT ON COLUMN BOOK.ISBN IS 'ISBN';

INSERT INTO BOOK VALUES (1, '�ﱹ��,','����', '14/02/14', '9780394502946');
INSERT INTO BOOK VALUES (2, '�ﱹ��,','����', '14/02/14', '9780394502947');
SELECT * FROM BOOK;
DROP TABLE BOOK;