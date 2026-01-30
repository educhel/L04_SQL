-- Active: 1751779934239@@127.0.0.1@3306@sakila
-- 실전! SQL 실습 (5)
USE sakila;
SELECT DATABASE();

-- [1] 고객 이름과 주소 함께 보기
-- 대상 테이블
    -- 1) 고객 (customer)
    -- 2) 주소 (address)
-- 원하는 바
    -- 고객 -> 주소 O
    -- 주소 -> 고객 O
    -- => INNER JOIN

SELECT 
    c.first_name,
    c.last_name,
    a.address
FROM 
    customer AS c
    INNER JOIN
    address AS a
    ON c.address_id = a.address_id;

-- [2] 영화 제목과 언어 이름 조회하기
-- 대상 테이블
    -- 1) 영화 (film)
    -- 2) 언어 (langauge)
-- 원하는 바 : 둘다 있는 경우에만 본다.
SELECT
    f.title AS 영화제목,
    l.name AS 언어이름
FROM
    film AS f
    JOIN
    language AS l
    ON f.language_id = l.language_id;

-- 추가 : 언어별 몇 개의 영화가 존재하는지 보고자 함
SELECT
    l.name AS 언어별,
    COUNT(*) AS 영화갯수
FROM
    film AS f
    JOIN
    language AS l
    ON f.language_id = l.language_id
GROUP BY l.name;

-- [3] "모든 고객"과 "각 고객"의 "최근 대여일" 조회하기
-- 대상 테이블
    -- 1) 고객 (customer) -> 기준 테이블
    -- 2) 대여 (rental)

SELECT 
    c.first_name,
    c.last_name,
    MAX(r.rental_date) AS 최근대여일
FROM
    customer c
    LEFT JOIN
    rental r
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

DESC customer;

-- [4] "특정 도시"에 사는 고객 찾기
-- 대상테이블
    -- 1) 주소
    -- 2) 고객
-- JOIN 이후 필터링
SELECT 
    c.first_name,
    c.last_name,
    c.email
FROM
    customer AS c
    INNER JOIN
    address AS a
    ON c.address_id = a.address_id
WHERE a.city_id = 312;

-- [5] 직원별로 처리한 총 결제 건수 구하기
-- 대상 테이블
    -- 1) 직원 (staff)
    -- 2) 결제 (payment)
-- 직원별 -> 집계
SELECT 
    s.first_name AS 직원별,
    COUNT(*) AS 결제건수
FROM 
    staff AS s
    JOIN
    payment AS p
    ON s.staff_id = p.staff_id
GROUP BY s.first_name

-- [6] "결제액 합계"가 높은 우수 "고객" 찾기
-- 대상 테이블
    -- 1) 고객 (customer)
    -- 2) 결제 (payment)
-- 집계 : 고객별 + 결제액 합계
-- 필터링하기 : 집계결과 "우수"

SELECT 
    c.customer_id AS 고객별,
    SUM(p.amount) AS 총결제액
FROM 
    customer AS c
    INNER JOIN
    payment AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING 총결제액 >= 180
ORDER BY 총결제액 DESC;