-- =================== ������ ���� ���� �� �Ʒ� ���� ��ȸ =================== --
-- ���þƿ��� �ٹ����� ����� ���, �����, �μ���, ������, �������� ��ȸ
/*
        211	������	���������	EU	���þ�
        212	������	���������	EU	���þ�
        222	���¸�	���������	EU	���þ�
*/
select emp_id, emp_name, dept_title, national_code, national_name
from employee
    join department on dept_code = dept_id
    join location on local_code =  location_id
    join national using(national_code)
where national_name = '���þ�';

-- �μ� �� ���ʽ����� ���� ���� ����� �μ���, ���޸�, �̸�, ���ʽ� ��ȸ 
/*
        �λ������	�븮	������	0.3
        �ؿܿ���1��	����	�ɺ���	0.15
        �ؿܿ���2��	����	�����	0.2
        ���������	�븮	���¸�	0.35
        �ѹ���	��ǥ	������	0.3
*/

SELECT DEPT_CODE, MAX(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_TITLE, JOB_NAME, EMP_NAME, BONUS
FROM EMPLOYEE
   JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
   JOIN JOB USING (JOB_CODE)
WHERE (DEPT_CODE,BONUS) IN (
                SELECT DEPT_CODE, MAX(BONUS)
                FROM EMPLOYEE
                GROUP BY DEPT_CODE
);


;
-- ���̰� 5�� ���̳��� ������� ���� ��ȸ 
-- ( ���A�� ���, ���A�� �̸�, ���A�� �������, ���B�� ���, ���B�� �̸�, ���B�� ������� )
/*
        209	�ɺ���	750206	221	������	800808
        212	������	780923	211	������	830807
        221	������	800808	214	����	856795
        211	������	830807	215	���ȥ	881130
*/






