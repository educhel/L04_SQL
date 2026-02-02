-- 또다른 JOIN의 형태

-- SELF JOIN
-- 새로운 조인의 종류가 아닌 "나 자신과의 연결"
-- 같은 테이블 내, 행과 행 비교 -> 구분을 위한 Alias 지정

USE world;

-- 예시 : "대한민국(South Korea)과 같은 대륙"에 속한 "다른 국가들"을 찾고 싶다.
-- 대상 테이블
    -- country

SELECT 
    c2.`Name` AS 국가명,
    c1.`Continent` AS 대륙명
FROM country AS c1
    JOIN
    country AS c2
    ON c1.`Continent` = c2.`Continent`
WHERE
    c1.`Name` = 'South Korea'
    AND
    c2.`Name` <> 'South Korea';
