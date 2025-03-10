/*
   GROUP BY��
   : �׷� ������ ������ �� �ִ� ����
   : ���� ���� ������ �ϳ��� �׷����� ��� ó���ϴ� �������� ��� 
*/

-- ��ü ��� �� �޿� ��ȸ
SELECT SUM(SALARY) FROM EMPLOYEE;

-- �μ��� �� �޿� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)   -- 3
FROM EMPLOYEE                   -- 1
GROUP BY DEPT_CODE;             -- 2

-- �μ��� ��� �� ��ȸ
SELECT DEPT_CODE,COUNT(*)   -- 3
FROM EMPLOYEE               -- 1
GROUP BY DEPT_CODE;         -- 2


-- �μ��ڵ尡 'D1', 'D6', 'D8'�� �� �μ��� �޿� ����, ��� �� ��ȸ
SELECT DEPT_CODE, SUM(SALARY), COUNT(*)        -- 4
FROM EMPLOYEE                                  --1
WHERE DEPT_CODE IN ('D1','D6','D8')            -- 2
GROUP BY DEPT_CODE                             -- 3
ORDER BY DEPT_CODE;                            -- 5 


-- �� ���޺� �� �����, ���ʽ��� �޴� �����, �޿� ��, ��� �޿�, �����޿�, �ְ� �޿� ��ȸ
-- (��, ���� �ڵ� �������� ����)

SELECT JOB_CODE �����ڵ� ,COUNT(*) �����, 
COUNT(BONUS) "���ʽ� �޴� ����� ", SUM(SALARY) �޿���, AVG(SALARY) ��ձ޿�, 
MIN(SALARY) �����޿�, MAX(SALARY) �ְ�޿�
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;


-- ���� �����, ���� ����� ��ȸ --> �ֹι�ȣ �÷�!
SELECT DECODE(SUBSTR(EMP_NO, 8, 1),'1','��','2','��' ) ����, COUNT(*) "�����"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);


-- �μ� �� ���޺� �����, �޿� ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE,COUNT(*)"�����", SUM(SALARY) "�ѱ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE   -- �μ��ڵ� �������� �׷�ȭ�ϰ�, �׷� ������ �����ڵ� �������� ���α׷�ȭ ��!
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, JOB_CODE, COUNT(*)"�����", SUM(SALARY) "�ѱ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;

-------------------------------------------------------------------------
/*
   * HAVING ��
     : �׷쿡 ���� ������ ������ �� ����ϴ� ����
*/
-- �μ��� ��� �޿� ��ȸ (*�ݿø�ó��)
SELECT DEPT_CODE, ROUND( AVG(SALARY) )
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY)) "��ձ޿�"   -- 4
FROM EMPLOYEE                                   -- 1
WHERE SALARY >= 3000000                         -- 2 => ����� �޿��� 300���� �̻�
GROUP BY DEPT_CODE;                             -- 3


SELECT DEPT_CODE, ROUND(AVG(SALARY)) "��ձ޿�"  -- 4
FROM EMPLOYEE                                  -- 1
GROUP BY DEPT_CODE                             -- 2
HAVING AVG(SALARY) >= 3000000;                 -- 3

-- �μ��� ���ʽ��� �޴� ����� ���� �μ��� �μ��ڵ� ��ȸ

SELECT DEPT_CODE 
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0 ;

SELECT DEPT_CODE , BONUS FROM EMPLOYEE WHERE DEPT_CODE = 'D2';

--============================================================================

/*

    * ROLLUP, CUBE : �׷� �� ���� ��� ���� ���� ��� �Լ�
    
    - ROLLUP : ���޹��� �׷� �� ���� ���� ������ �׷� ���� �߰��� ���� ��� ��ȯ
    - CUBE   : ���޹��� �׷��� ������ ��� ���� �� ���� ��� ��ȯ 
    
*/

-- �� �μ� �� �μ��� ���޺� �޿���, �μ� �� �޿���, ��ü �����޿� ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
--GROUP BY DEPT_CODE, JOB_CODE
--GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;


/*
    *���� ����*

    SELECT ��ȸ�ϰ��� �ϴ� �÷� AS "��Ī" �Ǵ� * �Ǵ� �Լ��� �Ǵ� �����                -- 5
    FROM ��ȸ�ϰ��� �ϴ�_���̺� �Ǵ� DAUL                                           -- 1
    WHERE ���ǽ� (�����ڵ��� Ȱ���Ͽ� �ۼ�)                                          -- 2
    GROUP BY �׷�ȭ�����̵Ǵ� �÷� �Ǵ� �Լ���                                       -- 3
    HAVING ���ǽ� (�׷��Լ��� Ȱ���Ͽ� �ۼ�)                                         --4
    ORDER BY �÷� �Ǵ� ��Ī �Ǵ� �÷����� [ASC | DESC] [NULLS LAST | NULLS FIRST]   --6
    
    -----
    * ����Ŭ������ ����(��ġ) 1���� ����!!
    
*/


/*
     * ���� ������ : ���� ���� ��ɹ�(SQL��/������)�� �ϳ��� ��ɹ����� ������ִ� ������
     
     - UNION : ������ (�� ��ɹ��� ������ ������� ������) --> OR�� ����
     - INTERSECT : ������ (�� ��ɹ��� ������ ������� �ߺ��� �κ��� ��������) --> AND�� ����
     - UNION ALL : ������ + ������ (�ߺ��Ǵ� �κ��� �ι� ��ȸ�� �� ����)
     - MINUS : ������ (���� ������� ���� ����� �A ������)

*/

-- * UNION **
-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300������ �ʰ��ϴ� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >= 3000000;
--12 ��

-- �μ��ڵ尡 D5�� ����� ���, �̸� , �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
--> 6��

-- �μ��ڵ尡 D5�� ����� ���, �̸� , �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;
--> 8��

-- UNION �����ڷ� 2���� ������ ��ġ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;
-- > 12�� WHERE���� ������ ���� ��µ�

-- ** INTERSECT **
-- �μ��ڵ尡 D5�� ����� ���, �̸� , �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY >= 3000000;
--> 2�� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;
-- -> 2�� ��ȸ �����ϰ� ��ȸ


-- ** UNION ALL **


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'         --> 6
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;      --> 8

--> 14 : UNION(12) + INTERSECT(2)

---------------------------------------------

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'         --> 6
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;      --> 8


/*
   * ���� ������ ��� �� ���ǻ��� *
   
   1) ��ɹ����� �÷� ������ �����ؾ� ��
   2) �÷� �ڸ����� ������ ������Ÿ������ �ۼ��ؾ� ��
   3) ������ �ϰ��� �� ��� ORDER BY���� ��ġ�� �������� �ۼ��ؾ� ��
*/



SELECT * FROM EMPLOYEE;


