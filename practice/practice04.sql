-- 실전! SQL 실습 (4)

-- [1] country 테이블에서 "대륙별로 정렬"하고,
-- 같은 대륙 내에서는 "GNP가 높은 순"으로 정렬하여 
-- Name, Continent, GNP을 조회하세요.

SELECT co.`Name`, co.`Continent`, co.GNP
FROM country AS co
ORDER BY co.`Continent`, co.GNP DESC;


-- 대륙 별 국가 수가 많은 순서대로 Continent, 국가 수를 조회하세요.
-- 대상 테이블 : country
-- GROUP BY + 집계함수
-- 대륙별 국가수 -> "집계" 한 값을 대상으로 정렬

SELECT co.`Continent` AS 대륙별, COUNT(*) AS 국가수
FROM country AS co
GROUP BY co.`Continent`
ORDER BY 국가수 DESC;

SELECT co.`Continent` AS 대륙별, COUNT(*) AS 국가수
FROM country AS co
GROUP BY co.`Continent`
HAVING COUNT(*) > 10
ORDER BY 국가수 DESC;

-- [3] 독립년도가 있는 국가들의 "대륙 별 평균 기대수명"이 높은 순서대로 
-- Continent, 평균 기대수명을 조회하세요.

-- 대상 테이블 : 국가
-- 필터링 : 독립년도가 있는 국가만을 필터링
-- 집계 : 대륙별 + 평균 기대수명
-- 정렬 : 기대수명이 높은 순서대로 
SELECT co.`Continent` AS 대륙별, AVG(co.`LifeExpectancy`) AS 평균기대수명
FROM country AS co
WHERE co.`IndepYear` IS NOT NULL
GROUP BY co.`Continent`
ORDER BY 평균기대수명 DESC;

-- [5] 인구가 많은 도시 중 11위부터 20위까지 조회하세요.
SELECT *
FROM city AS ct
ORDER BY ct.`Population` DESC
LIMIT 10
OFFSET 10;