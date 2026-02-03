-- 실전! SQL 실습 (7)
USE sakila;
SELECT DATABASE();

-- [1] 가격 정책 점검을 위한 기준 초과 상품 찾기
-- 대상 테이블 : film
-- 조건 : "전체 평균 대여료"보다 높은 영화
    -- 전체 평균 대여료는? "단일행 서브쿼리"

SELECT f.title, f.rental_rate  -- 메인쿼리
FROM film AS f
WHERE f.rental_rate > (
    SELECT AVG(rental_rate)
    FROM film  -- 서브쿼리
);

SELECT AVG(rental_rate)
FROM film;

-- [2] "특정 고객의 결제 패턴"을 전체 평균과 함께 비교하기
-- 대상 테이블 : payment
-- 필터링 : 특정 고객 -> 고객 ID = 5
-- SELECT -> 결제ID, 결제액, 전체고객평균결제액
-- 의도 : SELECT 문 아래 서브쿼리 -> 전체고객평균결제액 "값"
SELECT 
    p.customer_id AS 고객ID, 
    p.payment_id AS 결제ID, 
    p.amount AS 결제액, 
    (SELECT AVG(amount)
    FROM payment) AS 전체고객평균결제액
FROM payment AS p
WHERE p.customer_id = 5;


-- [3] 특정 "카테고리" 영화의 재고 현황 점검
-- (메인쿼리) 대상테이블 : inventory
-- 조건 : "Action 카테고리에 속한 ID" 인 경우, 필터링
    -- (서브쿼리) 대상 테이블 : film_category
    -- -> 다중행 서브쿼리 
SELECT
    i.inventory_id,
    i.film_id
FROM inventory AS i
WHERE i.film_id IN (
    SELECT fc.film_id
    FROM 
        film_category AS fc
        JOIN  
        category AS c
        ON fc.category_id = c.category_id
    WHERE c.name = 'Action'
);

-- [4] 특정 국가 외 지역 "고객만 선별"하기
-- 대상 테이블 : customer -> 메인 쿼리
-- 조건 : 캐나다에 거주하지 않음
    -- 서브쿼리
        -- 대상 테이블 : address
            -- 서브쿼리
                -- 대상 테이블 : city + country

SELECT c.first_name, c.last_name -- 메인쿼리
FROM customer AS c
WHERE c.address_id IN (
    -- 서브쿼리 1 : 캐나다에 속하지 않는 "주소ID"
    SELECT a.address_id
    FROM address AS a
    WHERE a.city_id NOT IN (
        -- 서브쿼리 2: 캐나다에 속하는 "도시ID"
        SELECT ct.city_id
        FROM 
            city AS ct  
            INNER JOIN
            country AS co
            ON ct.country_id = co.country_id
        WHERE co.country = 'Canada'
    )
);
