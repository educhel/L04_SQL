-- ==== 서브쿼리 기법 ====
-- 메인쿼리 안에 또 다른 쿼리 -> 서브쿼리

-- 서브쿼리 종류
-- [1] 반환형태 -> 단일행(값하나), 다중행(여러값), 다중컬럼(테이블)
-- [2] 동작방식 -> 비연관, 연관

-- 예시 1: 인구가 많은 1위부터 10위까지 나라가 대륙별로 몇 개가 있는가?
-- => 많은 풀이법 중, 서브쿼리로 풀 수 있다. (JOIN으로도 물론 가능!)

-- 대상 테이블 : country
-- 조건 : 인구가 많은 1위부터 10위까지의 나라만 대상으로 한다
-- 집계 : 대륙별 + 센다

USE world;

SELECT 
    co1.`Continent`, COUNT(*)
FROM -- 인라인 뷰
    (SELECT *
    FROM country AS co2
    ORDER BY co2.`Population` DESC
    LIMIT 10) AS co1
GROUP BY co1.`Continent`;

-- 서브쿼리 (비연관)
SELECT co2.`Code`
FROM country AS co2
ORDER BY co2.`Population` DESC
LIMIT 10;

-- "연관 서브쿼리"
SELECT c1.`Name`, c1.`Population`, c1.`CountryCode`
FROM city AS c1
WHERE c1.`Population` = (
    SELECT MAX(c2.`Population`)
    FROM city AS c2
    WHERE c1.`CountryCode` = c2.`CountryCode`
)
    AND
        c1.`CountryCode` = 'KOR';