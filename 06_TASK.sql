-- EX.1

SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY AS "계열"
FROM TB_DEPARTMENT TD;


-- EX.2

SELECT DEPARTMENT_NAME || '의 정원은 ' || 
CAPACITY || ' 명 입니다.' AS "학과별 정원"
FROM TB_DEPARTMENT TD;

-- EX 3
SELECT STUDENT_NAME
FROM TB_DEPARTMENT TD
NATURAL JOIN TB_STUDENT TS
WHERE ABSENCE_YN = 'Y'
AND DEPARTMENT_NO = 001
AND SUBSTR(STUDENT_SSN, 8, 1) = '2';

-- EX 4

SELECT STUDENT_NAME
FROM TB_STUDENT TS
WHERE SUBSTR(STUDENT_NO, 2) = 513079
OR SUBSTR(STUDENT_NO, 2) = 513090
OR SUBSTR(STUDENT_NO, 2) = 513091
OR SUBSTR(STUDENT_NO, 2) = 513110
OR SUBSTR(STUDENT_NO, 2) = 513119;

-- EX 5

SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT TD
WHERE CAPACITY BETWEEN 20 AND 30;

-- EX 6

SELECT PROFESSOR_NAME
FROM TB_PROFESSOR TP
WHERE DEPARTMENT_NO IS NULL;

-- EX 7

SELECT STUDENT_NAME
FROM TB_STUDENT TS
WHERE DEPARTMENT_NO IS NULL;


-- EX 8

SELECT CLASS_NO
FROM TB_CLASS TC
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- EX 9

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT TD
ORDER BY 1;

-- EX 10

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT TS
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)  = '2002'
AND STUDENT_ADDRESS LIKE '전주%'
AND ABSENCE_YN = 'N';

-- FUNCTION EX1

SELECT STUDENT_NO AS 학변, STUDENT_NAME AS 이름, 
TO_CHAR(ENTRANCE_DATE, 'YYYY"-"MM"-"DD') AS 입학년도
FROM TB_STUDENT TS
WHERE DEPARTMENT_NO = 002
ORDER BY 3;

-- FUNCTION EX2

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR TP
WHERE PROFESSOR_NAME NOT LIKE '___';

-- FUNCTION EX3

SELECT PROFESSOR_NAME 교수이름, TO_CHAR(SYSDATE, 'YYYY') -
(1900 + SUBSTR(PROFESSOR_SSN, 1, INSTR(PROFESSOR_SSN, '-') - 5 )) 나이
FROM TB_PROFESSOR TP
WHERE SUBSTR(PROFESSOR_SSN, 8, INSTR(PROFESSOR_SSN, '-') - 6 ) = 1
ORDER BY 2;

-- 풀이
SELECT PROFESSOR_NAME 교수이름,
FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(19 || SUBSTR(PROFESSOR_SSN, 1, 6))) / 12) 나이
FROM TB_PROFESSOR TP
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 2; 


SELECT PROFESSOR_NAME,
TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6))
FROM TB_PROFESSOR TP
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'; 


-- FUNCTION EX4

SELECT SUBSTR(PROFESSOR_NAME, 2, 3)
FROM TB_PROFESSOR TP;

-- FUNCTION EX5

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT TS
WHERE (SUBSTR(STUDENT_SSN, 8, INSTR(STUDENT_SSN, '-') - 6 ) = 1 
OR SUBSTR(STUDENT_SSN, 8, INSTR(STUDENT_SSN, '-') - 6 ) = 2)
AND TO_CHAR(ENTRANCE_DATE , 'YYYY') -
(1900 + SUBSTR(STUDENT_SSN , 1, INSTR(STUDENT_SSN, '-') - 5 )) > 19;

-- 풀이

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT TS 
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - 
EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) > 19;


SELECT *
FROM TB_STUDENT TS
WHERE STUDENT_NAME = '김계영';

-- FUNCTION EX 6

SELECT TO_CHAR( TO_DATE('2020-12-25'), 'YYYY"년" MM"월" DD"일" (DY)') 
FROM DUAL;

-- FUNCTION EX 7

SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'), 'YYYY"년" MM"월" DD"일"')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'), 'YYYY"년" MM"월" DD"일"')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYY"년" MM"월" DD"일"')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYY"년" MM"월" DD"일"')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('51/10/11', 'RR/MM/DD'), 'YYYY"년" MM"월" DD"일"')
FROM DUAL;

SELECT TO_DATE('49/10/11', 'RR/MM/DD')
FROM DUAL;

-- FUNCTION EX 8

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT TS
WHERE STUDENT_NO NOT LIKE 'A%';

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT TS
WHERE TO_CHAR(TO_DATE(ENTRANCE_DATE, 'RR/MM/DD'), 'YYYY') < 2000;

-- FUNCTION EX 9

SELECT ROUND(AVG(POINT), 1) AS 평점
FROM TB_STUDENT TS
JOIN TB_GRADE TG USING (STUDENT_NO)
WHERE STUDENT_NO = 'A517178';

-- FUNCTION EX 10

SELECT DEPARTMENT_NO 학과번호, COUNT(DEPARTMENT_NO) "학생수(명)"
FROM TB_STUDENT TS
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 풀이

SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM TB_STUDENT TS
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- FUNCTION EX 11

SELECT COUNT(*)
FROM TB_STUDENT TS
WHERE COACH_PROFESSOR_NO IS NULL;

-- FUNCTION EX 12

SELECT SUBSTR(TERM_NO, 1, 4) 년도, ROUND(AVG(POINT), 1) "년도 별 평점"
FROM TB_STUDENT TS
JOIN TB_GRADE TG USING (STUDENT_NO)
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

-- 풀이
SELECT SUBSTR(TERM_NO, 1, 4) 년도, ROUND(AVG(POINT), 1) "년도 별 평점"
FROM TB_GRADE TG
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 년도;

-- FUNCTION EX 13

SELECT DEPARTMENT_NO 학과코드명, 
SUM(DECODE(ABSENCE_YN, 'Y', 1, 'N', 0)) "휴학생 수"
FROM TB_STUDENT TS
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 풀이

SELECT DEPARTMENT_NO 학과코드명, 
COUNT(DECODE(ABSENCE_YN, 'Y', 1)) "휴학생 수"
FROM TB_STUDENT TS
GROUP BY DEPARTMENT_NO
ORDER BY 1;


-- FUNCTION EX 14

SELECT STUDENT_NAME 동일이름, COUNT(STUDENT_NAME) "동명인 수"
FROM TB_STUDENT TS
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NAME) > 1;

-- 풀이

SELECT STUDENT_NAME 동일이름, COUNT(*) "동명인 수"
FROM TB_STUDENT TS
GROUP BY STUDENT_NAME
HAVING COUNT(*) >= 2
ORDER BY 1;


-- FUNCTION EX 15

-- 오답
SELECT SUBSTR(TERM_NO, 1, 4) 년도, SUBSTR(TERM_NO, 5, 2) 학기, ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE TG
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY 1;

-- 풀이
SELECT NVL(SUBSTR(TERM_NO, 1, 4), ' ') 년도,
NVL(SUBSTR(TERM_NO, 5, 2), ' ') 학기,
ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE TG
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2);
--> ORDER BY절에 함수 작성 가능!

SELECT *
FROM TB_STUDENT TS;

SELECT *
FROM TB_DEPARTMENT TD

-- SELECT EX 1

SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS 주소지
FROM TB_STUDENT TS
ORDER BY "학생 이름";

-- SELECT EX 2

SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT TS
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

-- SELECT EX 3

SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT TS
WHERE (SUBSTR(STUDENT_ADDRESS, 1, 3) = '강원도'
OR SUBSTR(STUDENT_ADDRESS, 1, 3) = '경기도')
AND EXTRACT(YEAR FROM ENTRANCE_DATE) < 2000
ORDER BY 학생이름;

-- SELECT EX 4

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR TP 
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

-- SELECT EX 5

SELECT STUDENT_NO, TO_CHAR(POINT, 'FM9.00') 
FROM TB_STUDENT TS
JOIN TB_GRADE TG USING (STUDENT_NO)
WHERE TERM_NO = '200402'
AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

-- SELECT EX 6

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT TS
JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

-- SELECT EX 7

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_DEPARTMENT TD
JOIN TB_CLASS TC USING (DEPARTMENT_NO);

-- SELECT EX 8

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS TC
JOIN TB_CLASS_PROFESSOR TCP USING (CLASS_NO)
JOIN TB_PROFESSOR TP USING (PROFESSOR_NO);

SELECT *
FROM TB_CLASS TC
JOIN TB_CLASS_PROFESSOR TCP USING (CLASS_NO)
JOIN TB_PROFESSOR TP USING (PROFESSOR_NO);

-- SELECT EX 9

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_DEPARTMENT TD
JOIN TB_CLASS TC USING (DEPARTMENT_NO)
JOIN TB_CLASS_PROFESSOR TCP USING (CLASS_NO)
JOIN TB_PROFESSOR TP USING (PROFESSOR_NO)
WHERE CATEGORY = '인문사회';

SELECT *
FROM TB_DEPARTMENT TD
JOIN TB_CLASS TC USING (DEPARTMENT_NO)
JOIN TB_CLASS_PROFESSOR TCP USING (CLASS_NO)
JOIN TB_PROFESSOR TP USING (PROFESSOR_NO)
WHERE CATEGORY = '인문사회'
ORDER BY TP.DEPARTMENT_NO;

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS TC
JOIN TB_CLASS_PROFESSOR TCP USING (CLASS_NO)
JOIN TB_PROFESSOR TP USING (PROFESSOR_NO)
JOIN TB_DEPARTMENT TD ON (TD.DEPARTMENT_NO = TC.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회';

-- SELECT EX 10

SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT TS
LEFT JOIN TB_GRADE TG USING (STUDENT_NO)
WHERE DEPARTMENT_NO = '059'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 학번;

-- SELECT EX 11

SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT TS
NATURAL JOIN TB_DEPARTMENT TD
JOIN TB_PROFESSOR TP ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- SELECT EX 12

SELECT STUDENT_NAME, TERM_NO TERM_NAME
FROM TB_STUDENT TS
JOIN TB_GRADE TG USING (STUDENT_NO)
JOIN TB_CLASS TC USING (CLASS_NO)
WHERE CLASS_NAME = '인간관계론'
AND SUBSTR(TERM_NO, 1 ,4) = 2007
ORDER BY TERM_NAME, STUDENT_NAME;

-- SELECT EX 13

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS TC
JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR TCP USING (CLASS_NO)
WHERE CATEGORY = '예체능'
AND PROFESSOR_NO IS NULL;

-- SELECT EX 14

SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT TS
JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR TP ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE DEPARTMENT_NAME = '서반아어학과';

-- SELECT EX 15

SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME "학과 이름", AVG(POINT) 평점
FROM TB_STUDENT TS
JOIN TB_GRADE TG USING (STUDENT_NO)
JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0
ORDER BY 1;

-- SELECT EX 16

SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_CLASS TC
JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
JOIN TB_GRADE TG USING (CLASS_NO)
WHERE DEPARTMENT_NAME = '환경조경학과'
AND SUBSTR(CLASS_TYPE, 1, 2) = '전공'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

-- SELECT EX 17

SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT TS
JOIN TB_DEPARTMENT TD2 USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = (
SELECT DEPARTMENT_NAME
FROM TB_STUDENT TS
JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
WHERE STUDENT_NAME = '최경희'
);

-- SELECT EX 18

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT TS
JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
JOIN TB_GRADE TG USING (STUDENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (
SELECT MAX(AVG(POINT))
FROM TB_STUDENT TS
JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
JOIN TB_GRADE TG USING (STUDENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME
);

-- SELECT EX 19

FROM 
































