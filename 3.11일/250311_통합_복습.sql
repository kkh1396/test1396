/** �Ʒ� ���̺� �� �÷��� �����Ѵٰ� �����ϰ� �������� �ۼ��غ��� **/
/*** DDL ***/
-- EMP ���̺� DEPT_ID �÷��� �߰��ϸ鼭 �⺻���� 100���� ����
-- ����, DEPARTMENT ���̺��� DEPT_ID �÷��� �����ϴ� �ܷ�Ű�� �����ϵ�
-- �θ� Ű�� ������ ��� �ش� ���� NULL�� ����

alter table emp
            add dept_id number default 100
            add constraint fk_emp_dept_id foreign key (dept_id)
            references department (dept_id) on delete set null;

-- EMP ���̺��� EMP_NAME �÷��� ������ Ÿ���� VARCHAR2(100)���� ����
alter table employee modify emp_name varchar2(100);

/*** DML ***/
-- EMP ���̺��� DEPT_ID ���� 'D3'�� �������� SALARY �� 10% �λ�

   update emp set salary = salary * 1.1 where dept_id = 'd3';

-- EMP ���̺��� DEPT_ID ���� 'D99'�� �������� ����

delete from emp where dept_id = 'd99' ;

/*** DQL ***/
-- EMP ���̺��� SALARY ���� ���� ���� ������ ������ ��ȸ
select * from emp
where salary = (select max(salary) from emp);

-- EMP ���̺��� DEPT_ID �� ��� �޿�(SALARY)�� 4000000 �̻��� �μ��� �μ��� ��� �޿� ��ȸ

select dept_id, avg(salary) from emp 
group by dept_id
having avg(salary) >= 4000000;

/*** DCL ***/
-- SAMPLE �������� EMP ���̺� ���� ��ȸ, ���� ������ �ο�

grant select,update on emp to sample;

-- SAMPLE �������� �ο��ߴ� EMP ���̺� ���� ���� ���� ȸ��

revoke update on emp FROM sample;

/*** TCL ***/
-- EMP ���̺��� SALARY�� 20% �λ��� �� �ش� ������ ����             

UPDATE EMP SET SALARY = SARLARY *1.2;
SAVEPOINT SC;

-- ���� ���� �������� �ѹ�

ROLLBACK TO SC;


-- ��������� ��� ���� ������ ����

COMMIT;