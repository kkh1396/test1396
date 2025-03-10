/*
    * 서브쿼리 (SUBQUERY)
    : 하나의 쿼리문 내에 포함된 또 다른 쿼리문
      메인 역할을 하는 쿼리문을 위해 보조 역할을 하는 쿼리문
    
*/

-- "노옹철" 사원과 같은 부서에 속한 사원 정보를 조회

-- 1) 노옹철 사원의 부서코드 조회

SELECT * FROM EMPLOYEE;

SELECT * 
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';
--> D9

-- 2) 부서코드가 'D9'인 사원 정보 조회

SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';


-- 위의 두 쿼리문을 하나로 합쳐보자!

SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');


-- 전체 사원의 평균 급여보다 더 많은 급여를 받는 사원의 정보 조회

SELECT * FROM EMPLOYEE
WHERE SALARY > (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);

SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE;


---------------------------------------------------------------------------

/*
    * 서브 쿼리 종류 *
      서브쿼리를 수행한 결과값이 몇 행 몇 열로 나오냐에 따라 분류
      
    - 단일행 서브쿼리 : 서브쿼리의 결과가 오로지 1개일 떄 (1행 1열)
    - 다중열 서브쿼리 : 서브쿼리의 결과가 여러개일 떄 (N행 1열)
    - 다중행 서브쿼리 : 서브쿼리의 결과가 한 행이고 여러 개의 열(컬럼)일 때 (1행 N열)
    
    
    >> 종류에 따라 서브쿼리 앞에 붙는 연산자가 달라짐!
*/

-- * 단일행 서브쿼리
-- >> 일반적인 비교연산자 사용 가능 : = != > < >= ..

-- 전 사원의 평균 급여보다 더 적게 급여를 받는 사원들의 사원명, 직급코드, 급여를 조회

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);



-- 급여가 가장 적은 사원의 사원명, 직급코드, 급여를 조회

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);


-- 노옹철 사원의 급여보다 많이 받는 사원의 사원명, 부서코드, 급여 조회

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE
                 WHERE EMP_NAME = '노옹철'   );



-- 위 조건에서 부서코드를 부서명으로 조회하고자 한다면?



-- * 오라클 구문 *

SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID
      AND SALARY > (SELECT SALARY FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철'   );
        


-- * ANSI 구문 *
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
   JOIN department ON DEPT_CODE = DEPT_ID
        WHERE SALARY > (SELECT SALARY FROM EMPLOYEE
                            WHERE EMP_NAME = '노옹철'   );
                            
-- 부서별 급여합이 가장 큰 부서의 부서코드, 급여합을 조회


SELECT * FROM EMPLOYEE;


SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                    GROUP BY DEPT_CODE);


-- 전지연 사원과 같은 부서의 사원들의 사번, 사원명, 연락처, 입사일, 부서명을 조회
-- (단, 전지연 사원은 제외하고 조회!)


-- * 오라클 구문 *
SELECT * FROM EMPLOYEE;

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '전지연';


SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
      AND DEPT_CODE = (SELECT DEPT_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '전지연')
      AND  EMP_NAME <> '전지연';
      
      
-- * ANSI *

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE = (SELECT DEPT_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '전지연')
      AND  EMP_NAME <> '전지연';




---------------------------------------------------------------------------


/*

    다중행 서브쿼리 : 서브쿼리 결과가 여러 행인 경우 (N행 1열)
    
    IN (서브쿼리) : 여러 개의 결과값 중에 하나라도 일치하는 값이 있을 경우 
    
     > ANY (서브쿼리) : 여러 개의 결과값 중에서 하나라도 큰 경우가 있다면 조회
     < ANY (서브쿼리) : 여러 개의 값중 하나라도 작은 경우가 있다면 조회
          * 비교대상 > 결과값1 OR 비교대상 > 결과값2 OR 비교대상> 결과값...
          
     > ALL (서브쿼리) : 여러 개의 모든 결과값보다 클 경우 조회 
     < ALL (서브쿼리) : 여러 개의 모든 결과값보다 작을 경우 조회
         * 비교대상 < 결과값1 AND 비교대상 < 결과값2 AND 비교대상 < 결과값...
*/

-- 유재식 사원 또는 윤은해 사원과 같은 직급인 사원들의 정보 조회 (사번/사원명/직급코드/급여)
-- 1) 유재식 사원 또는 윤은해 사원의 직급코드 조회 

SELECT JOB_CODE
FROM EMPLOYEE
-- WHERE EMP_NAME = '유재식' OR EMP_NAME = '윤은해';
WHERE EMP_NAME IN ('유재식', '윤은해');
-- > J3 J7

--2 직급코드가 'J3' 'J7' 인 사원들의 정보 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3','J7');

-- > 서브쿼리 적용하기

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                        WHERE EMP_NAME IN ('유재식', '윤은해'));

-- 대리직급인 사원들 중 과장 직급의 최소 급여보다 많이 받는 사원 정보 조회

SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;


-- 1) 과장 직급의 정보
SELECT * 
FROM EMPLOYEE E 
     JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME='과장';
      
-- 2) ANY 연산자 사용하여 비교

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (3760000, 2200000, 2500000)
      AND JOB_NAME = '대리';


SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (
SELECT SALARY
FROM EMPLOYEE E, JOB J
    WHERE E.JOB_CODE = J.JOB_CODE
          AND JOB_NAME = '과장'
        )
      AND JOB_NAME = '대리';


---------------------------------------------------------------------------
/*
        다중열 서브쿼리 : 서브쿼리 결과가 1개 행이고, 여러 개의 열(컬럼)인 경우

*/
-- 하이유 사원과 같은 부서, 같은 직급인 사원 정보를 조회
-- 1) 하이유 사원의 부서코드, 직급코드 조회

SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';


-- * 단일행 서브쿼리를 사용 *
SELECT * FROM  EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');
    
-- * 다중열 서브쿼리를 사용 *
SELECT EMP_NAME, DEPT_CODE, JOB_CODE , SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE 
                                    FROM EMPLOYEE WHERE EMP_NAME = '하이유');
                                    
-- 박나라 사원과 직급이 같고, 사수가 동일한 사원의 사원명, 직급코드, 사수번호를 조회

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID 
                                 FROM EMPLOYEE WHERE EMP_NAME ='박나라')
        AND EMP_NAME <> '박나라';


---------------------------------------------------------------------------

/*
    * 다중행 다중열 서브쿼리 : 서브쿼리의 결과가 여러 행, 여러 열(컬럼)인 경우
*/
-- 각 직급별 최소급여를 받는 사원 정보를 조회

SELECT * 
FROM EMPLOYEE 
WHERE (JOB_CODE ,SALARY) IN (SELECT JOB_CODE ,MIN(SALARY)
                                    FROM EMPLOYEE 
                                    GROUP BY JOB_CODE);



---------------------------------------------------------------------------


/*
    * 인라인 뷰 : 서브쿼리를 FROM절에 사용하는것
                 => 서브쿼리의 결과를 마치 테이블처럼 사용하는 것
*/
-- 사번, 이름, 보너스 포함 연봉, 부서코드를 조회 
-- (단, 보너스 포함 연봉의 결과가 NULL이 아니고
--      보너스 포함 연봉이 3000만원 이상인 사원들만 조회할 것)


SELECT EMP_ID, EMP_NAME, (SALARY + ( SALARY * NVL(BONUS,0) ))*12 보너스포함, DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + ( SALARY * NVL(BONUS,0)))*12 >= 30000000
ORDER BY 3 DESC;

--> 상위 N개를 조회 : "TOP-N분석"
--     => ROWNUM : 조회된 행에 대하여 순서대로 1부터 순번을 부여해주는 가상 컬럼
SELECT EMP_ID, EMP_NAME, 보너스포함, DEPT_CODE FROM
(
    SELECT EMP_ID, EMP_NAME, (SALARY + ( SALARY * NVL(BONUS,0) ))*12 보너스포함, DEPT_CODE
    FROM EMPLOYEE
    WHERE (SALARY + ( SALARY * NVL(BONUS,0)))*12 >= 30000000
    ORDER BY 3 DESC
) 
WHERE ROWNUM <= 5;
--> 보너스 포함 연봉이 높은 5명의 사원을 조회 

--> 가장 최근에 입사한 사원 5명 조회
SELECT * 
FROM EMPLOYEE WHERE ROWNUM <=5
ORDER BY HIRE_DATE DESC;


---------------------------------------------------------------------------
/*
     * 순서를 매기는 함수 (WINDOW FUNCTION)
     
     - RANK() OVER(정렬기준)        : 동일한 순위 이후에 등수를 동일한 수만큼 건너뛰고 순위 계산
     - DENSE_RANK() OVER(정렬기준)  : 동일한 순위가 있더라도 그 다음 등수를 + 해서 계산
     
      => SELECT절 에서만 사용 가능!

*/
-- 급여가 높은 순서대로 순위를 매겨서 조회
SELECT EMP_NAME, SALARY, 
      RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;
-- > 공동 19위인 2명이 있고, 그 뒤의 순위는 21위로 표시됨

SELECT EMP_NAME, SALARY, 
      DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;

-- * 상위 5명만 조회 
SELECT EMP_NAME, SALARY, 
      RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE WHERE ROWNUM <= 5;


-- * 상위 3 ~ 5 등 조회

SELECT * FROM ( 
        SELECT EMP_NAME, SALARY, 
            RANK() OVER(ORDER BY SALARY DESC) "순위"
                FROM EMPLOYEE WHERE ROWNUM <= 5

)
WHERE 순위 BETWEEN 3 AND 5;



---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- 1) ROWNUM을 활용하여 급여가 가장 높은 5명을 조회하려 했으나, 제대로 조회되지 않았다.

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE

ORDER BY SALARY DESC;


SELECT EMP_NAME, SALARY 
FROM (
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE 
    ORDER BY SALARY DESC
)
WHERE ROWNUM < 6;

-- 내가 한거
-- 문제점(원인) :       급여값은 높으나 ROWNUM <5 라는 조건에서 ROWNUM이 높은 값들은 제외
-- 해결방안(조치내용) :  기존 쿼리를 인라인뷰로 재정의 후 거기서 5명 이내로 ROWNUM 조건을 준다

-- 강사님 한거
-- 문제점(원인) :       정렬되기 전에 5명이 추려졌다. ROWNUM에 의해 순서는 정렬 전에 부여됨
-- 해결방안(조치내용) :  





-- 2) 부서별 평균급여가 270만원을 초과하느 부서에 해당하는 부서코드, 부서별 총 급여합,
--           부서별 평균급여, 부서별 사원 수를 조회하려 했으나, 제대로 조회가 되지 않았다.

SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균
        ,COUNT(*) 사원수
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


SELECT DEPT_CODE, FLOOR(AVG(SALARY) ), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균
        ,COUNT(*) 사원수
FROM EMPLOYEE
--WHERE SALARY > ANY (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE )
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

-- 또는

SELECT *
FROM (
    SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균
        ,COUNT(*) 사원수
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
WHERE 평균 > 2700000;



-- 문제점(원인) :      부서별 평균급여가 아닌 사원 개개인의 급여를 조건으로 제시되었따. 
-- 해결방안(조치내용)   



