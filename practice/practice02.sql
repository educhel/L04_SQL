-- 실전! SQL 실습 (2)
-- GROUP BY

USE world;
SHOW TABLES;

-- [1] 대륙별 총 인구수를 구하시오.
-- 대상 테이블 = country
DESC country;

SELECT co.`Continent` AS 대륙별, SUM(co.`Population`) AS 총인구수
FROM country AS co
GROUP BY co.`Continent`;
-- SELECT 에 GROUP By 에 쓰인 "기준 컬럼"과 "집계 함수" 밖에 오지 못한다.
-- 만일 기준 컬럼을 선택하지 않으면? 보여지지 않는다.

-- [2] Region별로 GNP가 가장 높은 지역을 찾으시오.
SELECT co.`Region`, MAX(co.GNP)
FROM country AS co
GROUP BY co.`Region`;

SELECT co.`Continent`, co.`Region`, MAX(co.GNP)
FROM country AS co
GROUP BY co.`Continent`, co.`Region`;

SELECT *
FROM country
LIMIT 10;

-- [3] 대륙별 평균 GNP와 평균 인구를 구하시오.
SELECT co.`Continent` AS 대륙, 
        AVG(co.`GNP`) AS 평균GNP,
        AVG(co.`Population`) AS 평균인구
FROM country AS co
GROUP BY co.`Continent`;

-- [4] "인구가 50만에서 100만 사이인 도시들"에 대해, "District별" "도시 수"를 구하시오
SELECT ct.`District` AS 지역명, COUNT(*) AS 도시수
FROM city AS ct
WHERE ct.`Population` BETWEEN 500000 AND 1000000
GROUP BY ct.`District`;

-- [5] "아시아 대륙" 국가들의 "Region별" "총 GNP"를 구하세요
SELECT co.`Region` AS 지역명, SUM(co.`GNP`) AS 총GNP
FROM country AS co
WHERE co.`Continent` = 'Asia'
GROUP BY co.`Region`;