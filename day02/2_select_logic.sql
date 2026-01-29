-- ==== SELECT 구문의 논리적 실행 ====

USE world;
SHOW TABLES;

-- 작성 순서 : "SELECT" -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY
-- 실행 순서 : FROM -> WHERE -> GROUP BY -> HAVING -> "SELECT" -> ORDER BY 
SELECT c.`Continent` AS 대륙, c.`Name` AS 국가, c.`Population` AS 인구 
FROM country AS c;

DESCRIBE country;

-- 예시 : 작성 순서와 실행 순서가 다름을 인지하지 못하여 발생한 에러
-- Error: Unknown column '대륙' in 'where clause'
SELECT c.`Continent` AS 대륙, c.`Name` AS 국가, c.`Population` AS 인구 
FROM country AS c
WHERE 대륙 = 'Asia'; 

-- 쿼리의 실행 순서 상 
-- WHERE 절이 SELECT 절보다 앞서 있기 때문에 SELECT에서 지정한 별칭을 사용할 수 없다.

-- 예시 2: 올바른 실행 순서
SELECT c.`Continent` AS 대륙, c.`Name` AS 국가, c.`Population` AS 인구 
FROM country AS c
WHERE c.`Continent` = 'Asia';

-- 예시 3: 올바른 실행 순서
SELECT c.`Continent` AS 대륙, c.`Name` AS 국가, c.`Population` AS 인구 
FROM country AS c
WHERE c.`Continent` = 'Asia'
ORDER BY 인구;

-- ORDERY BY 실행 순서가 SELECT 보다 뒤에 있기 때문에
-- SELECT 에서 지정한 별칭을 쓸 수 있다.