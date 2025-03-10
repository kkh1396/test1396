/*
    * DCL (Data Control Language) : ������ ���� ���
    
      => ������ �ý��� ����/��ü���� ������ �ο� (GRANT)�ϰų�
                                       ȸ�� (REVOKE)�ϴ� ����
                                    
            - �ý��� ����  : DB�� �����ϴ� ����, ��ü�� �����ϴ� ����
            - ��ü���� ���� : Ư�� ��ü���� ������ �� �ִ� ����
*/
/*
     * ���� ���� *
       CREATE USER ������ IDENTIFIED BY ��й�ȣ ;
       
       
     * ���� �ο� *
        GRANT ����(CONNECT, RESOURCE) TO ������;
        
        - �ý��� ���� ���� -
            + CREATE SESSION  : ���� ����
            + CREATE TABLE    : ���̺� ���� ����
            + CREATE VIEW     : �� ���� ����
            + CREATE SEQUENCE : ������ ���� ����
          
*/
-- SAMPLE/SAMPLE ���� ����   --> ������ �������� �����ؾ� ��!
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;

-- ���� ���� (CREATE SESSION) �ο�
GRANT CREATE SESSION TO C##SAMPLE;

-- ���̺� ���� ���� (CREATE TABLE) �ο�
GRANT CREATE TABLE TO C##SAMPLE;

-- ���̺� �����̽� �Ҵ� 
ALTER USER C##SAMPLE QUOTA 2M ON USERS;
--> 2M ������ ���̺� �����̽� ������ C##SAMPLE������ �Ҵ�

----------------------------------------------------------

/*
    * ��ü ���� ���� ���� *
    
    ����          |   ���� ��ü
    ===============================================
    SELECT       | TABLE, VIEW, SEQUENCE     -- ��ȸ
    SELECT       | TABLE, VIEW,              -- �߰�
    UPDATE       | TABLE, VIEW,              -- ����
    ===============================================


   GRANT �������� ON Ư����ü TO ������ 
   
   EX ) TEST ������ KH������ EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ���� �ο�
       GRANT SELECT ON KH.EMPLOYEE TO TEST;
       
       GRANT SELECT ON KH.EMPLOYEE TO C##TEST;
       
    * ���� ȸ�� *
    REVOKE ȸ���� ���� FROM ������;
    
    EX) TEST ������ �ο��ߴ� KH������ EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ������ ȸ��
       REVOKE SELECT ON KH.EMPLOYEE TO TEST;
*/

-- ===============================================
/*
   * ROLE(��, ��Ģ) : Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
      
         - CONNECT   : ���� ���� (CREATE SESSION)
         - RESOURCE  : �ڿ� ����, Ư�� ��ü ���� ����.
                       ( CREATE TABLE, CREATE SEQUENCE, ...)

*/

-- �� ���� ��ȸ
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('DBA');

---------------------------------------------------------------------------

/*
    * TCL (Transaction Control Language)
    
     - Ʈ����� : �����ͺ��̽��� ���� �������
                 �������� ������׵��� �ϳ��� ����ó�� Ʈ����ǿ� ��Ƶ�
                 DML�� �� ���� ������ �� Ʈ������� �����ϸ� �ش� Ʈ����ǿ� ��Ƽ� ���� ó��
                                        Ʈ������� �������� ������ Ʈ������� ���� ����
                                        
                 COMMIT ����ϱ� �������� ������׵��� �ϳ��� Ʈ��������� ��� ��
                 -> Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE (DML)
                 
 
      - Ʈ����� ����
        * COMMIT;   : ������� ����!. Ʈ����ǿ� ������ִ� ������׵��� ���� DB�� �����ϰڴٴ� �ǹ�!
        * ROLLBACK; : ������� ���!. Ʈ����ǿ� ����� �ִ� ������׵��� ����(���)�ϰ�,
                                    ������ COMMIT ��ġ(����)���� ���ư��� ���� �ǹ� 
        * SAVEPOINT TO ����Ʈ��; : ���� ������ ������׵��� �ӽ÷� �����صδ� ���� �ǹ�!
                                  ROLLBACK �� ��ü ���� ���׵��� ��� �������� �ʰ�,
                                  �ش� ��ġ������ ��Ұ� ���� (=> ROLLBACK ����Ʈ��;)

*/
-- ** KH �������� ���� ���� ** -

-- EMP01 ���̺��� ����
DROP TABLE EMP01;

-- EMP01 ���̺� ���� (=> EMPOLYEE���̺��� ���, �����, �μ���, ������ ����)

CREATE TABLE EMP01 
AS (

SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID

);


-- ����� 217,214�� ��� �����͸� ����
SELECT * FROM EMP01;
DELETE FROM EMP01 WHERE EMP_ID IN (217,214);

ROLLBACK;        -- ������� ���� (���� DB�� ����)
COMMIT;          -- ������ Ŀ�� �������� ���ư� (217, 214 ��� ������ ����)


---------------------------------------------------------------------------

-- ����� 208, 209, 210�� ��� ����
SELECT * FROM EMP01;
DELETE FROM EMP01 WHERE EMP_ID IN (208,209,210);

SAVEPOINT SP ; -- SP��� �̸��� �ӽ� ���� ����

-- ����� 500���� ��� �߰�
INSERT INTO EMP01 VALUES (500, '���ѱ�', '�λ������' );

-- ����� 211���� ��� ����
DELETE FROM EMP01 WHERE EMP_ID =211;

-- SP �������� �ѹ�
ROLLBACK TO SP;
COMMIT;             -- SP �������� ���ư��� COMMIT�� �߱� ������  
--                      DELETE 208, 209, 210 ������׸� DB�� ����

---------------------------------------------------------------------------
SELECT *FROM EMP01 ORDER BY EMP_ID;
-- 221�� ��� ����
DELETE FROM EMP01 WHERE EMP_ID = '221';


-- ���̺� ����( DDL )
CREATE TABLE TEST (
    TID NUMBER
);

ROLLBACK;
-- > DDL(CREATE, ALTER, DROP)�� ����ϰ� �Ǹ� ���� Ʈ����ǿ� ����� ������׵��� ������ �ݿ��� (COMMIT)
--          * DDL�� ����ϱ� ���� DML(INSERT, UPDATE, DELETE)�� �ۼ��� �������� �ִٸ�
--              Ȯ���ϰ� Ʈ����� ó��(COMMIT/ROLLBACK)�� �Ŀ� DDL�� ����ؾ� ��!