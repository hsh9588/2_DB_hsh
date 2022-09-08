SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, NVL(DEPT_TITLE, '부서없음') DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE E
NATURAL JOIN JOB J 
LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
WHERE NVL(DEPT_TITLE, '부서없음') = '부서없음';


SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, NVL(DEPT_TITLE, '부서없음') DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE E
NATURAL JOIN JOB J 
LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > 30000;

SELECT JOB_NAME, ROUND(AVG(SALARY), 1) AS AVGSALARY 
FROM EMPLOYEE E 
NATURAL JOIN JOB
GROUP BY JOB_NAME;