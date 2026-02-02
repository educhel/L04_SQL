-- Active: 1751779934239@@127.0.0.1@3306@world
-- SQL의 기본적인 흐름
USE world;

SELECT ct.`District` AS 지역명, COUNT(*) AS 100만이상_도시수
FROM city AS ct
WHERE ct.Population >= 1000000
GROUP BY ct.`District`
HAVING 100만이상_도시수 >= 5 -- MySQL 상에서 SELECT 단의 별칭 쓸 수 있도록 도와주는 것 뿐
ORDER BY 100만이상_도시수 DESC;
-- 작성 순서 : "SELECT" -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY
-- 실행 순서 : FROM(JOIN) -> WHERE(개별행 필터링) -> GROUP BY(그룹화->집계) -> HAVING(집계값 필터링) -> "SELECT" -> ORDER BY

-- ====== JOIN ======
-- INNER JOIN : 두 테이블 사이 교집합으로 연결
-- OUTER JOIN : 특정 테이블을 기준으로 연결 -> LEFT, RIGHT, FULL OUTER(MySQL 지원X) 

-- [1] INNER JOIN
-- JOIN의 결과 갯수가 늘어날 수도 있다. (1:N 관계)
-- 교집합만을 가지고 오기 때문에 원데이터에 결측이 없다면 JOIN 하면서 발생되는 결측은 없다.
SELECT 
    ct.`Name` AS 도시명,
    co.`Name` AS 국가명,
    co.`Continent` AS 대륙명
FROM 
    city AS ct
    INNER JOIN
    country AS co
    ON co.`Code` = ct.`CountryCode`;

DESCRIBE city;

-- [2] LEFT JOIN
-- 기준 테이블 = 왼쪽
-- 왼쪽 테이블을 기준으로 연결하기
-- (옵셔널인 경우) JOIN 과정에서 결측이 발생할 수도 있음
USE world;
SELECT 
    co.`Name` AS 국가명,
    ct.`Name` AS 수도명
FROM 
    country AS co
    LEFT JOIN
    city AS ct
    ON co.`Capital` = ct.`ID`
WHERE ct.`Name` IS NULL;

-- 기준 테이블(LEFT TABLE)에 있는 값이기 때문에 city(RIGHT TABLE)에서 가지고 올 수 없어도 연결
-- => NULL 결측이 발생

-- ==== 세 개 이상 테이블의 JOIN ====
-- JOIN을 여러번 해주기 -> 순차적으로 실행
SELECT 
    co.`Name` AS 국가명,
    ct.`Name` AS 수도명,
    cl.`Language` AS 공식언어
FROM
    country AS co
    JOIN -- 기본값 : INNER JOIN
    city AS ct
    ON co.`Capital` = ct.`ID`
    JOIN 
    countrylanguage AS cl
    ON co.`Code` = cl.`CountryCode`
WHERE cl.`IsOfficial` = 'T';