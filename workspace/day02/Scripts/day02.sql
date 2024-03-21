-- 주석
-- 대소문자를 구분하지 않는다.
-- 일반적으로 오라클은 대문자로 작업하는 경우가 많다.
SELECT * FROM EMPLOYEES;


-- SELECT를 사용하여 EMPLOYEES 테이블의
-- FIRST_NAME 컬럼과 LAST_NAME 컬럼을 선택하여 조회해보자.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES;

-- [실습]
-- 직원의 성, 이름, 휴대전화번호, 이메일주소, 사원번호를 한 번에 조회하기
-- 순서대로 조회되어야 함.
SELECT LAST_NAME,FIRST_NAME, PHONE_NUMBER, EMAIL, EMPLOYEE_ID 
FROM EMPLOYEES;

SELECT * FROM EMPLOYEES;

-- 정렬해서 조회하기
-- 0RDER BY 절
-- 사원의 이름, 성, 봉급을 낮은 순서부터 조회(오름차순)
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES
ORDER BY SALARY ASC; --ASCENDING
-- ORDER BY 정렬하겠다! SALARY 기준 ASC 오름차순!

SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES
ORDER BY SALARY DESC; --DESCENDING

-- 직원의 이름, 성, 고용일, 고용일 순서로 정렬
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
ORDER BY HIRE_DATE DESC;


-- 직원의 이름 순서로 정렬
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
ORDER BY FIRST_NAME;

-- 
SELECT FIRST_NAME, SALARY, HIRE_DATE 
FROM EMPLOYEES
ORDER BY SALARY, FIRST_NAME DESC;

-- 조회하는 컬럼이 아닐지라도
-- 정렬하는 기준으로 삼을 수 있다.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
ORDER BY SALARY;

-------------------------------------------
-- 중복제거
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

SELECT JOB_ID, COUNT(*)
FROM
	(SELECT DISTINCT JOB_ID, HIRE_DATE
	FROM EMPLOYEES)
GROUP BY JOB_ID 

-- 별칭 부여하기, 별명 붙이기
SELECT FIRST_NAME AS "이름", -- ALIAS 알리아스 / 'AS' 생략 가능함
	LAST_NAME 성,
	SALARY AS 봉급,
	EMPLOYEE_ID 사원번호
FROM EMPLOYEES;

-------------------------------------------

-- SELECT 절에서 조회하는 컬럼의 순서에 맞게 번호가 매겨진다.
-- 1부터 순차적으로 부여.
-- 컬럼에 부여된 별명으로 정렬도 가능하다.
SELECT FIRST_NAME 이름,
	SALARY 봉급,
	HIRE_DATE 고용일 
FROM EMPLOYEES
ORDER BY 봉급, FIRST_NAME DESC, 3;


