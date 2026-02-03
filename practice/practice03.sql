-- ==== 실전! SQL 실습 (3) ==== 
USE world;
SELECT DATABASE();

-- 
-- [1] 각 "국가별 도시"가 "10개 이상"인 "국가의 CountryCode, 도시수"를 조회하시오.
-- 대상 테이블 : city
-- 조건 : "국가별 도시"가 10개 이상 -> 집계의 조건 (HAVING)
SELECT ct.`CountryCode` AS 국가코드, COUNT(*) AS 도시수
FROM city AS ct
GROUP BY ct.`CountryCode`
-- HAVING COUNT(*) >= 10; -- 원래는 이렇게!
HAVING 도시수 >= 10; -- DBMS 상에서 지원

-- [2] "District별" "평균 인구가 100만 이상"이면서 "도시 수가 3개 이상"인 "District,  도시 수, 총 인구"를 구하시오
-- 대상 테이블 : city
-- 조건 : 집계 조건 여러개를 연결하여 사용 -> 집계 조건 -> HAVING
-- 1) "평균"인구가 100만 이상 
-- 2) 도시 "수"가 3개 이상
-- 집계 기준 : District별 -> GROUP BY

SELECT ct.`District`, COUNT(*) AS 도시수, SUM(ct.`Population`) AS 총인구
FROM city AS ct
GROUP BY ct.`District`
HAVING  
    AVG(ct.`Population`) >= 1000000
    AND
    COUNT(*) >= 3;

-- [3] "아시아 대륙의 국가들 중"에서, 
-- "Region별 평균 GNP가 50000 이상"인 "Region, 평균 GNP"를 조회하시오

-- co.Continent = 'Asia'
-- 1. WHERE 필터링 (정답)
-- 2. HAVING 필터링

SELECT *
FROM country
LIMIT 10;

SELECT co.`Region` AS 지역명, AVG(co.`GNP`) AS 평균GNP
FROM country AS co
WHERE co.`Continent` = 'Asia'
GROUP BY co.`Region`
HAVING AVG(co.`GNP`) >= 50000;

-- [4] 독립년도가 1900년 이후인 국가들 중에서,
-- 대륙별 평균 기대수명이 70세 이상인 Continent, 평균 기대수명을 조회하시오.
SELECT co.`Continent`, AVG(co.`LifeExpectancy`)
FROM country AS co
GROUP BY co.`Continent`
HAVING AVG(co.`LifeExpectancy`) >= 70;


SELECT co.`Continent` AS 대륙별, AVG(co.`LifeExpectancy`) AS 평균기대수명
FROM country AS co
GROUP BY co.`Continent`
HAVING 평균기대수명 >= 70;

-- [5]CountryCode별 도시 평균 인구가 100만 이상이고 도시 최소 인구가 50만 이상인 
-- CountryCode, 총 도시수, 총 인구수를 조회하시오.

-- 조건: CountryCode별 -> 집계
-- 1) 도시 평균 인구가 100만 이상이고 
-- 2) 도시 최소 인구가 50만 이상인 


SELECT 
    ct.`CountryCode` AS 국가별,
    COUNT(*) AS 총도시수,
    SUM(ct.`Population`) AS 총인구수
FROM city AS ct
GROUP BY ct.`CountryCode`
HAVING 
    AVG(ct.`Population`) >= 100000
    AND
    MIN(ct.`Population`) >= 50000
    -- AND
    -- ct.`CountryCode` LIKE "K%"; -- K로 시작하는 국가만 남기기

