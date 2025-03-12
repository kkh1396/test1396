-- KH_연습문제
-- 1. 2025년 12월 25일의 요일 조회

SELECT  TO_CHAR(TO_DATE(20251225, 'YYMMDD'), 'YYMMDD DAY') FROM DUAL;
-- 목요일

-- 2. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과, 주민번호, 부서명, 직급 조회

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE  E.DEPT_CODE = D.DEPT_ID
      AND E.JOB_CODE = J.JOB_CODE
      AND SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79
      AND SUBSTR(EMP_NO,8,1) IN '2';
      
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE  
      JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
      JOIN JOB USING (JOB_CODE)
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79
      AND SUBSTR(EMP_NO,8,1) IN '2';
      
      
-- 3. 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

-- 215, 대북현,00 37
SELECT EMP_ID "사원 코드" , EMP_NAME 이름 
            , EXTRACT(YEAR FROM SYSDATE) -   EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2), 'RR') ) 나이
FROM EMPLOYEE E, DEPARTMENT , JOB J
WHERE DEPT_CODE = DEPT_ID
      AND HIRE_DATE = (SELECT MAX(HIRE_DATE )  FROM EMPLOYEE)
      AND E.JOB_CODE = J.JOB_CODE;
      
-- 나이
SELECT  EXTRACT(YEAR FROM SYSDATE) -   EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2), 'RR') ) FROM EMPLOYEE;

-- 가장 막내
SELECT MAX(HIRE_DATE )  FROM EMPLOYEE;

-- 4. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID
      AND EMP_NAME LIKE '%형%';
-- 211 전형돈 기술지원부


-- 5. 부서 코드가 D5이거나 D6인 사원의 사원 명, 직급, 부서 코드, 부서 명 조회

 SELECT * FROM EMPLOYEE;
 SELECT * FROM JOB;
 
 SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
 FROM EMPLOYEE
       JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
       JOIN JOB USING (JOB_CODE)
 WHERE  DEPT_CODE IN ('D5','D6');
 
-- 6. 보너스를 받는 사원의 사원 명, 보너스, 부서 명, 지역 명 조회

SELECT * FROM EMPLOYEE;

SELECT * FROM LOCATION , NATIONAL ,DEPARTMENT;

SELECT EMP_NAME, BONUS, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE BONUS IS NOT NULL;


-- 7. 사원 명, 직급, 부서 명, 지역 명 조회

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT, JOB;
SELECT * FROM LOCATION, NATIONAL;

SELECT EMP_NAME , JOB_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
   JOIN JOB USING (JOB_CODE)
   JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
   JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
   JOIN NATIONAL USING ( NATIONAL_CODE);

-- 8. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회 

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT, JOB;
SELECT * FROM LOCATION, DUAL  ,NATIONAL;

SELECT EMP_NAME , DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국','일본');


-- 9. 한 사원과 같은 부서에서 일하는 사원의 이름 조회

SELECT * FROM EMPLOYEE;

SELECT E1.EMP_NAME, E1.DEPT_CODE, E2.EMP_NAME
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.DEPT_CODE = E2.DEPT_CODE
      AND E1.EMP_NAME <> E2.EMP_NAME
ORDER BY 1,3  ;

 
-- 10. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급, 급여 조회 (NVL 이용)

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, JOB_NAME ,SALARY
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
     AND E.JOB_CODE IN ('J4','J7')
     AND BONUS IS NULL;

 
-- 11. 퇴사 하지 않은 사람과 퇴사한 사람의 수 조회

SELECT COUNT(*) FROM EMPLOYEE 
GROUP BY ENT_YN;

 
-- 12. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회

SELECT * FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE
            , RANK() OVER( ORDER BY (SALARY + SALARY * NVL(BONUS,0)) *12) 순위
FROM EMPLOYEE 
   JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
   JOIN JOB USING (JOB_CODE)
   WHERE ROWNUM <= 5;
   




-- 보너스 포함 연봉 
SELECT  (SALARY + SALARY * NVL(BONUS,0)) *12 FROM EMPLOYEE;



 
-- 13. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
--	13-1. JOIN과 HAVING 사용

      SELECT *FROM EMPLOYEE;
      SELECT * FROM DEPARTMENT;

       SELECT dept_TITLE,  SUM(SALARY)
       FROM EMPLOYEE
         JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
         GROUP BY DEPT_CODE , DEPT_TITLE
         HAVING SUM(SALARY) > (SELECT SUM(SALARY)  FROM EMPLOYEE) * 0.2;
        
                      
--	13-2. 인라인 뷰 사용

        SELECT dept_TITLE, 합계
          FROM (

                 SELECT dept_TITLE, SUM(SALARY) 합계
                 FROM EMPLOYEE
                 JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                 GROUP BY DEPT_CODE , DEPT_TITLE
                 HAVING SUM(SALARY) > (SELECT SUM(SALARY)  FROM EMPLOYEE) * 0.2
          );
           

              
--	13-3. WITH 사용

 
-- 14. 부서 명과 부서 별 급여 합계 조회


    SELECT dept_TITLE, SUM(SALARY) 합계
                 FROM EMPLOYEE
                 JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                 GROUP BY DEPT_CODE , DEPT_TITLE;
                


