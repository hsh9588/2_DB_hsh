-- 함수 : 컬럼의 값을 읽어서 연산한 결과를 반환

-- 단일 행 함수 : N개의 값을 읽어 N개의 결과를 반환

-- 그룹 함수 : N개의 값을 읽어 1개의 결과를 반환(합계, 평균, 최대, 최소)

-- 함수는 SELECT문의
-- SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절 사용 가능

----------------------------  단일 행 함수 ----------------------------

-- LENGTH (컬럼명 | 문자열) : 길이 반환
SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-----------------------------------------------------------------------

-- INSTR (컬럼명 | 문자열, '찾을 문자열'[, 찾기 시작할 위치 [,순번] ] )
-- 지정한 위치부터 지정한 순번째로 검색되는 문자의 위치를 반환

-- 문자열을 앞에서 부터 검색하여 첫 번째 B 위치 조회
SELECT INSTR('AABAACAABBAA', 'B')
FROM DUAL;

-- 문자열을 5번째 문자 부터 검색하여 첫 번째 B 위치 조회
SELECT INSTR('AABAACAABBAA', 'B', 5)
FROM DUAL;

-- 문자열을 5번째 문자 부터 검색하여 두 번째 B 위치 조회
SELECT INSTR('AABAACAABBAA', 'B', 5, 2)
FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 이메일, 이메일 중 '@(at)' 위치 조회
SELECT  EMP_NAME, EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- SUBSTR('문자열' | 컬럼명, 잘라내기 시작할 위치 [, 잘라낼 길이]  )
-- 컬럼이나 문자열에서 지정한 위치부터 지정된 길이만큼 문자열을 잘라내서 반환
--> 잘라낼 길이 생략 시 끝까지 잘라냄

-- EMPOYEE 테이블에서 사원명, 이메일 중 아이디만 조회
SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1 ) AS 아이디
FROM EMPLOYEE;

-----------------------------------------------------------------------

-- TRIM( [[옵션] '문자열' | 컬럼명 FROM ]'문자열'|컬럼명  )
-- 주어진 컬럼이나 문자열의 앞, 뒤, 양쪽에 있는 지정된 문자를 제거
--> (보통 양쪽 공백 제거에 많이 사용)

-- 옵션 :  LEADING(앞쪽), TRAILING(뒤쪽), BOTH(양쪽, 기본값)

SELECT TRIM('     H E L L O     ')
FROM DUAL; -- 양쪽 공백 제거

SELECT TRIM('#' FROM '#####안녕#####') AS 잘가
FROM DUAL;

/* 숫자 관련 함수 */

-- ABS(숫자 | 컬럼명) : 절대 값

SELECT ABS(10), ABS(-10)
FROM DUAL;

SELECT '절대값 같음'
FROM DUAL
WHERE ABS(10) = ABS(-10); -- WHERE절 함수 작성 가능

-- MOD(숫자 | 컬럼명  ,  숫자 | 컬럼명) : 나머지 값 반환
-- EMPLOYEE 테이블에서 사원의 월급을 100만으로 나눴을 때 나머지 조회

SELECT EMP_NAME, SALARY, MOD(SALARY, 1000000)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사번이 짝수인 사원의 사번, 이름 조회
SELECT EMP_NAME, EMP_ID
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 0;

-- EMPLOYEE 테이블에서 사번이 홀수인 사원의 사번, 이름 조회
SELECT EMP_NAME, EMP_ID
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) <> 0; -- <>, != 같지 않다 

-- ROUND(숫자 | 컬럼명 [,소수점 위치]) : 반올림

SELECT ROUND (123.456) -- 123, 소수점 첫 번째 자리에서 반올림 
FROM DUAL;

SELECT ROUND (123.456, 1) -- 123.5, 소수점 두 번째 자리에서 반올 
FROM DUAL;				  --> 두 번째 자리에서 반올림해서
						  -- 소수점 한 자리만 표현

SELECT ROUND (123.456, 0) -- 123, 소수점 첫 번째 자리에서 반올림( 0 기본값 ) 
FROM DUAL;

SELECT ROUND (123.456, -1) -- 120, 소수점 0 번째 자리에서 반올림해서
FROM DUAL;				   -- 소수점 -1 자리 표현
						   -- == 1의 자리에서 반올림해서 10의 자리부터 표현

SELECT ROUND (123.456, -2) -- 10의 자리에서 반올림해서 100의 자리부터 표현
FROM DUAL;

-- CEIL(숫자 | 컬럼명) : 올림
-- FLOOR(숫자 | 컬럼명) : 내림
--> 둘다 소수점 첫째 자리에서 올림/내림 처리

SELECT CEIL(123.1), FLOOR(123.1) FROM DUAL;
--			124			  123

-- TRUNC(숫자 | 컬럼명 [,위치]) : 특정 위치 아래를 버림(절삭)

SELECT TRUNC(123.456) FROM DUAL; -- 123, 소수점 아래 버림 

SELECT TRUNC(123.456, 1) FROM DUAL; -- 123.4, 소수점 첫째 자리 아래 버림 

SELECT TRUNC(123.456, -1) FROM DUAL; -- 12, 10의 자리 아래 버림

/* 버림, 내림 차이점 */

SELECT FLOOR(-123.5), TRUNC(-123.5) FROM DUAL;
--			 -124			-123
 
----------------------------------------------------------------------------------

/* 날짜(DATE) 관련 함수 */

-- SYSDATE : 시스템에 현재 시간(년,월,일,시,분,초)을 반환
SELECT SYSDATE FROM DUAL;

-- SYSTIMESTAMP : SYSDATE + MS 단위 추가
SELECT SYSTIMESTAMP FROM DUAL;
-- TIMESTAMP : 특정 시간을 나타내거나 기록하기 위한 문자열

-- MONTHS_BETWEEN(날짜, 날짜) : 두 날짜의 개월 수 차이 반환
SELECT ROUND(MONTHS_BETWEEN(SYSDATE, '2022-08-04'), 3) AS "수강 기간(개월)"
FROM DUAL;

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무한 개월 수, 근무 년차 조회

SELECT EMP_NAME, HIRE_DATE,
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "근무한 개월 수",
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) || '년차' AS "근무 년차"
FROM EMPLOYEE;

/* || : 연결 연산자(문자열 이어쓰기) */

-- ADD_MONTHS(날짜 , 숫자) : 날짜에 숫자만큼의 개월 수를 더함. (음수도 가능)

SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;

SELECT ADD_MONTHS(SYSDATE, -4) FROM DUAL; 

-- LAST_DAY(날짜) : 해당 달의 마지막 날짜를 구함.

SELECT LAST_DAY(SYSDATE) FROM DUAL; 

SELECT LAST_DAY('2022-02-01') FROM DUAL; -- 

-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월만 추출
-- EXTRACT(DAY FROM 날짜) : 일만 추출




---------------------------------------------------------------------------------

/* 형변환 함수 */
-- 문자열(CHAR), 숫자(NUMBER), 날짜(DATE) 끼리 형변환 가능


/* 문자열로 변환 */
-- TO_CHAR(날짜, [포맷]) : 날짜형 데이터를 문자형 데이터로 변경
-- TO_CHAR(숫자, [포맷]) : 숫자형 데이터를 문자형 데이터로 변경

-- <숫자 변환 시 포맷 패턴>
-- 9 : 숫자 한칸을 의미, 여러 개 작성 시 오른쪽 정렬
-- 0 : 숫자 한칸을 의미, 여러 개 작성 시 오른쪽 정렬 + 빈칸 0 추가
-- L : 현재 DB에 설정된 나라의 화폐 기호



-- <날짜 변환 시 포맷 패턴>
-- YYYY : 년도 / YY : 년도 (짧게)
-- RRRR : 년도 / RR : 년도 (짧게)
-- MM : 월  // DD : 일
-- AM 또는 PM : 오전/오후 표시
-- HH : 시간   /  HH24 : 24시간 표기법
-- MI : 분  /  SS : 초
-- DAY : 요일(전체)  /  DY : 요일(요일명만 표시)



--------------------------------------------------------------------------------

/* 날짜로 변환 TO_DATE */
-- TO_DATE(문자형 데이터, [포맷]) : 문자형 데이터를 날짜로 변경
-- TO_DATE(숫자형 데이터, [포맷]) : 숫자형 데이터를 날짜로 변경
--> 지정된 포맷으로 날짜를 인식함


---------------------------------------------------------------------------------

/* 숫자 형변환 */
-- TO_NUMBER(문자데이터, [포맷]) : 문자형데이터를 숫자 데이터로 변경



---------------------------------------------------------------------------------

/* NULL 처리 함수 */

-- NVL(컬럼명, 컬럼값이 NULL일때 바꿀 값) : NULL인 컬럼값을 다른 값으로 변경


-- NVL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼의 값이 있으면 바꿀값1로 변경,
-- 해당 컬럼이 NULL이면 바꿀값2로 변경





