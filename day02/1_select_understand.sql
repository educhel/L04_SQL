-- ==== SELECT 구문의 이해 ====
USE world;
SHOW TABLES;

-- [1] SELECT 구문의 순서
-- 작성 순서 : SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY
-- 순서를 지키지 않으면, 실행자체가 되지 않는다.

-- 예시1 : 올바른 순서
SELECT Name, Population
FROM city;

-- 예시2 : 잘못된 순서
-- 작동이 되지 않음
-- FROM city
-- SELECT Name, Population;

-- 조회의 목적 : "하나 이상의 테이블"에서 "원하는 데이터"를 선택하여 검색

-- 필수 요소
-- 1. SELECT 원하는 필드
-- 2. FROM 테이블 출처

-- 테이블명 생략 없이 특정 필드 조회
SELECT city.`Name`, city.`Population`
FROM city;