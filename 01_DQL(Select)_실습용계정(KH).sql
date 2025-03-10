/*
  SELECT : 데이터 조회(추출)
  
     [표현식]
     
        SELECT 조회하고자 하는 정보 FROM 테이블명;
        
        SELECT 컬럼명1, 컬럼명2, .. 또는 * FROM 테이블명;
*/


-- 모든 사원의 정보를 조회 

SELECT * FROM EMPLOYEE;

-- 모든 사원의 이름, 주민번호, 연락처를 조회

select EMP_NAME as "이름", EMP_NO as "주민번호", PHONE as "연락처"  -- (2) employee 테이블에서 EMP_NAME, EMP_NO, PHONE 컬럼에 대한 데이터만 추출
from employee;                                                   -- (1) employee 테이블에서 조회 


-- 모든 직급의 정보를 조회 
select *  from JOB;

-- 직급 정보 중 직급명만 조회
select job_name from job;


-- 사원 테이블에서 모든 사원명, 이메일, 연락처, 입사일, 급여 조회

select EMP_NAME, email, phone, hire_date, salary from employee;



/*
    컬럼명에 산술 연산 추가하기
    => Select절에 컬럼명 작성부분에 산술 연산을 할 수  있음!
   
*/

-- 사원명, 연봉 정보 조회
--  연봉 = 급여 * 12
--   SALARY 컬럼 데이터에 12를 곱하여 결과로 표시 

select *  from employee;
select emp_name , salary  from employee;
select emp_name , salary *12 from employee;

-- 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉 정보를 조회
--  보너스 포함 연봉 = (급여 + (급여*보너스)) * 12

select emp_name , salary, bonus, salary*12 , (salary + (salary * bonus))*12 from employee;


/*
   * 컬럼에 별칭 부여하기
    : 연산식을 사용한 경우 의미를 파악하기 어렵기 때문에
      별칭을 부여하여 명확하고 깔끔하게 조회할 수 있음!
      
      
      [ 표현식 ] 
       
                (1) 컬럼명 별칭
                (2) 컬럼명 AS 별칭
                (3) 컬러명 "별칭"
                (4) 컬럼명 AS "별칭"
*/

-- 모든 사원의 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉 정보를 조회 (* 별칭 부여 )

SELECT * FROM EMPLOYEE;
select emp_name as 사원, salary as 급여, bonus as 보너스 , salary*12 as 연봉, (salary + (salary*bonus)) *12 as "보너스포함 연봉"
from EMPLOYEE;



/*
    - 현재 날짜시간 정보 ; SYSDATE
    - 가상 테이블(임시 테이블) : DUAL
*/

-- 현재 날짜시간 정보 조회
SELECT SYSDATE FROM DUAL; -- YY/MM/DD 형식으로 조회됨!

-- 모든 사원의 사원명, 입사일, 근무일수 조회
--   근무일수 = 현재날짜 - 입사일 + 1
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE + 1 "근무일수" FROM EMPLOYEE;

-- DATE 타입 - DATE 타입 => 일 단위로 표시됨!

/*
  * 리터럴(값 자체) : 임의로 지정한 값을 문자열('') 표현 또는 숫자로 표현
    -> SELECT 절에 사용하는 경우 조회된 결과(Result Set)에 반복적으로 표시됨!
*/


-- 사원명, 급여, '원' 조회(* 별칭 부여)
SELECT * FROM EMPLOYEE;
select emp_name, salary, '원' from employee;

/*
  연결 연산자 : ||
  두 개의 컬럼 또는 값과 컬럼을 연결해주는 연산자
*/

-- 모든 사원의: "xxx"원 형식으로 급여정보를 조회
SELECT * FROM EMPLOYEE;
SELECT SALARY || '원' FROM EMPLOYEE;

-- 사번, 이름, 급여를 한번에(한 컬럼에) 조회
SELECT * FROM EMPLOYEE;
SELECT EMP_NO || EMP_NAME || SALARY FROM EMPLOYEE;

-- "XXX의 급여는 XXXX원입니다" 형식으로 조회 (*별칭 : 급여정보)
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME||'의 급여는 '||SALARY||'원입니다.' AS 급여정보 FROM EMPLOYEE;


/*
  * 중복 제거 : DISTINCT
    중복된 결과값이 있을 경우 조회 결과를 하나로 표시해줌
*/
-- 사원테이블에서 직급코드 조회
SELECT * FROM EMPLOYEE;
SELECT JOB_CODE FROM EMPLOYEE;

-- 사원 테이블에서 중복 제거하여 직급코드 조회
SELECT DISTINCT JOB_CODE FROM employee;

-- 사원 테이블에서 부서코드 조회 (*중복 제거)
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE ,JOB_CODE
FROM EMPLOYEE;


-- ==========================================

/*
   * WHERE절 : 조회하고자 하는 데이터를 특정 조건에 따라 추출하고자 할 때 사용
   
   [ 표현식 ]
         SELECT 컬럼명 , 컬럼 또는 데이터 기준 연산식
         FROM 테이블명
         WHERE 조건;
        
    - 비교연산자 
        * 대소 비교 : > < >= <=
        * 동등비교 
             - 같은 지 비교 : =
             - 다른지 비교 : != <> ^=
*/

-- 사원 테이블에서 부서코드가 'D9'인 사원들의 정보를 조회
SELECT * FROM EMPLOYEE;
SELECT *                    -- (3) 전체 컬럼의 데이터를 조회
FROM EMPLOYEE               -- (1) EMPPLOYEE 테이블에서
WHERE DEPT_CODE = 'D9';     -- (2) DEPT_CODE 컬럼의 값이 'D9'인

-- 사원 정보 중 부서코드가 'D1'인 사원들의 사원명, 급여 ,부서코드를 조회 
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';


-- 사원 정보 중 부서코드가 'D1'이 아닌 사원들의 사원명, 급여, 부서코드를 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';


SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';


-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 정보를 조회
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE,SALARY 
FROM EMPLOYEE
WHERE SALARY >= 4000000;


-- 급여가 400만원 미만인 사원들의 사원명, 부서코드, 급여 정보를 조회
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, JOB_CODE,SALARY 
FROM EMPLOYEE
WHERE SALARY <= 4000000;


--=========================================================

-- * 단, 연봉 계산 시 보너스 제외 **
SELECT * FROM EMPLOYEE;
-- [1] 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회 (별칭 적용)
SELECT EMP_NAME 사원명, SALARY 급여, HIRE_DATE 입사일, SALARY*12 연봉
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- [2] 연봉이 5천만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회 (별칭 적용)
SELECT EMP_NAME 사원명, SALARY 급여, SALARY*12 연봉, DEPT_CODE 부서
FROM EMPLOYEE
WHERE salary*12 >= 50000000;

-- [3] 직급 코드가 'J5' 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회 (별칭 적용)
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_CODE AS 직급코드, ENT_YN 퇴사여부
FROM EMPLOYEE
WHERE JOB_CODE != 'J5';

-- [4] 급여가 350만원 이상 600만원 이하인 모든 사원의 사원명, 사번, 급여 조회 (별칭 적용)
--   * 논리연산자 : AND, OR로 조건을 연결할 수 있음!
SELECT EMP_ID 사번, EMP_NAME 사원명, SALARY AS 급여
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--------------------------------------------------------------

/*
    * BETWEEN AND ; 조건식에서 사용되는 구문
       => ~ 이상 ~이하인 범위에 대한 조건을 제시하는 구문
       
        [표현식]
        
            컬럼명 BETWEEN A AND B
            
            - 컬럼명 : 비교 대상 컬럼
            - A     : 최솟값
            - B     : 최대값
            ==> 해당 컬럼의 값이 최솟값 이상이고 최댓값 이하인 경우

*/

-- 급여가 350만원 미만 또는 600만원 초과인 사원의 사원명, 사번, 급여 조회
SELECT * FROM EMPLOYEE;
SELECT EMP_ID 사번, EMP_NAME 사원명, SALARY AS 급여
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

/*
  * 부정연산자 : NOT 
*/
-- 급여가 350만원 미만 또는 600만원 초과인 사원의 사원명, 사번, 급여 조회 (BETWEEN AND, NOT)
SELECT EMP_ID 사번, EMP_NAME 사원명, SALARY AS 급여
FROM EMPLOYEE
WHERE NOT SALARY  BETWEEN 3500000 AND 6000000;
-- WHERE SALARY NOT BETWEEN 3500000 AND 6000000; 

/*
   * IN : 비교대상컬럼의 값이 제시한 값들 중에 일치하는 값이 있는 경우를 조회하는 구문
   
    [표현식]
    
        컬럼명 IN (값1,값2,값3, ......)
        
        아래와 동일함
        
        컬럼명 = 값1 OR 컬럼명 = 값2 OR  컬럼명 = 값3 ...
*/
-- 부서코드가 'D6'이거나 'D8'이거나 'D5'인 사원들의 사원명, 부서코드, 급여를 조회 (* IN 사용되지 않은 방법)
SELECT *FROM EMPLOYEE;

SELECT EMP_NAME 사원명, DEPT_CODE AS 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

-- 부서코드가 'D6'이거나 'D8'이거나 'D5'인 사원들의 사원명, 부서코드, 급여를 조회 (* IN 사용한 방법)

SELECT EMP_NAME 사원명, DEPT_CODE AS 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8','D5');



/*
    * Like : 비교하고자 하는 컬럼의 값이 제시한 특정 패턴에 만족할 경우 조회
       [표현식] 
          비교대상컬럼 Like '패턴'
        => 특정 패턴 : '%', '_'를 와일드카드로 사용

          * % : 0글자 이상
            ex) 비교대상컬럼 LIKE '문자%' => 비교대상컬럼으이 값이 문자로 "시작"되는 것을 조회
                비교대상컬럼 LIKE '%문자' => 비교대상컬럼의 값이 문자로 "끝" 나는 것을 조회
                비교대상컬럼 LIKE '%문자%' => 비교대상컬럼의 값이 문자가 "포함"되는 것을 조회 (키워드 검색)
                
                
          * _ : 1글자
            ex) 비교대상컬럼 LIKE '_문자' => 비교대상컬럼의 값에서 문자 앞에 무조건 한글자가 오는 경우를 조회
                비교대상컬럼 LIKE '__문자' => 비교대상컬럼의 값에서 문자 앞에 무조건 두글자가 오는 경우를 조회
                비교대상컬럼 LIKE '_문자_' =>  비교대상컬럼의 값에서 문자 앞뒤로 무조건 한글자씩 오는 경우를 조회
*/
-- 사원들 중 "전"씨 성을 가진 사원의 사원명, 급여, 입사일 조회
SELECT *FROM EMPLOYEE;

select emp_name, salary, hire_date
from employee
where emp_name like '전%';


-- 사원명에 "하"가 포함된 사원의 사원명, 주민번호, 연락처 조회
SELECT *FROM EMPLOYEE;

select emp_name, emp_no, phone
from employee
where emp_name like '%하%';

--  사원명에 가운데 글자가 "하"인 사원의 사원명, 연락처 조회 (사원명이 3글자인 사원들 중 조회)
SELECT *FROM EMPLOYEE;

select emp_name, emp_no, phone
from employee
where emp_name like '_하_';

-- 사원들 중 연락처의 3번쨰자리가 1인 사원의 사번, 사원명, 연락처, 이메일 조회

SELECT *FROM EMPLOYEE;

select emp_id, emp_name,phone,email
from employee
where phone like '__1%';

-- 사원들 중 이메일에 4번쨰자리가 _인 사원의 사번, 이름, 이메일 조회
select * from employee;

select emp_id, emp_name, email
from employee
where email like '___%'; -- 원하는 결과 확인 불가!
-- 와일드 카드로 사용되는 문자와 컬럼에 담긴 문자가 동일하기 때문에 모두 와일드카드로 인식됨!
-- 따라서, 구분을 해줘야함! (=> 나만의 와일드 카드를 사용해야 함! ESAPE 옵션 추가)

-- [표현식] 비교대상컬럼 LIKE '패턴' ESCAPE '기호';

select emp_id, emp_name, email
from employee
where email like '___G_%'ESCAPE'G';


-- =============================================================================
/*
    * IS NULL / IS NOT NULL
    : 칼럼값에 NULL이 있는 경우 NULL값을 비교할 때 사용되는 연산자
    
     - IS NULL : 컬럼 값이 NULL 값인지 비교
     - IS NOT NULL : 컬럼값이 NULL 값이 아닌지 비교

*/

-- 보너스를 받지 않는 사원들의 사번, 사원명, 급여, 보너스 조회
-- > BONUS 컬럼의 값이 NULL인 사원 

SELECT * FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 보너스를 받는 사원들의 사번, 사원명, 급여, 보너스 조회
-- => BONUS 컬럼의 값이 NULL이 아닌 사원
SELECT * FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL; -- 이렇게도 가능

-- 사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서 배치를 받지 않았지만, 보너스를 받고 있는 사원의 사원명, 보너스, 부서코드 조회
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- =============================================================================
-- 직급코드가 'J7'이거나 'J2'인 사원들 중 급여가 200만원 이상인 사원의 모든 정보를 조회
SELECT * FROM EMPLOYEE;

SELECT * 
FROM EMPLOYEE
-- WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND salary >= 2000000; -- 원하는 결과가 표시되지 않음!
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND salary >= 2000000;
-- WHERE JOB_CODE IN('J7','J2') AND salary >= 2000000;

/*
   * 연산자 우선순위
    (0) ()
    (1) 산술 연산자 : * / + -
    (2) 연결 연산자 : ||
    (3) 비교 연산자 : > < >= <= = != <> ^=
    (4) IS NULL / LIKE '패턴' / IN
    (5) BETWEEN AND 
    (6) NOT 
    (7) AND 
    (8) OR 
    
*/
-- =============================================================================

/* 
    * 정렬 : ORDER BY 
         => SELECT문에서 가장 마지막 줄에 작성
         => 실행 순서 또한 마지막에 실행
         
    [표현식]
         (3) SELECT 조회할 컬럼, ...
         (1) FROM 테이블명
         (2) WHERE 조건식
         (4) ORDER BY 정렬 기준이 되는 컬럼 | 별칭 | 컬럼순번 [ASC|DESC] [NULLS FIRST |NULLS LAST]
         
         * ASC : 오름차순 정렬 (기본값)
         * DESC : 내림차순 정렬
         
         * NULLS FIRST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 맨 앞에 배치 (DESC인 경우 기본값)
         * NULLS LAST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 맨 뒤에 배치
           --> NULL 값을 큰 값으로 분류하여 정렬!
*/ 

-- 모든 사원의 사원명, 연봉 조회 (연봉별 내림차순 정렬)
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, SALARY *12 연봉
FROM EMPLOYEE
-- ORDER BY SALARY;
--ORDER BY 연봉 ;  
ORDER BY 2 ;  -- 컬럼 순번 사용 (* 오라클에서는 순서가 1부터 시작!)


-- 보너스 기준으로 정렬
SELECT * FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; -- 기본값 (ASC, NULLS LAST)
-- ORDER BY BONUS ASC;
-- ORDER BY BONUS ASC NULLS LAST;
-- ORDER BY BONUS DESC; -- DESC 일 때 NULLS FIRST 기본값
ORDER BY BONUS DESC, SALARY ASC ; 
-- 보너스 컬럼을 내림차순 정렬, 급여 컬럼을 오름차순 정렬
-- => 보너스 값을 내림차순 정렬하는데 보너스 값이 같은 값일 경우 급여의 값을 오름차순 정렬

