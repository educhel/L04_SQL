-- 자주 사용하는 쿼리 저장소

-- VIEW 객체
-- 객체를 생성, 수정, 삭제 -> DDL

USE world;
SELECT DATABASE();

SHOW TABLES;

-- 아시아 (Asia) 대륙에 속한 국가들의 이름, 수도, 인구, GNP
-- 대상테이블
    -- 1) country
    -- 2) city
SELECT 
    co.`Code` AS 국가코드,
    co.`Name` AS 국가명,
    ct.`Name` AS 수도명,
    co.`Population` AS 인구수,
    co.GNP
FROM 
    country AS co
    INNER JOIN
    city AS ct
    ON co.`Capital` = ct.`ID`
WHERE co.`Continent` = 'Asia';

-- [1] VIEW 생성
-- 고정을 위한 가상테이블
-- 생성(DDL) -> CREATE
CREATE VIEW asia_countries_view AS
    SELECT 
        co.`Code` AS 국가코드,
        co.`Name` AS 국가명,
        ct.`Name` AS 수도명,
        co.`Population` AS 인구수,
        co.GNP
    FROM 
        country AS co
        INNER JOIN
        city AS ct
        ON co.`Capital` = ct.`ID`
    WHERE co.`Continent` = 'Asia';

SHOW TABLES;
-- 테이블처럼 사용 가능

SELECT *
FROM asia_countries_view
WHERE 인구수 < 100000000
ORDER BY 인구수 DESC
LIMIT 10; 

-- [2] VIEW 수정
-- VIEW 를 정의하고 있는 쿼리를 갱신한다.
CREATE OR REPLACE VIEW asia_countries_view AS
    SELECT 
        co.`Code` AS 국가코드,
        co.`Name` AS 국가명,
        ct.`Name` AS 수도명,
        co.`Population` AS 인구수,
        co.GNP,
        co.`GovernmentForm` AS 정부형태
    FROM 
        country AS co
        INNER JOIN
        city AS ct
        ON co.`Capital` = ct.`ID`
    WHERE co.`Continent` = 'Asia';

SELECT *
FROM asia_countries_view;

-- VIEW 원문 쿼리 확인 가능!
SHOW CREATE VIEW asia_countries_view;

-- [3] VIEW 삭제하기
DROP VIEW IF EXISTS asia_countries_view;
SHOW TABLES;