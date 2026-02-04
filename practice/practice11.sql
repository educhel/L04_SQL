-- === 실전! SQL 실습 (11) ===
USE world;

-- [1] 분석 전 데이터 품질 점검
SELECT co.`Name`, co.`Continent`,co.`GNP`,co.`LifeExpectancy`
FROM country AS co
WHERE 
    co.`LifeExpectancy` IS NULL 
    OR co.`GNP` IS NULL

-- [2] 결측치 보정 로직 적용하기
-- 1단계 : 대륙별 평균 나이 구하기
WITH continent_avg_age AS (
    SELECT 
        `Continent`, 
        AVG(`LifeExpectancy`) AS avg_le
    FROM country
    GROUP BY `Continent`
)
SELECT 
    co.`Name`,
    co.`Continent`,
    co.`LifeExpectancy`,
    COALESCE(co.`LifeExpectancy`,caa.avg_le, -999)
FROM country AS co
    INNER JOIN
    continent_avg_age AS caa
    ON co.`Continent` = caa.`Continent`;

-- [3] 범주형 데이터 정규화
SELECT 
    co.`Name`,
    co.`GovernmentForm`,
    CASE 
        WHEN co.`GovernmentForm` LIKE '%Republic%' THEN  'Republic'
        WHEN co.`GovernmentForm` IS NULL THEN '정부형태 없음'
        ELSE  co.`GovernmentForm`
    END AS 정부형태전처리
FROM country AS co;

-- [4] 분석용 파생 지표 생성
-- [5] 경제 수준 비교를 위한 지표 가공
SELECT 
    co.`Name`, 
    co.`Continent`,
    co.`Population` / co.`SurfaceArea` AS 인구밀도,
    ROUND(co.`GNP` * 1000000 / co.`Population`,1) AS 1인당GNP
FROM country AS co
WHERE co.`SurfaceArea` > 0;

-- [6] 수도 집중도 지표 계산
SELECT 
    co.`Name` AS 국가명,
    co.`Population` AS 인구수,
    ct.`Name` AS 수도명,
    ct.`Population` AS "수도 인구수",
    CONCAT(CAST(ROUND(ct.`Population` / co.`Population`, 1) * 100 AS CHAR),'%' ) AS "수도 인구 집중 비율"
FROM 
    country AS co
    INNER JOIN
    city AS ct
    ON co.`Capital` = ct.`ID`
WHERE co.`Code` = 'KOR';