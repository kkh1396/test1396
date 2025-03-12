
------------BASIC ----------------

-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. �� ��� ����� "�а� ��", "�迭"����
-- ǥ���Ͻÿ�

SELECT * FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME "�а� ��", CATEGORY "�迭"
FROM TB_DEPARTMENT;

-- �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �߷��Ѵ�.
SELECT * FROM TB_DEPARTMENT;

SELECT department_name|| '�� ������ ' || CAPACITY || '�� �Դϴ�.' "�а��� ����"
FROM TB_DEPARTMENT;

-- 3."������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û

SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_STUDENT;

SELECT STUDENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE s.department_no = d.department_no
      AND s.department_no = '001'
      AND SUBSTR(STUDENT_SSN,8,1) = '2'
      AND ABSENCE_YN = 'Y';
      



--4. ���������� ���� ���� ��� ������ ���� ã�� �Ƹ��� �Խ��ϰ��� �Ѵ� 

SELECT * FROM TB_STUDENT;

SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NO DESC;



-- 5. ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.


SELECT * FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME �а� , CATEGORY �迭
FROM TB_DEPARTMENT
WHERE capacity BETWEEN 20 AND 30 ;



-- 6. ������ �̸��� �˾Ƴ��� �ִ� SQL ���� �ۼ�

SELECT * FROM TB_PROFESSOR;

SELECT PROFESSOR_NAME FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;



-- 7.�а��� �������� ���� �л� Ȯ��

SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_STUDENT;

SELECT * FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8. �������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ

SELECT * FROM TB_CLASS;

SELECT CLASS_NO 
FROM TB_CLASS
WHERE preattending_class_no IS NOT NULL;

-- 9. � �迭���� �ִ��� �ߺ������ؼ� ��ȸ

SELECT * FROM TB_DEPARTMENT;

SELECT DISTINCT CATEGORY 
FROM TB_DEPARTMENT;


-- 10 . 02�й� ���� �����ڵ��� ������ ��������Ѵ�. 
--      ������ ��� ���� �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ���� �ۼ�

SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_STUDENT;

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT 
WHERE SUBSTR(ENTRANCE_DATE,1,2) = '02'
      AND ABSENCE_YN = 'N'
      AND student_address LIKE '����%';


--------------------------------------------------------------------------------
------------ADDITIONAL  ----------------

     
-- 1. ������а�     �л����� �й��� �̸� ���г⵵�� ���������� �ۼ�
SELECT * FROM tb_department;
SELECT * FROM tb_STUDENT;

SELECT STUDENT_NO �й�, STUDENT_NAME �̸� ,  TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD')���г⵵
FROM tb_department D, tb_student S
WHERE d.department_no = s.department_no
      AND d.department_no = '002'
ORDER BY ENTRANCE_DATE;


-- 2. ���� �̸� �� �����ڰ� �ƴ� ������ �̸��� �ֹι�ȣ�� �������

SELECT * FROM TB_PROFESSOR;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME LIKE '__' OR PROFESSOR_NAME LIKE '____%';


-- 3. ���������� �̸��� ���̸� ��� 
-- ���� ������ ��� 

SELECT * FROM TB_PROFESSOR;

SELECT PROFESSOR_NAME �����̸�, EXTRACT(YEAR FROM SYSDATE)  -  EXTRACT(YEAR FROM TO_DATE('19'||SUBSTR(PROFESSOR_SSN,1,2),'RR')) ����
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = '1'
ORDER BY 2 ;




-- 4. �����̸� �������ϰ� ����ϱ� 
SELECT * FROM TB_PROFESSOR;

SELECT SUBSTR(PROFESSOR_NAME,2,2)
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '__' 
     AND PROFESSOR_NAME NOT LIKE '____' ;
     
     

--5. ����� �����ڸ� ���Ѵ�.

SELECT *  FROM  TB_STUDENT;

SELECT STUDENT_NO �й�, STUDENT_NAME �̸� , STUDENT_SSN �ֹε��, ENTRANCE_DATE ���г�,
EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT (YEAR FROM  TO_DATE(SUBSTR(STUDENT_SSN,1,6))) ����
FROM TB_STUDENT
WHERE (EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT (YEAR FROM  TO_DATE(SUBSTR(STUDENT_SSN,1,6)))) > 19
ORDER BY 4;


-- 6. 2020�� ũ���������� ���� ����?


SELECT TO_CHAR(TO_DATE(20201225, 'YYYYMMDD'),'YYYYMMDD DAY') FROM DUAL; -- �ݿ���


--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') ���� �� �� ��� ����?
--TO_DATE('RR/10/11','YY/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') ���� �� �� ��� ����?

SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'), 'YYYYMMDD'),  -- 2099�� 10�� 11��
       TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'), 'YYYYMMDD') , -- 2049�� 10�� 11��
      TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'),'YYYYMMDD'),    -- 1999�� 10�� 11��
      TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'),'YYYYMMDD')     -- 2049�� 10�� 11��
FROM DUAL;


-- 8. 2000�⵵ ���� �����ڵ��� A�� ���� 2000�൵ ���� �й��� ���� �л��� ���

SELECT * FROM TB_STUDENT;

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT SUBSTR(STUDENT_NO,1,1) = 'A';


-- 9. �й� A517178 �� �ѾƸ� �л��� ���� �� ������ ���Ͻÿ�
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_GRADE;

SELECT ROUND(SUM(POINT) / COUNT(POINT),1) ����
FROM TB_STUDENT S , TB_GRADE G
WHERE s.student_no = g.student_no
     AND G.STUDENT_NO = 'A517178'
GROUP BY G.STUDENT_NO;


-- 10. �а��� �л����� ���Ͽ� �а���ȣ, �л��� �� ���
SELECT * FROM TB_DEPARTMENT, TB_STUDENT;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NO �а���ȣ, COUNT(DEPARTMENT_NO) "�л���(��)"
FROM  TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY 1;



-- 11. ���� ���� ������ ������ �л��� 

SELECT * FROM TB_STUDENT;

SELECT COUNT(*) 
FROM TB_STUDENT
WHERE coach_professor_no IS NULL;


-- 12. �й� A112113 �л��� �⵵�� ������ ���Ͻÿ� 


SELECT * FROM TB_STUDENT;
SELECT * FROM TB_GRADE;

SELECT SUBSTR(TERM_NO,1,4) �⵵ , ROUND(SUM(POINT) / COUNT(POINT),1) "�⵵ �� ����"
FROM TB_STUDENT S,TB_GRADE G
WHERE G.STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4);



-- 13. �а� �� ���л� �� �ľ�

SELECT * FROM TB_STUDENT;

SELECT DEPARTMENT_NO �а��ڵ��, COUNT(*)"���л� ��"
from TB_STUDENT
WHERE ABSENCE_YN  = 'Y'
GROUP BY DEPARTMENT_NO 
ORDER BY 1;


-- 14. �������� �л����� �̸��� ã�´� 

SELECT * FROM TB_STUDENT;
/*
SELECT
FROM TB_STUDENT S1, TB_STUDENT S2
WH
*/

SELECT STUDENT_NAME, COUNT(STUDENT_NAME)
FROM TB_STUDENT
GROUP BY STUDENT_NAME 
HAVING COUNT(STUDENT_NAME) >= 2
ORDER BY 1;


-- 15. A112113�� ���� �л��� �⵵ , �б� �� ������ �⵵�� ���� ����, �������� ���Ͻÿ�

SELECT * FROM TB_STUDENT;
SELECT * FROM TB_GRADE;

--SELECT SUBSTR(TERM_NO,1,4) �⵵ , SUBSTR(TERM_NO,5,2) �б�    , AVG(POINT)

SELECT SUBSTR(TERM_NO,1,4) �⵵ , SUBSTR(TERM_NO,5,2) �б� , LPAD(ROUND(AVG(POINT),1),5) ����
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2))
ORDER BY 1;

