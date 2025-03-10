select EMP_NAME as 이름 , SALARY * 12 as 연봉,(SALARY + (SALARY*BONuS))*12 as "보너스 포함 연봉" from employee;

select EMP_ID, SALARY, '원' as 단위 from employee;



select emp_id || emp_name from employee;
select DISTINCT job_code from employee;