-- ===== 단일행 함수 ===== 
-- 행별로 "값 하나" -> "값 하나"

-- [1] 문자열 함수
-- (1) CONCAT : 여러 문자열을 이어낸다.
-- 예시 : Seoul (KOR)의 형태로 변환하고 싶을 때
SELECT CONCAT(ct.`Name`, ' (', ct.`CountryCode`, ')')
FROM city AS ct
WHERE ct.`CountryCode` IN (
    SELECT co.`Code`
    FROM country AS co
    WHERE LOWER(co.`Continent`) = 'asia' -- 소문자 변환
);

-- (2) SUBSTRING : 위치기반 특정 부분 잘라내기
SELECT co.`Name`, SUBSTRING(co.`Name`, 1, 3)
FROM country AS co
LIMIT 5;

-- (3) LENGTH : 길이 반환
SELECT country.`Name`, LENGTH(country.`Name`)
FROM country;

-- (4) REPLACE
SELECT co.`Name`, REPLACE(co.`Name`, 'South', 'S.')
FROM country AS co
WHERE co.`Name` LIKE '%South%';

-- [2] 숫자형 함수
-- 산술연산 가능
-- +, -, *, /
SELECT 
    co.`Name`, 
    co.`Population` / co.`SurfaceArea` AS 인구밀도, -- 산술연산
    ROUND(co.`Population` / co.`SurfaceArea`, 2) AS 반올림,
    TRUNCATE(co.`Population` / co.`SurfaceArea`, 2) AS 자릿수_버림,
    CEIL(co.`Population` / co.`SurfaceArea`) AS 올림,
    FLOOR(co.`Population` / co.`SurfaceArea`) AS 내림
FROM country AS co
WHERE co.`SurfaceArea` > 0;
-- 합산(SUM), 평균(AVG), 세기(COUNT) -> "다중행 함수" 에서 살펴볼 것

-- [3] 날짜형 함수
-- (1) 현재 날짜, 시간
SELECT NOW(), CURDATE(), CURTIME();

-- (2) 날짜 일부 추출
SELECT WEEKDAY(NOW()); -- 요일
SELECT YEAR(NOW());
SELECT YEARWEEK(NOW());

-- (3) 날짜 형식
SELECT DATE_FORMAT(NOW(),'%M-%Y');
-- 형식은 필요에 따라 찾아서 보면 된다.

-- (4) 날짜 연산
SELECT NOW() + 10; -- 의도: 10일 뒤 => 분명하지 않다.

SELECT DATE_ADD(NOW(),INTERVAL 10 DAY);
SELECT DATE_SUB(NOW(), INTERVAL 3 HOUR);

-- 예시 : 반납일과 대여일 사이 간격 확인하기
USE sakila;
DESCRIBE rental;

SELECT AVG(DATEDIFF(r.return_date, r.rental_date)) AS 대여기간
FROM rental AS r;

-- 종강일까지의 날짜!
SELECT DATEDIFF('2026-03-27',CURDATE());

-- [4] NULL 관련 함수
-- 결측치 -> 비어 있는 값

SELECT DATABASE();
USE world;

DESCRIBE country; -- 결측이 될 수 있는 필드 확인

SELECT COUNT(*)
FROM country
WHERE GNP IS NULL; -- 없을 수도 있음
-- WHERE HeadOfState IS NULL;

-- (1) COALESCE
-- 결측이 아닌 첫번째 값을 반환
SELECT 
    co.`Name`, co.`GNPOld`, co.`GNP`,
    COALESCE(co.`GNPOld`, co.`GNP`, 0) AS 최종GNP
FROM country AS co;

-- (2) IFNULL
-- 단일 값 결측 대체
SELECT 
    co.`Name`, co.`HeadOfState`,
    IFNULL(co.`HeadOfState`,'정보없음') AS 결측대체
FROM country AS co
WHERE co.`Continent` = 'Europe';

-- [3] NULLIF
-- 결측치 발생을 위한 함수
-- 만약 같으면 NULL 반환, 다르면 A 반환
-- 일부러 NULL을 발생 -> 처리되고 싶어서, 제외되고 싶어서

SELECT cl.`Language`, cl.`Percentage`, NULLIF(cl.`Percentage`,0.0)
FROM countrylanguage AS cl
WHERE cl.`CountryCode` = 'ANT';