-- 데이터 형변환
-- [1] 암시적 형변환
-- 자체적으로 해석하여서 변환해주나, 그 품질은 장담할 수가 없음
DESC category;

SELECT "1" + 403;

SELECT cat.category_id + cat.name
FROM category AS cat
LIMIT 4;

-- [2] 명시적 형변환
-- CAST 함수 사용
-- CAST(컬럼 AS 자료형)

SELECT CONCAT(CAST(cat.category_id AS CHAR),'_',cat.name)
FROM category AS cat;

-- 만약 last_update가 문자열 이라고 할 때,
SELECT YEAR(CAST(cat.last_update AS DATETIME))
FROM category AS cat;

SELECT CAST('2026' AS YEAR) - YEAR(cat.last_update)
FROM category AS cat;