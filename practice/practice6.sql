-- 실전! SQL 실습 (6)

USE sakila;
-- [1] 고객의 기본 정보, 주소, 도시 조회
-- 대상테이블
    -- 1) customer => 기준 테이블
    -- 2) address
    -- 3) city
-- 의도 : "모든" 고객의 정보를 보겠다. -> "LEFT" JOIN 선택

SELECT 
    c.first_name AS 이름,
    c.last_name AS 성,
    a.address AS 주소,
    ct.city AS 도시명
FROM 
    customer AS c 
    LEFT JOIN
    address AS a
    ON c.address_id = a.address_id
    LEFT JOIN
    city AS ct
    ON ct.city_id = a.city_id;


-- [2] 특정 지역 고객 타겟팅: London 거주 고객 조회
SELECT 
    c.first_name AS 이름,
    c.last_name AS 성,
    a.address AS 주소,
    ct.city AS 도시명
FROM 
    customer AS c 
    LEFT JOIN
    address AS a
    ON c.address_id = a.address_id
    LEFT JOIN
    city AS ct
    ON ct.city_id = a.city_id
WHERE ct.city = 'London';

-- [3] 도시별 고객 수 조회
-- 같은 대상 테이블
-- 집계 -> 도시별 고객 수
-- 정렬 -> 고객 수가 많은 순서대로 

SELECT 
    ct.city AS 도시명,
    COUNT(*) AS 고객수
FROM 
    customer AS c 
    LEFT JOIN
    address AS a
    ON c.address_id = a.address_id
    LEFT JOIN
    city AS ct
    ON ct.city_id = a.city_id
GROUP BY ct.city
ORDER BY 고객수 DESC;

-- [4] 고객 전체 주소 정보 조회 (주소 + 도시 + 국가)
-- 대상 테이블
    -- 1) customer
    -- 2) address
    -- 3) city
    -- 4) counry
SELECT 
    c.first_name AS 이름,
    c.last_name AS 성,
    a.address AS 주소,
    ct.city AS 도시,
    co.country AS 국가
FROM
    customer AS c
    LEFT JOIN address AS a USING (address_id)
    LEFT JOIN city AS ct USING (city_id)
    LEFT JOIN country AS co USING (country_id);


-- [5] 배우가 출연한 영화 조회
-- 대상 테이블
    -- 1) actor
    -- 2) film_actor -> 중계테이블
    -- 3) film 
-- 의도 : 한번이라도 영화에 출연한 배우만을 확인하고자 함
-- => INNER JOIN
SELECT 
    a.first_name AS 이름,
    a.last_name AS 성,
    f.title AS 영화제목
FROM 
    actor AS a
    JOIN
    film_actor AS fa
    ON a.actor_id = fa.actor_id
    JOIN
    film AS f
    ON fa.film_id = f.film_id;

-- [6] 특정 배우가 출연한 영화의 제목을 조회
-- 대상 테이블은 똑같다!
SELECT 
    a.first_name AS 이름,
    a.last_name AS 성,
    f.title AS 영화제목
FROM 
    actor AS a
    JOIN
    film_actor AS fa
    ON a.actor_id = fa.actor_id
    JOIN
    film AS f
    ON fa.film_id = f.film_id
WHERE a.first_name = 'PENELOPE'
    AND a.last_name = 'MONROE';