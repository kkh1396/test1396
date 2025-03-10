/*
  SELECT : ������ ��ȸ(����)
  
     [ǥ����]
     
        SELECT ��ȸ�ϰ��� �ϴ� ���� FROM ���̺��;
        
        SELECT �÷���1, �÷���2, .. �Ǵ� * FROM ���̺��;
*/


-- ��� ����� ������ ��ȸ 

SELECT * FROM EMPLOYEE;

-- ��� ����� �̸�, �ֹι�ȣ, ����ó�� ��ȸ

select EMP_NAME as "�̸�", EMP_NO as "�ֹι�ȣ", PHONE as "����ó"  -- (2) employee ���̺��� EMP_NAME, EMP_NO, PHONE �÷��� ���� �����͸� ����
from employee;                                                   -- (1) employee ���̺��� ��ȸ 


-- ��� ������ ������ ��ȸ 
select *  from JOB;

-- ���� ���� �� ���޸� ��ȸ
select job_name from job;


-- ��� ���̺��� ��� �����, �̸���, ����ó, �Ի���, �޿� ��ȸ

select EMP_NAME, email, phone, hire_date, salary from employee;



/*
    �÷��� ��� ���� �߰��ϱ�
    => Select���� �÷��� �ۼ��κп� ��� ������ �� ��  ����!
   
*/

-- �����, ���� ���� ��ȸ
--  ���� = �޿� * 12
--   SALARY �÷� �����Ϳ� 12�� ���Ͽ� ����� ǥ�� 

select *  from employee;
select emp_name , salary  from employee;
select emp_name , salary *12 from employee;

-- �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ���� ������ ��ȸ
--  ���ʽ� ���� ���� = (�޿� + (�޿�*���ʽ�)) * 12

select emp_name , salary, bonus, salary*12 , (salary + (salary * bonus))*12 from employee;


/*
   * �÷��� ��Ī �ο��ϱ�
    : ������� ����� ��� �ǹ̸� �ľ��ϱ� ��Ʊ� ������
      ��Ī�� �ο��Ͽ� ��Ȯ�ϰ� ����ϰ� ��ȸ�� �� ����!
      
      
      [ ǥ���� ] 
       
                (1) �÷��� ��Ī
                (2) �÷��� AS ��Ī
                (3) �÷��� "��Ī"
                (4) �÷��� AS "��Ī"
*/

-- ��� ����� �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ���� ������ ��ȸ (* ��Ī �ο� )

SELECT * FROM EMPLOYEE;
select emp_name as ���, salary as �޿�, bonus as ���ʽ� , salary*12 as ����, (salary + (salary*bonus)) *12 as "���ʽ����� ����"
from EMPLOYEE;



/*
    - ���� ��¥�ð� ���� ; SYSDATE
    - ���� ���̺�(�ӽ� ���̺�) : DUAL
*/

-- ���� ��¥�ð� ���� ��ȸ
SELECT SYSDATE FROM DUAL; -- YY/MM/DD �������� ��ȸ��!

-- ��� ����� �����, �Ի���, �ٹ��ϼ� ��ȸ
--   �ٹ��ϼ� = ���糯¥ - �Ի��� + 1
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE + 1 "�ٹ��ϼ�" FROM EMPLOYEE;

-- DATE Ÿ�� - DATE Ÿ�� => �� ������ ǥ�õ�!

/*
  * ���ͷ�(�� ��ü) : ���Ƿ� ������ ���� ���ڿ�('') ǥ�� �Ǵ� ���ڷ� ǥ��
    -> SELECT ���� ����ϴ� ��� ��ȸ�� ���(Result Set)�� �ݺ������� ǥ�õ�!
*/


-- �����, �޿�, '��' ��ȸ(* ��Ī �ο�)
SELECT * FROM EMPLOYEE;
select emp_name, salary, '��' from employee;

/*
  ���� ������ : ||
  �� ���� �÷� �Ǵ� ���� �÷��� �������ִ� ������
*/

-- ��� �����: "xxx"�� �������� �޿������� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT SALARY || '��' FROM EMPLOYEE;

-- ���, �̸�, �޿��� �ѹ���(�� �÷���) ��ȸ
SELECT * FROM EMPLOYEE;
SELECT EMP_NO || EMP_NAME || SALARY FROM EMPLOYEE;

-- "XXX�� �޿��� XXXX���Դϴ�" �������� ��ȸ (*��Ī : �޿�����)
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME||'�� �޿��� '||SALARY||'���Դϴ�.' AS �޿����� FROM EMPLOYEE;


/*
  * �ߺ� ���� : DISTINCT
    �ߺ��� ������� ���� ��� ��ȸ ����� �ϳ��� ǥ������
*/
-- ������̺��� �����ڵ� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT JOB_CODE FROM EMPLOYEE;

-- ��� ���̺��� �ߺ� �����Ͽ� �����ڵ� ��ȸ
SELECT DISTINCT JOB_CODE FROM employee;

-- ��� ���̺��� �μ��ڵ� ��ȸ (*�ߺ� ����)
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE ,JOB_CODE
FROM EMPLOYEE;


-- ==========================================

/*
   * WHERE�� : ��ȸ�ϰ��� �ϴ� �����͸� Ư�� ���ǿ� ���� �����ϰ��� �� �� ���
   
   [ ǥ���� ]
         SELECT �÷��� , �÷� �Ǵ� ������ ���� �����
         FROM ���̺��
         WHERE ����;
        
    - �񱳿����� 
        * ��� �� : > < >= <=
        * ����� 
             - ���� �� �� : =
             - �ٸ��� �� : != <> ^=
*/

-- ��� ���̺��� �μ��ڵ尡 'D9'�� ������� ������ ��ȸ
SELECT * FROM EMPLOYEE;
SELECT *                    -- (3) ��ü �÷��� �����͸� ��ȸ
FROM EMPLOYEE               -- (1) EMPPLOYEE ���̺���
WHERE DEPT_CODE = 'D9';     -- (2) DEPT_CODE �÷��� ���� 'D9'��

-- ��� ���� �� �μ��ڵ尡 'D1'�� ������� �����, �޿� ,�μ��ڵ带 ��ȸ 
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';


-- ��� ���� �� �μ��ڵ尡 'D1'�� �ƴ� ������� �����, �޿�, �μ��ڵ带 ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';


SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';


-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ������ ��ȸ
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE,SALARY 
FROM EMPLOYEE
WHERE SALARY >= 4000000;


-- �޿��� 400���� �̸��� ������� �����, �μ��ڵ�, �޿� ������ ��ȸ
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, JOB_CODE,SALARY 
FROM EMPLOYEE
WHERE SALARY <= 4000000;


--=========================================================

-- * ��, ���� ��� �� ���ʽ� ���� **
SELECT * FROM EMPLOYEE;
-- [1] �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ (��Ī ����)
SELECT EMP_NAME �����, SALARY �޿�, HIRE_DATE �Ի���, SALARY*12 ����
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- [2] ������ 5õ���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ (��Ī ����)
SELECT EMP_NAME �����, SALARY �޿�, SALARY*12 ����, DEPT_CODE �μ�
FROM EMPLOYEE
WHERE salary*12 >= 50000000;

-- [3] ���� �ڵ尡 'J5' �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ (��Ī ����)
SELECT EMP_ID ���, EMP_NAME �����, JOB_CODE AS �����ڵ�, ENT_YN ��翩��
FROM EMPLOYEE
WHERE JOB_CODE != 'J5';

-- [4] �޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ (��Ī ����)
--   * �������� : AND, OR�� ������ ������ �� ����!
SELECT EMP_ID ���, EMP_NAME �����, SALARY AS �޿�
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--------------------------------------------------------------

/*
    * BETWEEN AND ; ���ǽĿ��� ���Ǵ� ����
       => ~ �̻� ~������ ������ ���� ������ �����ϴ� ����
       
        [ǥ����]
        
            �÷��� BETWEEN A AND B
            
            - �÷��� : �� ��� �÷�
            - A     : �ּڰ�
            - B     : �ִ밪
            ==> �ش� �÷��� ���� �ּڰ� �̻��̰� �ִ� ������ ���

*/

-- �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT EMP_ID ���, EMP_NAME �����, SALARY AS �޿�
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

/*
  * ���������� : NOT 
*/
-- �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� ��ȸ (BETWEEN AND, NOT)
SELECT EMP_ID ���, EMP_NAME �����, SALARY AS �޿�
FROM EMPLOYEE
WHERE NOT SALARY  BETWEEN 3500000 AND 6000000;
-- WHERE SALARY NOT BETWEEN 3500000 AND 6000000; 

/*
   * IN : �񱳴���÷��� ���� ������ ���� �߿� ��ġ�ϴ� ���� �ִ� ��츦 ��ȸ�ϴ� ����
   
    [ǥ����]
    
        �÷��� IN (��1,��2,��3, ......)
        
        �Ʒ��� ������
        
        �÷��� = ��1 OR �÷��� = ��2 OR  �÷��� = ��3 ...
*/
-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� ������� �����, �μ��ڵ�, �޿��� ��ȸ (* IN ������ ���� ���)
SELECT *FROM EMPLOYEE;

SELECT EMP_NAME �����, DEPT_CODE AS �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� ������� �����, �μ��ڵ�, �޿��� ��ȸ (* IN ����� ���)

SELECT EMP_NAME �����, DEPT_CODE AS �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8','D5');



/*
    * Like : ���ϰ��� �ϴ� �÷��� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
       [ǥ����] 
          �񱳴���÷� Like '����'
        => Ư�� ���� : '%', '_'�� ���ϵ�ī��� ���

          * % : 0���� �̻�
            ex) �񱳴���÷� LIKE '����%' => �񱳴���÷����� ���� ���ڷ� "����"�Ǵ� ���� ��ȸ
                �񱳴���÷� LIKE '%����' => �񱳴���÷��� ���� ���ڷ� "��" ���� ���� ��ȸ
                �񱳴���÷� LIKE '%����%' => �񱳴���÷��� ���� ���ڰ� "����"�Ǵ� ���� ��ȸ (Ű���� �˻�)
                
                
          * _ : 1����
            ex) �񱳴���÷� LIKE '_����' => �񱳴���÷��� ������ ���� �տ� ������ �ѱ��ڰ� ���� ��츦 ��ȸ
                �񱳴���÷� LIKE '__����' => �񱳴���÷��� ������ ���� �տ� ������ �α��ڰ� ���� ��츦 ��ȸ
                �񱳴���÷� LIKE '_����_' =>  �񱳴���÷��� ������ ���� �յڷ� ������ �ѱ��ھ� ���� ��츦 ��ȸ
*/
-- ����� �� "��"�� ���� ���� ����� �����, �޿�, �Ի��� ��ȸ
SELECT *FROM EMPLOYEE;

select emp_name, salary, hire_date
from employee
where emp_name like '��%';


-- ����� "��"�� ���Ե� ����� �����, �ֹι�ȣ, ����ó ��ȸ
SELECT *FROM EMPLOYEE;

select emp_name, emp_no, phone
from employee
where emp_name like '%��%';

--  ����� ��� ���ڰ� "��"�� ����� �����, ����ó ��ȸ (������� 3������ ����� �� ��ȸ)
SELECT *FROM EMPLOYEE;

select emp_name, emp_no, phone
from employee
where emp_name like '_��_';

-- ����� �� ����ó�� 3�����ڸ��� 1�� ����� ���, �����, ����ó, �̸��� ��ȸ

SELECT *FROM EMPLOYEE;

select emp_id, emp_name,phone,email
from employee
where phone like '__1%';

-- ����� �� �̸��Ͽ� 4�����ڸ��� _�� ����� ���, �̸�, �̸��� ��ȸ
select * from employee;

select emp_id, emp_name, email
from employee
where email like '___%'; -- ���ϴ� ��� Ȯ�� �Ұ�!
-- ���ϵ� ī��� ���Ǵ� ���ڿ� �÷��� ��� ���ڰ� �����ϱ� ������ ��� ���ϵ�ī��� �νĵ�!
-- ����, ������ �������! (=> ������ ���ϵ� ī�带 ����ؾ� ��! ESAPE �ɼ� �߰�)

-- [ǥ����] �񱳴���÷� LIKE '����' ESCAPE '��ȣ';

select emp_id, emp_name, email
from employee
where email like '___G_%'ESCAPE'G';


-- =============================================================================
/*
    * IS NULL / IS NOT NULL
    : Į������ NULL�� �ִ� ��� NULL���� ���� �� ���Ǵ� ������
    
     - IS NULL : �÷� ���� NULL ������ ��
     - IS NOT NULL : �÷����� NULL ���� �ƴ��� ��

*/

-- ���ʽ��� ���� �ʴ� ������� ���, �����, �޿�, ���ʽ� ��ȸ
-- > BONUS �÷��� ���� NULL�� ��� 

SELECT * FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ������� ���, �����, �޿�, ���ʽ� ��ȸ
-- => BONUS �÷��� ���� NULL�� �ƴ� ���
SELECT * FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL; -- �̷��Ե� ����

-- ����� ���� ������� �����, ������, �μ��ڵ� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- �μ� ��ġ�� ���� �ʾ�����, ���ʽ��� �ް� �ִ� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- =============================================================================
-- �����ڵ尡 'J7'�̰ų� 'J2'�� ����� �� �޿��� 200���� �̻��� ����� ��� ������ ��ȸ
SELECT * FROM EMPLOYEE;

SELECT * 
FROM EMPLOYEE
-- WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND salary >= 2000000; -- ���ϴ� ����� ǥ�õ��� ����!
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND salary >= 2000000;
-- WHERE JOB_CODE IN('J7','J2') AND salary >= 2000000;

/*
   * ������ �켱����
    (0) ()
    (1) ��� ������ : * / + -
    (2) ���� ������ : ||
    (3) �� ������ : > < >= <= = != <> ^=
    (4) IS NULL / LIKE '����' / IN
    (5) BETWEEN AND 
    (6) NOT 
    (7) AND 
    (8) OR 
    
*/
-- =============================================================================

/* 
    * ���� : ORDER BY 
         => SELECT������ ���� ������ �ٿ� �ۼ�
         => ���� ���� ���� �������� ����
         
    [ǥ����]
         (3) SELECT ��ȸ�� �÷�, ...
         (1) FROM ���̺��
         (2) WHERE ���ǽ�
         (4) ORDER BY ���� ������ �Ǵ� �÷� | ��Ī | �÷����� [ASC|DESC] [NULLS FIRST |NULLS LAST]
         
         * ASC : �������� ���� (�⺻��)
         * DESC : �������� ����
         
         * NULLS FIRST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �� �տ� ��ġ (DESC�� ��� �⺻��)
         * NULLS LAST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �� �ڿ� ��ġ
           --> NULL ���� ū ������ �з��Ͽ� ����!
*/ 

-- ��� ����� �����, ���� ��ȸ (������ �������� ����)
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, SALARY *12 ����
FROM EMPLOYEE
-- ORDER BY SALARY;
--ORDER BY ���� ;  
ORDER BY 2 ;  -- �÷� ���� ��� (* ����Ŭ������ ������ 1���� ����!)


-- ���ʽ� �������� ����
SELECT * FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; -- �⺻�� (ASC, NULLS LAST)
-- ORDER BY BONUS ASC;
-- ORDER BY BONUS ASC NULLS LAST;
-- ORDER BY BONUS DESC; -- DESC �� �� NULLS FIRST �⺻��
ORDER BY BONUS DESC, SALARY ASC ; 
-- ���ʽ� �÷��� �������� ����, �޿� �÷��� �������� ����
-- => ���ʽ� ���� �������� �����ϴµ� ���ʽ� ���� ���� ���� ��� �޿��� ���� �������� ����

