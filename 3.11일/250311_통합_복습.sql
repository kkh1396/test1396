/** 아래 테이블 및 컬럼은 존재한다고 가정하고 쿼리문을 작성해보자 **/
/*** DDL ***/
-- EMP 테이블에 DEPT_ID 컬럼을 추가하면서 기본값을 100으로 설정
-- 또한, DEPARTMENT 테이블의 DEPT_ID 컬럼을 참조하는 외래키를 설정하되
-- 부모 키가 삭제될 경우 해당 값을 NULL로 설정

alter table emp
            add dept_id number default 100
            add constraint fk_emp_dept_id foreign key (dept_id)
            references department (dept_id) on delete set null;

-- EMP 테이블의 EMP_NAME 컬럼의 데이터 타입을 VARCHAR2(100)으로 변경
alter table employee modify emp_name varchar2(100);

/*** DML ***/
-- EMP 테이블에서 DEPT_ID 값이 'D3'인 직원들의 SALARY 를 10% 인상

   update emp set salary = salary * 1.1 where dept_id = 'd3';

-- EMP 테이블에서 DEPT_ID 값이 'D99'인 직원들을 삭제

delete from emp where dept_id = 'd99' ;

/*** DQL ***/
-- EMP 테이블에서 SALARY 값이 가장 높은 직원의 정보를 조회
select * from emp
where salary = (select max(salary) from emp);

-- EMP 테이블에서 DEPT_ID 별 평균 급여(SALARY)가 4000000 이상인 부서만 부서별 평균 급여 조회

select dept_id, avg(salary) from emp 
group by dept_id
having avg(salary) >= 4000000;

/*** DCL ***/
-- SAMPLE 계정에게 EMP 테이블에 대한 조회, 수정 권한을 부여

grant select,update on emp to sample;

-- SAMPLE 계정에게 부여했던 EMP 테이블에 대한 수정 권한 회수

revoke update on emp FROM sample;

/*** TCL ***/
-- EMP 테이블에서 SALARY를 20% 인상한 후 해당 시점을 저장             

UPDATE EMP SET SALARY = SARLARY *1.2;
SAVEPOINT SC;

-- 이전 저장 시점으로 롤백

ROLLBACK TO SC;


-- 현재까지의 모든 변경 사항을 적용

COMMIT;