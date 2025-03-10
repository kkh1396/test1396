/*
   * JOIN
    : �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� ����
      ��ȸ ����� �ϳ��� �����(REULST SET)�� ����

    => ������ �����ͺ��̽������� �ּ����� �����͸� ������ ���̺� ����
      --> �ߺ� ������ �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� ������
      
    => ������ �����ͺ��̽����� �������� ����Ͽ� ���̺� ���� "����"�� �δ� ���
      (�� ���̺� ���� �����(�ܷ�Ű)�� ���ؼ� �����͸� ��Ī���� ��ȸ��!)
      
      JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����"
      
          ����Ŭ ���� ����             |             ANSI ����
    =====================================================================
            � ����                |          ���� ����
         ( EQUAL JOIN )            |          ( INNER JOIN ) --> JOIN ON/USING
         -----------------------------------------------------------------
            ���� ����                |          ���� �ܺ� ���� (LEFT OUTER JOIN)
           (LEFT JOIN)             |          ������ �ܺ� ���� (RIGHT OUTER JOIN)
           (RIGHT JOIN)            |          ��ü �ܺ� ���� (FULL OUTER JOIN)
        -----------------------------------------------------------------
            ��ü ���� (SELF JOIN)   |                 JOIN ON
        �� ���� (NON EQUAL JOIN) |        
    =====================================================================    
        
*/
SELECT * FROM EMPLOYEE;
-- ��ü ������� ���, �����, �μ��ڵ� ��ȸ

SELECT EMP_ID,EMP_NAME, DEPT_CODE
FROM EMPLOYEE;


-- �μ� �������� �μ��ڵ�, �μ��� ��ȸ

SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- ���� �������� ���� �ڵ�, ���޸� ��ȸ
SELECT * FROM JOB;


---------------------------------------------------------
/*
   * � ���� (EQUAL JOIN) ���� ����(INNER JOIN)
   
   : �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ (=> ��ġ���� �ʴ� ���� ������� ����)
   
*/

-- * ����Ŭ ���� ���� *
/*
   - FROM ���� ��ȸ�ϰ��� �ϴ� ���̺��� ���� ( �޸�(,)�� ����)
   - WHERE ���� ��Ī��ų �÷��� ���� ������ �ۼ�
*/

-- ����� ���, �̸�, �μ����� ��ȸ
-- => �μ��ڵ� �÷����� ���� ! ( EMPOYEE: DEPT_CODE, DEPARTMENT: DEPT_ID )

SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_TITLE �μ���
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE  = DEPT_ID;
--> ��ġ���� �ʴ� ������ ������� ���ܵ�!
--          EMPOUYEE ���̺����� DEPT_CODE ���� NULL�� ���
--          DEPARTMENT ���̺����� EMPLOYEE ���̺� �������� �ʴ� ������ (D3, D4, D7)
--           >>> �� ���̺����� �����ϴ� �����͵��� ���ܰ� ��!!


-- ����� ���, �̸�, ���޸��� ��ȸ
-- => �����ڵ� �÷����� ����! (EMPOLYEE: JOB_CODE JOB: JOB_CODE )

SELECT EMP_NO ���, EMP_NAME �̸�, JOB_NAME ���޸�, J.JOB_CODE
--FROM  EMPOYLEE , JOB
FROM  EMPLOYEE E, JOB J
--WHERE EMPOLYEE.JOB_CODE = JOB.JOB_CODE 
WHERE E.JOB_CODE = J.JOB_CODE ;


-- * ANSI ���� * --
/*
     - FROM���� ������ �Ǵ� ���̺��� �ϳ� �ۼ�
     - JOIN���� �����ϰ��� �ϴ� ���̺��� ��� + ��Ī��Ű���� �ϴ� ������ �ۼ�
        * JOIN ON : �÷����� ���ų� �ٸ� ���
             FROM ���̺�1
                 JOIN ���̺�2 ON (���ǽ�)
                 
        * JOIN USING : �÷����� ���� ���
                FROM ���̺�1
                  JOIN ���̺�2 USING(�÷���)
*/

-- ���, �����, �μ��� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ���, �����, ���޸� ��ȸ

SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�
FROM EMPLOYEE JOIN JOB USING (JOB_CODE) ;

SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�
FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE ;



-- �븮 ������ ����� ���, �����, ���޸�, �޿� ��ȸ
-- **����Ŭ ���� **
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
        AND JOB_NAME = '�븮';

-- ** ANSI ���� **
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    WHERE JOB_NAME = '�븮';

-------------------------------------------------------------------------------
-- [1] �μ��� �λ�������� ������� ���, �����, ���ʽ� ��ȸ
-- ** ����Ŭ ���� **
SELECT * FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE  DEPT_CODE = DEPT_ID AND
        DEPT_TITLE = '�λ������'
ORDER BY EMP_ID;

-- ** ANSI ���� **

SELECT EMP_ID, EMP_NAME, NVL(BONUS,0)
FROM EMPLOYEE 
     JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '�λ������';

-- [2] �μ��� ���� ������ �����Ͽ�, ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
--      ** ����:LOCATION
SELECT * FROM EMPLOYEE;
-- ** ����Ŭ ���� **

    SELECT  D.dept_id, d.dept_title, d.location_id, l.local_name 
    FROM  department D , location L
    WHERE d.location_id = l.local_code;
    

-- ** ANSI ���� **

    SELECT  D.dept_id, d.dept_title, d.location_id, l.local_name 
    FROM  department D 
             JOIN location L ON d.location_id = l.local_code;


-- [3] ���ʽ��� �޴� ����� ���, �����, ���ʽ�, �μ��� ��ȸ
SELECT * FROM EMPLOYEE;
-- ** ����Ŭ ���� **
      SELECT  EMP_ID, EMP_NAME, BONUS, dept_title
      FROM EMPLOYEE E , DEPARTMENT D
      WHERE e.dept_code = d.dept_id 
          AND BONUS IS NOT NULL;

-- ** ANSI ���� **

       SELECT  EMP_ID, EMP_NAME, BONUS, dept_title
       FROM EMPLOYEE E 
                JOIN DEPARTMENT D ON e.dept_code = d.dept_id AND BONUS IS NOT NULL;

-- [4] �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

-- ** ����Ŭ ���� **

      SELECT EMP_NAME, DEPT_ID, SALARY 
      FROM EMPLOYEE E,  DEPARTMENT D
      WHERE E.DEPT_CODE = d.dept_id
            AND d.dept_TITLE != '�ѹ���';
      
-- ** ANSI ���� **
    SELECT EMP_NAME, DEPT_ID, SALARY 
      FROM EMPLOYEE E
            JOIN DEPARTMENT D ON d.dept_TITLE != '�ѹ���'
            WHERE E.DEPT_CODE = d.dept_id;

--------------------------------------------------------------------------------
/*
   ���� ���� / �ܺ� ���� ( OUTER JOIN )
    : �� ���̺� ���� JOIN �� ��ġ���� �ʴ� �൵ �����Ͽ� ��ȸ�ϴ� ����
      ��, �ݵ�� LEFT/RIGHT �����ؾ� �� (������ �Ǵ� ���̺�)
      
      * LEFT JOIN : �� ���̺� �� ���ʿ� �ۼ��� ���̺��� �������� ����
      * RIGHT JOIN : �� ���̺� �� �����ʿ� �ۼ��� ���̺��� �������� ����
      
      
      * FULL JOIN : �� ���̺��� ���� ��� ���� ��ȸ�ϴ� ���� (* ����Ŭ ���� X)
*/

-- ��� ����� �����, �μ���, �޿�, ���� ��ȸ

-- * LEFT JOIN *
-- ** ����Ŭ ���� **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- ** ANSI ���� **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- * RIGHT JOIN **
-- ** ����Ŭ ���� **

SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- ** ANSI ���� **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE
     RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


-- * FULL JOIN * -- ANSI �������� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE
     FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


--------------------------------------------------------------------------------

/*
    �� ���� (NON EQUAL JOIN)
    : ��Ī ��ų �÷��� ���� ���� �ۼ� �� '='�� ������� �ʴ� ����. ���� ������ ���� ����.
    
    * ANSI ���������� JOIN ON �� ��� ���� *
*/

-- ����� ���� �����, �޿�, �޿���� ��ȸ
-- ���: EMPLOYEE, �޿����: SAL_GRADE

-- * ����Ŭ ���� *
SELECT EMP_NAME, SALARY, SAL_LEVEL �޿����
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- * ANSI ���� *  --> JOIN ON�� ��밡��!
SELECT EMP_NAME, SALARY, SAL_LEVEL �޿����
FROM EMPLOYEE
    JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

--------------------------------------------------------------------------------

/*
   ��ü ���� (SELF JOIN)
   : ���� �ٸ� ���̺��� �ƴ� ���� ���̺��� �����ϴ� ����
*/

-- ��ü ����� ���, �����, �μ��ڵ�,
--           ������, ��� �����, ��� �μ��ڵ� ��ȸ
-- ��� (EMPLOYEE), ���(EMPLOYEE) --> ���̺��� ���� ������ ���� �̸��� �÷����� ���� => ��Ī ���!
SELECT * FROM EMPLOYEE;


SELECT E.EMP_ID ���, E.EMP_NAME �����, E.DEPT_CODE �μ��ڵ�
    , M.EMP_ID ������, M.EMP_NAME ����̸�, M.DEPT_CODE "��� �μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID ;        -- � ����� �������� ����� ����� �������� ����!

-- ** ANSI ���� **
SELECT E.EMP_ID ���, E.EMP_NAME �����, E.DEPT_CODE �μ��ڵ�
    , M.EMP_ID ������, M.EMP_NAME ����̸�, M.DEPT_CODE "��� �μ��ڵ�"
FROM EMPLOYEE E JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
        -- LEFT JOIN EMPLOYEE E ON E.MANAGER_ID = M.EMP_ID;;
           --> ����� ���� ������� ������ ��ȸ�ϰ��� �� ��!
--------------------------------------------------------------------------------

/*
    ���� ����
     : 2�� �̻��� ���̺��� �����ϴ� ��
*/

-- ���, �����, �μ���, ���޸� ��ȸ
-- ��� (EMPLOYEE), �μ� (DEMPARTMENT), ����(JOB)

-- **����Ŭ ���� ���� **
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ����
FROM EMPLOYEE E, DEPARTMENT, JOB J 
WHERE DEPT_CODE = DEPT_ID        -- EMPLOYEE ���̺�� DEPARTMENT ���̺��� ����!
   AND E.JOB_CODE = J.JOB_CODE;
   
-- ** ANSI ���� **
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ����
FROM EMPLOYEE
  JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
  JOIN JOB USING (JOB_CODE);
  
-- ���, �����, �μ���, ������ ��ȸ
-- ���(EMPLOYEE), �μ�(DEPARTMENT) �� ����(LOCATION)

-- ** ����Ŭ ���� ���� **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
         AND LOCATION_ID = LOCAL_CODE;
         

-- ** ANSI ���� **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
   JOIN department ON DEPT_CODE = DEPT_ID
   JOIN LOCATION ON  LOCATION_ID = LOCAL_CODE;
   
   
--------------------------------------------------------------------------------

--[1] ���, �����, �μ���, ������, ������ ��ȸ
-- * ���� (NATIONAL)

-- ** ����Ŭ ���� **
  SELECT EMP_NO, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
  FROM EMPLOYEE, DEPARTMENT,LOCATION L , NATIONAL N
  WHERE DEPT_CODE = DEPT_ID AND
        LOCATION_ID = LOCAL_CODE AND
        L.NATIONAL_CODE = N.NATIONAL_CODE;
        
  

-- ** ANSI ���� **

    SELECT EMP_NO, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
    FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
        JOIN NATIONAL USING (NATIONAL_CODE);


--[2] ���, �����, �μ���, ���޸�, ������, ������, �޿���� ��ȸ

-- ** ����Ŭ ���� **

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME ,NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT, JOB J, LOCATION L, NATIONAL N, SAL_GRADE
WHERE DEPT_CODE = DEPT_ID   
  AND E.JOB_CODE = J.JOB_CODE
  AND LOCATION_ID = LOCAL_CODE
  AND L.NATIONAL_CODE = N.NATIONAL_CODE
  AND SALARY BETWEEN MIN_SAL AND MAX_SAL
ORDER BY EMP_ID;


-- ** ANSI ���� **

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME ,NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
      JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
      JOIN JOB USING (JOB_CODE)
      JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
      JOIN NATIONAL USING (NATIONAL_CODE)
      JOIN SAL_GRADE ON  SALARY BETWEEN MIN_SAL AND MAX_SAL 
ORDER BY EMP_ID;                                                                                      









