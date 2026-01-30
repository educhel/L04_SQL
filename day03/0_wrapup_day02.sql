-- ===== SELECT =====
USE world;
SELECT DATABASE(); -- 현재 내가 보고 있는 데이터베이스의 이름 확인
SHOW TABLES;
DESCRIBE city;

-- SELECT 문 필수요소
-- 1. SELECT 뒤, 내가 보고 싶은 열 혹은 수식
-- 2. FROM 대상 테이블
SELECT `Name`, `CountryCode`, `Population`
FROM city;

-- [2] Alias 별칭 
-- AS 키워드 사용

-- (1) 테이블 별칭
-- SELECT 나 다른 위치에서 "테이블을 쉽게 부르기 위함"

SELECT ct.`Name`, ct.`CountryCode`, ct.`Population`
FROM city AS ct;


-- (2) 컬럼명 별칭 가능
-- 조회단에서 컬럼에 대한 이름을 바꾸어서 볼 수 있다.
-- 수식의 결과를 표현하는 경우, 유용하게 사용된다.

SELECT 
    city.`Name` AS 도시명, 
    city.`CountryCode` AS 국가코드,
    city.`Population` AS 인구수
FROM city;

SELECT co.`Continent`, COUNT(*) -- 수식이 그대로 표현이 된다.
FROM country AS co
GROUP BY co.`Continent`;

SELECT co.`Continent` AS 대륙별, COUNT(*) AS 나라수 -- SQL 모르는 사람도 이해할 수 있다.
FROM country AS co
GROUP BY co.`Continent`;

-- === 쿼리의 논리적 실행 ===
-- 작성 순서 : "SELECT" -> FROM (필요시 JOIN) -> WHERE -> GROUP BY -> HAVING -> ORDER BY
-- 실행 순서 : FROM (필요시 JOIN) -> WHERE -> GROUP BY -> HAVING -> "SELECT" ->  ORDER BY

-- SELECT의 실행 순서가 생각보다 후단에 있다.

-- 에러 발생 예시
-- Error: Unknown column '국가코드' in 'where clause'
-- WHERE 실행 순서가 먼저옴에 따라, SELECT 문에서의 Alias는 WHERE 절에서 사용할 수 없다.
SELECT ct.Name AS 도시명, ct.`CountryCode` AS 국가코드, ct.`Population` AS 인구수
FROM city AS ct
WHERE 국가코드 = 'KOR';

-- 올바른 예시
SELECT ct.Name AS 도시명, ct.`CountryCode` AS 국가코드, ct.`Population` AS 인구수
FROM city AS ct
WHERE ct.`CountryCode` = 'KOR';


-- ===== WHERE 절 =====
-- WHERE [조건식]
-- 조건식을 취하는 대상은? 테이블에서의 "행" -> 각각의 레코드
-- 조건식의 결과가 TRUE 인 행들만 남기도록 필터링한다

SELECT ct.Name AS 도시명, ct.`CountryCode` AS 국가코드, ct.`Population` AS 인구수
FROM city AS ct
WHERE ct.`CountryCode` = 'KOR';

-- [1] 비교
-- 대소비교 (>,<,>=,<=)
-- 일치비교 (=, <>)
SELECT *
FROM city
WHERE city.`Population` >= 10000000;


-- [2] 논리
-- 조건을 여러 개 이어내기 위한 목적
-- AND, OR, NOT

-- [3] 포함
-- IN 목록
SELECT *
FROM city AS ct
WHERE 
    ct.`Population` >= 1000000
    AND -- 조건식 AND 조건식 처럼 사용됨
    ct.`CountryCode` IN ('KOR','JPN','CHN');

-- [4] 범위
-- BETWEEN A AND B -> A와 B 사이에 있으면 TRUE, 그렇지 않으면 FALSE
SELECT *
FROM city AS ct
WHERE
    ct.`Population` BETWEEN 5000000 AND 10000000;

-- [5] NULL 여부
-- IS NULL : 값이 NULL인 경우 TRUE
DESCRIBE city; -- 결측치가 올수 있는 행이 없으므로, country 사용
DESC country;

SELECT *
FROM country AS co
WHERE co.`IndepYear` IS NOT NULL;

-- [6] 패턴매칭
-- LIKE [패턴]
SELECT *
FROM country AS co
WHERE co.`Name` LIKE "%stan";

-- ===== GROUP BY =====
-- 그룹별 집계를 위한 목적

-- 예시 : 대륙별 국가수, 총인구수, 평균인구
SELECT 
    co.`Continent` AS 대륙별,
    COUNT(*) AS 국가수,
    SUM(co.`Population`) AS 총인구수,
    AVG(co.`Population`) AS 평균인구
FROM country AS co
GROUP BY co.`Continent`;

-- 에러 발생
-- Error: Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'world.co.Name'
--  which is not functionally dependent on columns in GROUP BY clause; 
-- this is incompatible with sql_mode=only_full_group_by
SELECT 
    co.`Continent` AS 대륙별,
    co.`Name` AS 나라명, -- GROUP BY에서 사용하지 않은 컬럼
    COUNT(*) AS 국가수,
    SUM(co.`Population`) AS 총인구수,
    AVG(co.`Population`) AS 평균인구
FROM country AS co
GROUP BY co.`Continent`;

-- ===== HAVING =====
-- 목적 : 필터링 
-- 필터링의 대상 : 그룹화하여 집계한 값을 다시 필터링

SELECT 
    co.`Continent` AS 대륙별,
    COUNT(*) AS 국가수,
    SUM(co.`Population`) AS 총인구수,
    AVG(co.`Population`) AS 평균인구
FROM country AS co
GROUP BY co.`Continent`
HAVING 
    COUNT(*) BETWEEN 10 AND 50
    ;

-- HAVING 에는 그룹화를 위한 기준 혹은 집계 함수만 올 수 있다!
SELECT 
    co.`Continent` AS 대륙별,
    COUNT(*) AS 국가수,
    SUM(co.`Population`) AS 총인구수,
    AVG(co.`Population`) AS 평균인구
FROM country AS co
GROUP BY co.`Continent`
HAVING 국가수 BETWEEN 10 AND 50;