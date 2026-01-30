-- ===== ORDER BY로 정렬하기 =====
USE world;
SELECT DATABASE();

-- 예시1 : 인구가 많은 순서대로 정렬
SELECT ct.`Name` AS 이름, ct.`District` AS 지역, ct.`Population` AS 인구
FROM city AS ct
ORDER BY ct.`Population` DESC;

SELECT ct.`Name` AS 이름, ct.`District` AS 지역, ct.`Population` AS 인구
FROM city AS ct
ORDER BY 인구 DESC; -- SELECT 절이 끝나고, 정렬하기 때문

-- 예시 2 : 여러번 정렬
SELECT ct.`Name`, ct.`CountryCode`, ct.`Population`
FROM city AS ct
WHERE ct.`CountryCode` IN ('KOR','JPN','CHN')
ORDER BY ct.`CountryCode`, ct.`Population` DESC;

-- 예시 3 : NULL 값의 정렬
SELECT *
FROM country AS co
ORDER BY co.`IndepYear`; -- 기본적으로 NULL은 작은 값으로 취급

SELECT *
FROM country AS co
WHERE 
    co.`IndepYear` IS NOT NULL
    AND
    co.`IndepYear` > 0
ORDER BY co.`IndepYear`;

-- LIMIT와 OFFSET
SELECT *
FROM city AS ct
ORDER BY ct.`Population` DESC
LIMIT 5 -- 5개 값을 보여줘
OFFSET 5; -- 6위부터 시작