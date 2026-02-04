-- 다양한 윈도우 함수
-- [1] 집계
-- 일반적인 집계함수를 OVER와 함께 사용

-- [2] 순위
-- (1) Rank 계열
SELECT 
    RANK() OVER(ORDER BY `GNP` DESC) AS 순위,
    co.`Name`,
    co.`GNP`
FROM country AS co;

SELECT 
    RANK() OVER(PARTITION BY co.`Continent`
                ORDER BY co.`GNP` DESC) AS 순위,
    co.`Continent`,
    co.`Name`,
    co.`GNP`
FROM country AS co;

-- 각각 순위함수는 차이가 있다.
WITH scores AS (
    SELECT 'A학생' AS name, 95 AS score
    UNION ALL SELECT 'B학생', 90
    UNION ALL SELECT 'C학생', 85
    UNION ALL SELECT 'D학생', 85
    UNION ALL SELECT 'E학생', 85
    UNION ALL SELECT 'F학생', 70
)
SELECT
    name, score,
    ROW_NUMBER() OVER(ORDER BY score DESC) AS row_num,
    RANK()       OVER(ORDER BY score DESC) AS rnk,
    DENSE_RANK() OVER(ORDER BY score DESC) AS dense_rnk
FROM scores;

-- (2) NTILE
SELECT 
    co.`Name`,
    co.`Continent`,
    co.`GNP`,
    NTILE(4) OVER(ORDER BY co.`GNP` DESC) AS gnp티어
FROM country AS co;

-- [3] 값
SELECT DISTINCT
    co.`Continent` AS 대륙별,
    FIRST_VALUE(co.`Name`) OVER(
                                PARTITION BY co.`Continent`
                                ORDER BY co.`LifeExpectancy` DESC
                                ) AS 최고수명국가,
    LAST_VALUE(co.`Name`) OVER(
                                PARTITION BY co.`Continent`
                                ORDER BY co.`LifeExpectancy` DESC
                                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                                ) AS 최저수명국가
FROM country AS co
WHERE co.`LifeExpectancy` IS NOT NULL;

-- 행 간 차이를 확인할 수 있다.
-- LAG : 이전행
-- LEAD : 이후행
SELECT 
    co.Name, 
    co.LifeExpectancy,
    LAG(LifeExpectancy, 1) OVER(ORDER BY LifeExpectancy DESC) AS previous_country_le,
    co.LifeExpectancy - LAG(LifeExpectancy, 1, 0) OVER(ORDER BY LifeExpectancy DESC) AS diff_with_previous
FROM country AS co
WHERE Continent = 'Africa' AND LifeExpectancy IS NOT NULL
LIMIT 5;