select EMP_NAME as �̸� , SALARY * 12 as ����,(SALARY + (SALARY*BONuS))*12 as "���ʽ� ���� ����" from employee;

select EMP_ID, SALARY, '��' as ���� from employee;



select emp_id || emp_name from employee;
select DISTINCT job_code from employee;