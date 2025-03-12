250306_FUNCTION+JOIN.sql
/*
    아래 쿼리문의 실행 순서는?
    
    SELECT 컬럼명                            -- 1            -- 5
    FROM 테이블명                            -- 2            -- 1
    WHERE 조건                               -- 3           -- 2
    GROUP BY 그룹화기준                       -- 4           -- 3
    HAVING 그룹 조건                          -- 5           -- 4
    ORDER BY 정렬 기준                        -- 6           -- 6
*/

--=========================================================================
--     수업용 계정 로그인 후 아래 정보를 조회할 수 있는 쿼리문을 작성해주세요
--=========================================================================
-- 이메일의 아이디 부분에(@ 앞부분) k가 포함된 사원 정보 조회

        select * from employee where email like '%k%@%';
        
        select * from employee 
        where substr(email, 1, instr(email, '@')-1) like '%k%';

-- 연락처 앞자리가 010, 011로 시작하는 사원 수 조회
      
         select count(*) from employee where substr(phone,1,3) in ('010','011');

-- 생일이 7월이후인 사원들의 입사월별 사원 수 조회 (아래와 같이 출력)

               select * from employee;
               
               select lpad(substr(emp_no,3,2), 7)||'월' "생월" , lpad(extract(month from hire_date),7)||'월' "입사월"
               ,lpad(count(*),7 )||'명' "입사 사원수"
                from employee
                where substr(emp_no,3,2) >= 7
                group by substr(emp_no,3,2),  extract(month from hire_date)
                order by  1, 2 ;
               
               
/*
------------------------------------------------------------
    생월     |   입사월   |   입사 사원수|
         7월 |       4월 |          2명|
         7월 |       9월 |          1명|
         ...
         9월 |       6월 |          1명|
------------------------------------------------------------
*/

-- 영업부서 사원의 사번, 사원명, 부서명, 직급명 조회
-- ** 오라클 구문 **

     select * from employee;
     select * from department;
     select * from job;
     
     select emp_id, emp_name, dept_title, job_name
     from employee e ,department d ,job j
     where e.dept_code = d.dept_id
        and e.job_code = j.job_code
        and dept_title like '%영업%';

-- ** ANSI 구문 **
 select emp_id, emp_name, dept_title, job_name
     from employee 
       join department on dept_code = dept_id
       join job using (job_code)
    where dept_title like '%영업%';



-- 사수가 없는 사원 정보 조회 (부서명, 사번, 사원명 조회)

     select * from employee;
     select * from department;

-- ** 오라클 구문 **

        select dept_title, emp_id, emp_name
        from employee, department
        where dept_code = dept_id
          and manager_id is null;

-- ** ANSI 구문 **

       select dept_title, emp_id, emp_name
       from  employee
           join department on dept_code = dept_id
       where manager_id is null;
      


-- 부서별 사수가 없는 사원 수 조회 (부서명, 사원수 조회)

     select * from employee;
     select * from department;


-- ** 오라클 구문 **

          select dept_title, count(*)
          from employee, department
          where dept_code = dept_id
               and manager_id is null
          group by dept_title;
          
          
-- ** ANSI 구문 **
           
        select dept_title, count(*)
          from employee 
             join department on dept_code = dept_id 
                    where manager_id is null
            group by dept_title;
        
         



