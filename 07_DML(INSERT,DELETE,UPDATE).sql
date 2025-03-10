/*
    D : DATE, L : LANGGUAGE
    
    - DQL (QUERY, ������ ��ȸ) : SELECT (��ȸ)
    - DML (MANIPULATION, ������ ����) : INSERT(�߰�/����), UPDATE(����), DELETE(����)
    - DDL (DEFINITION, ������ ����) : CREATE(����), ALTER(����), DROP(����)
    - DCL (CONTROL, ������ ���� ) : GRANT, REVOKE
    - TCL (TRANSACTION CONTROL, Ʈ������ ����) : COMMIT, ROLLBACK 
*/

---------------------------------------------------------------------------
/*
   * DML (������ ���� ���)
     : ���̺� ������(��)�� �߰��ϰų� (INSERT), 
                          �����ϰų� (UPDATE),
                          ���� (DELETE)�ϱ� ���� ����ϴ� ���
*/

-- * INSERT : ���̺� ���ο� ���� �߰��ϴ� ����
/*
   [ ǥ���� ]
      
         (1) INSERT INTO ���̺�� VALUES (��, ��, ��, .....)
         
         -> ���̺��� ��� �÷��� ���� ���� ���� �����Ͽ� �� ���� �߰��ϰ��� �� �� ���
            �÷� ������ �°� VALUES�� ���� �����ؾ� �� (* �ش� �÷��� �´� ������ Ÿ������ �����ؾ���)
            
             * ���� �����ϰ� �������� ��� => NOT ENOUGH VALUE ���� �߻�!
             * ���� �� ���� �������� ��� => TOO MANY VALUES ���� �߻�!
*/

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE  VALUES(900, '������', '990307-200000', 'MY_U@KH.OR.KR', '010123456789',
                            'D4', 'J4', 3000000, 0.3, NULL, SYSDATE, NULL, 'N');

/*
     (2) INSERT INTO ���̺�� (�÷���1, �÷���2, �÷���2)
                  VALUES (��1, ��2, ��3);
          -> �÷��� ���� �����Ͽ� �ش� �÷��� ������ �߰�
          
        ���õ��� ���� �÷��� ���� ���� �⺻������ NULL���� ����ǰ�,
        NULL���� �ƴ� �ٸ� ������ �����ϰ��� �� �� �� �⺻�� �ɼ��� �����ϸ� �ȴ�.
        
        --> ���õ��� ���� �÷��� NOT NULL ���������� �ִٸ�, �ݵ�� ���� ���� �����ؾ� ��!
            �Ǵ� �⺻�� �ɼ��� �߰��ؾ� ��!
*/


-- EMPLOYEE ���̺� ���, �����, �ֹι�ȣ, �̸���, �����ڵ� �����͸� ������ ������� �߰�
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE)
            VALUES (901,'����Ŭ', '880707-250307', 'ORACLE@KH.COM', 'J7');
            
SELECT * FROM EMPLOYEE;


---------------------------------------------------------------------------
/*
    (3) INSERT INTO ���̺�� (��������);
    
     -> VALUES�� ���� ���� ����ϴ� ���
        ���������� ��ȸ�� ������� ��ä�� INSERT�ϴ� ��� (���� �� �߰��ϴ� ���)
*/
-- * EMP01 �̶�� ���̺� ���, �����, �μ����� ������ ���̺�

CREATE TABLE EMP01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)  
);

SELECT * FROM EMP01;

-- ��ü ����� ���, �����, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


-- ���� ������ ����� ������ EMP01 ���̺� ������ �߰�
INSERT INTO EMP01
 (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID);
    
SELECT * FROM EMP01;


---------------------------------------------------------------------------

/*
        (4) INSERT ALL
           : �ΰ� �̻��� ���̺� ���� �����͸� �߰��� ��
             ���Ǵ� ���������� ������ ��� ����ϴ� ���

        [ǥ����]
                
                INSERT ALL
                    INTO ���̺��1 VALUES (�÷���, �÷���, �÷���, ....)
                    INTO ���̺��2 VALUES (�÷���, �÷���, �÷���, ....)
                    ��������;
*/

-- * EMP_DEPT ���̺� : ���, �����, �μ��ڵ�, �Ի���

CREATE TABLE EMP_DEPT
AS (
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 1 = 0 --  1 = 0  => FALSE, �ǹ̾���! ������ ���� �÷� ������ �����ϱ� ���� ���
);

SELECT * FROM EMP_DEPT;

-- * EMP_MANAGER ���̺� : ���, �����, ������
CREATE TABLE EMP_MANAGER
AS (
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE 1 = 0
);
SELECT * FROM EMP_MANAGER;

-- �μ��ڵ尡 'D1'�� ����� ���, �����, �μ��ڵ�, ������, �Ի��� ���� ��ȸ

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
    * UPDATE : ���̺� ����Ǿ� �ִ� ������ ������ ���� �����ϴ� ���� 
    
     [ǥ����]
         
           UPDATE ���̺�� 
             SET �÷��� = �����Ұ�,
                 �÷��� = �����Ұ�, ....
            [WHERE ���ǽ�]
            
            -> SET ������ ���� ���� �÷� ���� ���ÿ� ���� ����. (, �� �����ؾ� ��)
            -> WHERE ���� �������� ��� ���̺��� ��� ���� �����Ͱ� �����. (*���� �ʿ�*)
        * �����͸� ������ ��(������Ʈ) ���������� �� Ȯ���ؾ� ��!!

*/

-- DEPT_TABLE �̶�� ���̺� DEPARTMENT���̺��� ����(* ������ ����)

SELECT * FROM DEPT_TABLE;

CREATE TABLE DEPT_TABLE
AS 
(
  SELECT * FROM DEPARTMENT
);

-- �μ��ڵ尡 'D1'�� �μ��� �μ����� '�λ���'���� ����
SELECT * FROM DEPT_TABLE;
UPDATE DEPT_TABLE 
    SET DEPT_TITLE = '�λ���'
    WHERE DEPT_ID = 'D1';

-- �μ��ڵ尡 'D9'�� �μ��� �μ����� '���� ��ȹ��'���� ����
SELECT * FROM DEPT_TABLE;
UPDATE DEPT_TABLE 
    SET DEPT_TITLE = '���� ��ȹ��'
    WHERE DEPT_ID = 'D9';


-- ��� ���̺��� EMP_TABLE ���̺�� ���� (���, �̸�, �μ��ڵ�, �޿�, ���ʽ� ������ ����)

DROP TABLE EMP_TABLE;
CREATE TABLE EMP_TABLE
AS
(
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE
);

SELECT * FROM EMP_TABLE;

-- ����� 900���� ����� �޿��� 400�������� �λ�(����)
SELECT * FROM EMP_TABLE WHERE EMP_ID = '900';
UPDATE EMP_TABLE 
     SET SALARY = 4000000
     WHERE EMP_ID = 900
     ;

-- ���ȥ ����� �޿��� 500����, ���ʽ��� 0.2�� ����

SELECT * FROM EMP_TABLE;

UPDATE EMP_TABLE 
    SET SALARY = 5000000,
        BONUS = 0.2
    WHERE EMP_NAME = '���ȥ';
SELECT * FROM EMP_TABLE WHERE EMP_NAME = '���ȥ';

-- ��ü ����� �޿��� ���� �޿����� 10���� �λ�!
SELECT * FROM EMP_TABLE;
UPDATE EMP_TABLE SET SALARY = SALARY * 1.1 ;

---------------------------------------------------------------------------

/*
    * UPDATE ���� �������� ���
      
    [ǥ����]
         UPDATE ���̺��
             SET �÷��� = ( �������� )
            [WHERE ���ǽ�]
*/

-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ� ���� �����ϰ� ����
   SELECT * FROM EMP_TABLE;
   
   -- ���������� ������Ʈ
      UPDATE EMP_TABLE 
        SET SALARY = (SELECT SALARY FROM EMP_TABLE WHERE EMP_NAME = '�����')
           , BONUS = (SELECT BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����')
        WHERE EMP_NAME = '����';
   
   -- ���������� ������Ʈ
   UPDATE EMP_TABLE 
        SET (SALARY,BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����')
        WHERE EMP_NAME = '����';
   
SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME IN ('�����','����');


-- ASIA �������� �ٹ����� ������� ���ʽ��� 0.3���� ���� 

-- [1] ASIA ���� ���� ��ȸ 

SELECT * FROM LOCATION WHERE LOCAL_NAME LIKE '%ASIA%' ;

-- [2] ASIA ������ �μ� ���� ��ȸ
SELECT *
FROM DEPARTMENT
  JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
WHERE LOCAL_NAME LIKE '%ASIA%';

-- [3] ASIA ������ �μ��� ���� ��� ���� ��ȸ (���) --> EMP_TABLE
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
   * DELETE : ���̺� ����Ǿ� �ִ� �����͸� ������ �� ����ϴ� ����
   
     [ǥ����] 
            DELETE FROM ���̺��
            [WHERE ���ǽ�];
            
             -> WHERE �� ���� �� ���̺��� ��� ������(��)�� ������!
*/

DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
ROLLBACK;                -- ������� ���. ������ Ŀ�� �������� ���ư� 

-- 901�� ����� �����͸� ���� 
DELETE  FROM EMPLOYEE WHERE EMP_ID = 901;


-- 900�� �����  �̸����� �����͸� ���� 
DELETE FROM EMPLOYEE WHERE EMP_NAME = '������';

SELECT * FROM EMPLOYEE;

COMMIT;

-- �μ� ���̺��� �μ��ڵ尡 D1�� �μ� ����
SELECT * FROM DEPARTMENT;
DELETE FROM DEPARTMENT WHERE DEPT_ID = 'D1';


-- > �ܷ�Ű�� �����Ǿ� �մ� ��� ������� �����Ͱ� ������ ���� �Ұ�!


/*
    * TRUNCATE : ���̺��� ��ü ���� ������ �� ���Ǵ� ����
                 DELETE ���� ����ӵ��� �� ����
                 ������ ���� ���� �Ұ�, ROLLBACK �Ұ� (�ǵ����� ����!)
                 
        [ǥ����]
               TRUNCATE TABLE ���̺� ��;
*/
