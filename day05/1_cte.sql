-- CTE
-- WITH 절을 통해, 해당 쿼리에서만 사용할 임시뷰를 선언하는 방식

-- 각 대륙에서 인구가 가장 많은 국가 찾기

-- 서브쿼리를 사용했을 때, 예시
SELECT co1.`Continent`, co1.`Name`, co1.`Population`
FROM 
    country AS co1
    JOIN (
        SELECT co2.`Continent`, MAX(co2.`Population`) AS max_pop
        FROM country AS co2
        GROUP BY co2.`Continent`
    ) AS cmp
    ON 
        cmp.`Continent` = co1.`Continent` 
        AND 
        cmp.`max_pop` = co1.`Population`;

-- CTE로 풀기
--  해당 문제를 분해하자!
-- 1단계 : 대륙별 최대 인구 계산
WITH cmp AS (
    SELECT `Continent`, MAX(`Population`) AS max_pop
    FROM country
    GROUP BY `Continent`
)
-- 2단계: cmp를 이용하여, 해당 인구를 가진 국가 찾기
SELECT c.`Continent`,c.`Name`,c.`Population`
FROM 
    country AS c 
    JOIN cmp
    ON 
        c.`Continent` = cmp.`Continent`
        AND c.`Population` = cmp.max_pop;