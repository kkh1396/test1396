/*
    * �������� (SUBQUERY)
    : �ϳ��� ������ ���� ���Ե� �� �ٸ� ������
      ���� ������ �ϴ� �������� ���� ���� ������ �ϴ� ������
    
*/

-- "���ö" ����� ���� �μ��� ���� ��� ������ ��ȸ

-- 1) ���ö ����� �μ��ڵ� ��ȸ

SELECT * FROM EMPLOYEE;

SELECT * 
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';
--> D9

-- 2) �μ��ڵ尡 'D9'�� ��� ���� ��ȸ

SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';


-- ���� �� �������� �ϳ��� ���ĺ���!

SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');


-- ��ü ����� ��� �޿����� �� ���� �޿��� �޴� ����� ���� ��ȸ

SELECT * FROM EMPLOYEE
WHERE SALARY > (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);

SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE;


---------------------------------------------------------------------------

/*
    * ���� ���� ���� *
      ���������� ������ ������� �� �� �� ���� �����Ŀ� ���� �з�
      
    - ������ �������� : ���������� ����� ������ 1���� �� (1�� 1��)
    - ���߿� �������� : ���������� ����� �������� �� (N�� 1��)
    - ������ �������� : ���������� ����� �� ���̰� ���� ���� ��(�÷�)�� �� (1�� N��)
    
    
    >> ������ ���� �������� �տ� �ٴ� �����ڰ� �޶���!
*/

-- * ������ ��������
-- >> �Ϲ����� �񱳿����� ��� ���� : = != > < >= ..

-- �� ����� ��� �޿����� �� ���� �޿��� �޴� ������� �����, �����ڵ�, �޿��� ��ȸ

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);



-- �޿��� ���� ���� ����� �����, �����ڵ�, �޿��� ��ȸ

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);


-- ���ö ����� �޿����� ���� �޴� ����� �����, �μ��ڵ�, �޿� ��ȸ

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE
                 WHERE EMP_NAME = '���ö'   );



-- �� ���ǿ��� �μ��ڵ带 �μ������� ��ȸ�ϰ��� �Ѵٸ�?



-- * ����Ŭ ���� *

SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID
      AND SALARY > (SELECT SALARY FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö'   );
        


-- * ANSI ���� *
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
   JOIN department ON DEPT_CODE = DEPT_ID
        WHERE SALARY > (SELECT SALARY FROM EMPLOYEE
                            WHERE EMP_NAME = '���ö'   );
                            
-- �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿����� ��ȸ


SELECT * FROM EMPLOYEE;


SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                    GROUP BY DEPT_CODE);


-- ������ ����� ���� �μ��� ������� ���, �����, ����ó, �Ի���, �μ����� ��ȸ
-- (��, ������ ����� �����ϰ� ��ȸ!)


-- * ����Ŭ ���� *
SELECT * FROM EMPLOYEE;

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';


SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
      AND DEPT_CODE = (SELECT DEPT_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '������')
      AND  EMP_NAME <> '������';
      
      
-- * ANSI *

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE = (SELECT DEPT_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '������')
      AND  EMP_NAME <> '������';




---------------------------------------------------------------------------


/*

    ������ �������� : �������� ����� ���� ���� ��� (N�� 1��)
    
    IN (��������) : ���� ���� ����� �߿� �ϳ��� ��ġ�ϴ� ���� ���� ��� 
    
     > ANY (��������) : ���� ���� ����� �߿��� �ϳ��� ū ��찡 �ִٸ� ��ȸ
     < ANY (��������) : ���� ���� ���� �ϳ��� ���� ��찡 �ִٸ� ��ȸ
          * �񱳴�� > �����1 OR �񱳴�� > �����2 OR �񱳴��> �����...
          
     > ALL (��������) : ���� ���� ��� ��������� Ŭ ��� ��ȸ 
     < ALL (��������) : ���� ���� ��� ��������� ���� ��� ��ȸ
         * �񱳴�� < �����1 AND �񱳴�� < �����2 AND �񱳴�� < �����...
*/

-- ����� ��� �Ǵ� ������ ����� ���� ������ ������� ���� ��ȸ (���/�����/�����ڵ�/�޿�)
-- 1) ����� ��� �Ǵ� ������ ����� �����ڵ� ��ȸ 

SELECT JOB_CODE
FROM EMPLOYEE
-- WHERE EMP_NAME = '�����' OR EMP_NAME = '������';
WHERE EMP_NAME IN ('�����', '������');
-- > J3 J7

--2 �����ڵ尡 'J3' 'J7' �� ������� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3','J7');

-- > �������� �����ϱ�

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                        WHERE EMP_NAME IN ('�����', '������'));

-- �븮������ ����� �� ���� ������ �ּ� �޿����� ���� �޴� ��� ���� ��ȸ

SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;


-- 1) ���� ������ ����
SELECT * 
FROM EMPLOYEE E 
     JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME='����';
      
-- 2) ANY ������ ����Ͽ� ��

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (3760000, 2200000, 2500000)
      AND JOB_NAME = '�븮';


SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (
SELECT SALARY
FROM EMPLOYEE E, JOB J
    WHERE E.JOB_CODE = J.JOB_CODE
          AND JOB_NAME = '����'
        )
      AND JOB_NAME = '�븮';


---------------------------------------------------------------------------
/*
        ���߿� �������� : �������� ����� 1�� ���̰�, ���� ���� ��(�÷�)�� ���

*/
-- ������ ����� ���� �μ�, ���� ������ ��� ������ ��ȸ
-- 1) ������ ����� �μ��ڵ�, �����ڵ� ��ȸ

SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';


-- * ������ ���������� ��� *
SELECT * FROM  EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������');
    
-- * ���߿� ���������� ��� *
SELECT EMP_NAME, DEPT_CODE, JOB_CODE , SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE 
                                    FROM EMPLOYEE WHERE EMP_NAME = '������');
                                    
-- �ڳ��� ����� ������ ����, ����� ������ ����� �����, �����ڵ�, �����ȣ�� ��ȸ

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID 
                                 FROM EMPLOYEE WHERE EMP_NAME ='�ڳ���')
        AND EMP_NAME <> '�ڳ���';


---------------------------------------------------------------------------

/*
    * ������ ���߿� �������� : ���������� ����� ���� ��, ���� ��(�÷�)�� ���
*/
-- �� ���޺� �ּұ޿��� �޴� ��� ������ ��ȸ

SELECT * 
FROM EMPLOYEE 
WHERE (JOB_CODE ,SALARY) IN (SELECT JOB_CODE ,MIN(SALARY)
                                    FROM EMPLOYEE 
                                    GROUP BY JOB_CODE);



---------------------------------------------------------------------------


/*
    * �ζ��� �� : ���������� FROM���� ����ϴ°�
                 => ���������� ����� ��ġ ���̺�ó�� ����ϴ� ��
*/
-- ���, �̸�, ���ʽ� ���� ����, �μ��ڵ带 ��ȸ 
-- (��, ���ʽ� ���� ������ ����� NULL�� �ƴϰ�
--      ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ�� ��)


SELECT EMP_ID, EMP_NAME, (SALARY + ( SALARY * NVL(BONUS,0) ))*12 ���ʽ�����, DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + ( SALARY * NVL(BONUS,0)))*12 >= 30000000
ORDER BY 3 DESC;

--> ���� N���� ��ȸ : "TOP-N�м�"
--     => ROWNUM : ��ȸ�� �࿡ ���Ͽ� ������� 1���� ������ �ο����ִ� ���� �÷�
SELECT EMP_ID, EMP_NAME, ���ʽ�����, DEPT_CODE FROM
(
    SELECT EMP_ID, EMP_NAME, (SALARY + ( SALARY * NVL(BONUS,0) ))*12 ���ʽ�����, DEPT_CODE
    FROM EMPLOYEE
    WHERE (SALARY + ( SALARY * NVL(BONUS,0)))*12 >= 30000000
    ORDER BY 3 DESC
) 
WHERE ROWNUM <= 5;
--> ���ʽ� ���� ������ ���� 5���� ����� ��ȸ 

--> ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ
SELECT * 
FROM EMPLOYEE WHERE ROWNUM <=5
ORDER BY HIRE_DATE DESC;


---------------------------------------------------------------------------
/*
     * ������ �ű�� �Լ� (WINDOW FUNCTION)
     
     - RANK() OVER(���ı���)        : ������ ���� ���Ŀ� ����� ������ ����ŭ �ǳʶٰ� ���� ���
     - DENSE_RANK() OVER(���ı���)  : ������ ������ �ִ��� �� ���� ����� + �ؼ� ���
     
      => SELECT�� ������ ��� ����!

*/
-- �޿��� ���� ������� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY, 
      RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;
-- > ���� 19���� 2���� �ְ�, �� ���� ������ 21���� ǥ�õ�

SELECT EMP_NAME, SALARY, 
      DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;

-- * ���� 5�� ��ȸ 
SELECT EMP_NAME, SALARY, 
      RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE WHERE ROWNUM <= 5;


-- * ���� 3 ~ 5 �� ��ȸ

SELECT * FROM ( 
        SELECT EMP_NAME, SALARY, 
            RANK() OVER(ORDER BY SALARY DESC) "����"
                FROM EMPLOYEE WHERE ROWNUM <= 5

)
WHERE ���� BETWEEN 3 AND 5;



---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- 1) ROWNUM�� Ȱ���Ͽ� �޿��� ���� ���� 5���� ��ȸ�Ϸ� ������, ����� ��ȸ���� �ʾҴ�.

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE

ORDER BY SALARY DESC;


SELECT EMP_NAME, SALARY 
FROM (
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE 
    ORDER BY SALARY DESC
)
WHERE ROWNUM < 6;

-- ���� �Ѱ�
-- ������(����) :       �޿����� ������ ROWNUM <5 ��� ���ǿ��� ROWNUM�� ���� ������ ����
-- �ذ���(��ġ����) :  ���� ������ �ζ��κ�� ������ �� �ű⼭ 5�� �̳��� ROWNUM ������ �ش�

-- ����� �Ѱ�
-- ������(����) :       ���ĵǱ� ���� 5���� �߷�����. ROWNUM�� ���� ������ ���� ���� �ο���
-- �ذ���(��ġ����) :  





-- 2) �μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��� �ش��ϴ� �μ��ڵ�, �μ��� �� �޿���,
--           �μ��� ��ձ޿�, �μ��� ��� ���� ��ȸ�Ϸ� ������, ����� ��ȸ�� ���� �ʾҴ�.

SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���
        ,COUNT(*) �����
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


SELECT DEPT_CODE, FLOOR(AVG(SALARY) ), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���
        ,COUNT(*) �����
FROM EMPLOYEE
--WHERE SALARY > ANY (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE )
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

-- �Ǵ�

SELECT *
FROM (
    SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���
        ,COUNT(*) �����
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
WHERE ��� > 2700000;



-- ������(����) :      �μ��� ��ձ޿��� �ƴ� ��� �������� �޿��� �������� ���õǾ���. 
-- �ذ���(��ġ����)   



