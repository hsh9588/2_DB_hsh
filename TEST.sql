-- Data
 관찰 결과로 나타난 수, 성질, 성분의 실제 값

-- 정보(Information)
 데이터를 기반으로 의미를 부여한 것이다.

-- DB(DataBase)
 필요한 정보를 공용할 수 있도록 중복되는 데이터를 최소화하여
 통합/저장 해놓은 것이다.

-- DBMS(DataBase Management System)
 데이터 추출,조작,정의,제어 등을 할 수 있게 해주는 데이터베이스 전용 관리 프로그램

-- SQL(Structured Query Language)
 관계형 데이터베이스에서 원하는 데이터를 조회,조작하기 위해 조건을 작성하는 언어

 DQL -> SELECT : 데이터 검색
 DML -> INSERT, UPDATE, DELETE : 데이터 조작
 TCL -> COMMIT, ROLLBACK : 트랙젝션 제어

-- SELECT
 데이터를 조회한 결과를 ResultSet이라고 한다.
 조회된 행들의 집합을 의미한다.
 ResultSet은 0개 이상의 행이 포함될 수 있다.

-- SELECT 작성법
-- SELECT 해석 순서

SELECT 컬럼명	3
FROM 테이블명	1
WHERE 조건식	2
ORDER BY	;	4

-- JOIN

SELECT		6
FROM			1
JOIN			2
WHERE			3
GROUP BY		4
HAVING		5
ORDER BY		7

GROUP BY : 같은 값들이 여러개 기록된 컬럼을 가지고 같은 값들을 하나의 그룹으로 묶음

-- JOIN 종류별 작성법
간단히 내부, 외부, 자연, 교차, 자체 조인이 무엇인지 정의를 작성해보고
어떤 상황에서 
어떤 JOIN 구문을 사용해야 적절할지를 생각해보세요.

JOIN 하나 이상의 테이블에서 데이터를 조회하기 위해 사용한다.
수행 결과는 하나의 RESULT SET으로 나온다.

--내부 조인 
연결되는 컬럼의 값이 일치하는 행들만 조인된다.
일치하지 않은 행은 제외된다.
JOIN TABLENAME ON (COL1 = COL2) -> 컬럼명이 다른 경우
JOIN TABLENAME USING (COL1) -> 컬럼명이 같은 경우

--외부 조인
두 테이블의 지정하는 컬럼값이 일치하지 않는 행도 조인에 포함을 시킨다.
LEFT JOIN TABLENAME ON (COL1 = COL2)
RIGHT JOIN TABLENAME ON (COL1 = COL2)
WHERE COL1 = COL2(+)
WHERE COL1(+) = COL2
FULL JOIN TABLENAME ON (COL1 = COL2)

--교차 조인
조인되는 테이블의 각 행들이 모두 매핑된 데이터가 검색되는 방법
곱집합 형태
FROM TABLENAME1
CROSS JOIN TABLENAME2

--비등가 조인
지정한 컬럼 값이 일치하는 경우가 아닌, 값의 범위에 포함되는 행들을 연결하는 방식

SALARY가 MIN_SAL과 MAX_SAL 사이에 있는 컬럼 값들을 연결시켜 출력

--자체 조인
자기 자신과 조인을 맺음
똑같은 테이블이 2개 있다고 생각하자

--자연 조인
동일한 타입과 이름을 가진 컬럼이 있는 테이블 간의 조인을 간단히 표현하는 방법
반드시 두 테이블 간의 동일한 컬럼명, 타입을 가진 컬럼이 필요
없을 경우 교차 조인됨

-- DML
데이터 조작 언어
테이블에 값을 
삽입하거나
수정하거나
삭제하는 구문

-- INSERT 작성법
테이블의 모든 컬럼에 대한 값을 INSERT 할 때 사용한다.
INSERT INTO 테이블명 VALUES();

선택한 컬럼에 대한 값만 INSERT할 때 사용한다.
선택 안된 컬럼은 값이 NULL이 들어간다
INSERT INTO(컬럼명1, 컬럼명2, 컬럼명3  ....)
VALUES (데이터1, 데이터2, 데이터3)

--- UPDATE 작성법
내용을 바꾸던가 추가해서 최신화, 새롭게하다
테이블에 기록된 컬럼의 값을 수정하는 구문

UPDATE 테이블명
SET 컬럼명 = 바꿀 컬럼명
WHERE 컬럼명 = 선택한 컬럼명

--- DELETE 작성법
테이블의 행을 삭제하는 구문

DELETE 테이블
WHERE 선택한 컬럼

--- TCL
트랜잭션 제어 언어
COMMIT, ROLLBACK, SAVEPOINT 가 있다
DML
데이터 조작 언어로 데이터의 삽입 수정 삭제
트랜잭션은 DML과 관련이 있다

--- 트랜잭션(Transaction)
데이터베이스의 논리적 연산 단위
데이터 변경 사항을 묶어 하나의 트래잭션에 담아 처리한다.

--- COMMIT
메모리 버퍼에 임시 저장된 데이터 변경 사항을 DB에 반영

--- ROLLBACK
메모리 버퍼에 임시 저장된 데이터 변경 사항을 삭제하고
마지막 COMMIT 상태로 돌아간다.(DB에 변경 내용 반영 X)

--- SAVEPOINT
메모리 버퍼에 저장 지점을 정의하여 ROLLBACK 수행 시 전체 작업을 삭제하는 것이 아닌
저장 지점까지만 일부 ROLLBACK

--- JDBC
JDBC JAVA에서 DB에 연결 할 수 있게 해주는 JAVA PROGRAMMING API
JAVA에 기본 내장된 인터페이스

--- OJDBC 라이브러리
오라클에서 제공하는 JAVA와 연결하기 위한 라이브러리

--- JDBC 객체 
-- 1) Connection
DB 연결 정보를 담은 객체
DBMS 타입, 이름, IP, PORT, 계정명, 비밀번호를 저장한다.

-- 2) DriverManager
메모리에 로드된 JDBC 드라이버를 이용해서 CONNECTION 객체를 만드는 역할

-- 3) Statement
CONNECTION을 통해 SQL 문은 DB에 전달하여 실행하고
생성된 결과(RESULT SET)를 반환(JAVA로)하는데 사용되는 객체이다

-- 4) PreparedStatement
STATEMENT 의 자식으로 향상된 기능을 제공한다.
'?' 기호를 이용해서 SQL에 작성되는 리터럴을 동적으로 제어한다

-- 5) ResultSet
SELECT 질의 성공 시 반환되는데
조회 결과 집합을 나타내는 객체이다
--
--- executeQuery(), executeUpdate() 차이점
executeQuery()
SELECT문 수행 메서드로서 RESULT SET을 반환한다.

executeUpdate()
DML문 수행 후 결과 행 개수를 반환한다.

--
--- Statement / PreparedStatement 

PreparedStatement
객체 생성 시 이미 SQL이 담겨져 있는 상태이므로
SQL 수행 시 매개변ㅅ로 전달할 필요가 없다.
--  SELECT / DML(INSERT, UPDATE, DELETE)에 따른 
--  DAO 메서드 코드 작성방법
--
--- Java의 char자료형 , DB의 CHAR 자료형의 차이점
--
--- DAO 메서드에서 반환형이 List, 객체, int로 다른 이유
--
--- Java 객체 생성과 필드 초기화