-- ==== JOIN으로 여러 테이블 연결하기 ====

-- [1] INNER JOIN
-- 공통된 값에 해당하는 데이터만 반환

-- 예시 : world 데이터베이스
-- city + country
-- 1 : N 관계
SELECT 
    city.`Name` AS 도시명,
    country.`Name` AS 국가명, 
    country.`Continent` AS 대륙명
FROM 
    city 
    INNER JOIN
    country
    ON city.`CountryCode` = country.`Code`;

-- [2] OUTER JOIN 중, LEFT JOIN
-- 예시 2: world 데이터베이스
SELECT 
    co.`Name` AS 나라명,
    ct.`Name` AS 수도명
FROM 
    country AS co -- left : country -> 기준 테이블
    LEFT JOIN
    city AS ct -- right : city
    ON co.`Capital` = ct.`ID`; -- 수도ID(Capital)와 도시ID가 같은 경우에

-- 결측이 발생할 수 있음
-- LEFT를 기준으로, LEFT 상에 존재하면 병합 -> RIGHT에 있다고(존재한다고) 보장할 수 없다.
SELECT 
    co.`Name` AS 국가명,
    co.`Population` AS 국가인구, -- LEFT TABLE 에서 온 컬럼
    ct.`Name` AS 수도명,
    ct.`Population` AS 도시인구,
    ct.`District` AS 지역 -- RIGHT TABLE 에서 온 컬럼
FROM 
    country AS co -- country가 기준 테이블
    LEFT JOIN
    city AS ct
    ON co.`Capital` = ct.`ID`
WHERE ct.Name IS NULL;


-- sakila 비디오 대여점 예시
USE sakila;
SHOW TABLES;


-- 질문: "모든 고객"의 "대여"내역 (대여일자, 반납일자) 정보를 보고 싶다.
-- 대상 테이블
    -- 고객 (customer)
    -- 대여내역 (rental)
-- 우리는 자세히 무엇을 원하는가?
    -- 1) 모든 고객을 보길 원하는가? -> LEFT (선택)
    -- 2) 대여를 한번이라도 해본 고객을 보길 원하는가? -> INNER

DESC customer;
DESC rental;

-- "모든 고객"의 "대여"내역 (대여일자, 반납일자) 정보
SELECT 
    c.first_name,
    c.last_name,
    r.rental_date,
    r.return_date
FROM 
    customer AS c
    LEFT JOIN
    rental AS r
    ON c.customer_id = r.customer_id;

-- "모든 고객" 중, 아직 반납 안한 사람의 "대여"내역 (대여일자, 반납일자)
SELECT 
    c.first_name,
    c.last_name,
    r.rental_date,
    r.return_date
FROM
    customer AS c
    LEFT JOIN
    rental AS r
    ON c.customer_id = r.customer_id
WHERE r.return_date IS NULL;

SELECT COUNT(*)
FROM
    customer AS c -- 기준 테이블
    LEFT JOIN
    rental AS r
    ON c.customer_id = r.customer_id
WHERE r.return_date IS NULL;