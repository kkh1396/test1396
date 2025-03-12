250306_FUNCTION+JOIN.sql
/*
    �Ʒ� �������� ���� ������?
    
    SELECT �÷���                            -- 1            -- 5
    FROM ���̺��                            -- 2            -- 1
    WHERE ����                               -- 3           -- 2
    GROUP BY �׷�ȭ����                       -- 4           -- 3
    HAVING �׷� ����                          -- 5           -- 4
    ORDER BY ���� ����                        -- 6           -- 6
*/

--=========================================================================
--     ������ ���� �α��� �� �Ʒ� ������ ��ȸ�� �� �ִ� �������� �ۼ����ּ���
--=========================================================================
-- �̸����� ���̵� �κп�(@ �պκ�) k�� ���Ե� ��� ���� ��ȸ

        select * from employee where email like '%k%@%';
        
        select * from employee 
        where substr(email, 1, instr(email, '@')-1) like '%k%';

-- ����ó ���ڸ��� 010, 011�� �����ϴ� ��� �� ��ȸ
      
         select count(*) from employee where substr(phone,1,3) in ('010','011');

-- ������ 7�������� ������� �Ի���� ��� �� ��ȸ (�Ʒ��� ���� ���)

               select * from employee;
               
               select lpad(substr(emp_no,3,2), 7)||'��' "����" , lpad(extract(month from hire_date),7)||'��' "�Ի��"
               ,lpad(count(*),7 )||'��' "�Ի� �����"
                from employee
                where substr(emp_no,3,2) >= 7
                group by substr(emp_no,3,2),  extract(month from hire_date)
                order by  1, 2 ;
               
               
/*
------------------------------------------------------------
    ����     |   �Ի��   |   �Ի� �����|
         7�� |       4�� |          2��|
         7�� |       9�� |          1��|
         ...
         9�� |       6�� |          1��|
------------------------------------------------------------
*/

-- �����μ� ����� ���, �����, �μ���, ���޸� ��ȸ
-- ** ����Ŭ ���� **

     select * from employee;
     select * from department;
     select * from job;
     
     select emp_id, emp_name, dept_title, job_name
     from employee e ,department d ,job j
     where e.dept_code = d.dept_id
        and e.job_code = j.job_code
        and dept_title like '%����%';

-- ** ANSI ���� **
 select emp_id, emp_name, dept_title, job_name
     from employee 
       join department on dept_code = dept_id
       join job using (job_code)
    where dept_title like '%����%';



-- ����� ���� ��� ���� ��ȸ (�μ���, ���, ����� ��ȸ)

     select * from employee;
     select * from department;

-- ** ����Ŭ ���� **

        select dept_title, emp_id, emp_name
        from employee, department
        where dept_code = dept_id
          and manager_id is null;

-- ** ANSI ���� **

       select dept_title, emp_id, emp_name
       from  employee
           join department on dept_code = dept_id
       where manager_id is null;
      


-- �μ��� ����� ���� ��� �� ��ȸ (�μ���, ����� ��ȸ)

     select * from employee;
     select * from department;


-- ** ����Ŭ ���� **

          select dept_title, count(*)
          from employee, department
          where dept_code = dept_id
               and manager_id is null
          group by dept_title;
          
          
-- ** ANSI ���� **
           
        select dept_title, count(*)
          from employee 
             join department on dept_code = dept_id 
                    where manager_id is null
            group by dept_title;
        
         



