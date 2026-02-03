-- 실전! SQL 실습 (9)

USE sakila;

-- [1] 특정 카테고리 영화를 ‘한 번도’ 빌리지 않은 고객 리스트 만들기 (마케팅 타겟팅)
-- (참고) 연관 서브쿼리
-- -> 바로 분리 불가능
SELECT c.first_name, c.last_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    WHERE r.customer_id = c.customer_id
    AND cat.name = 'Action'
);

-- 1단계 : Action 영화를 빌린 고객의 목록을 뽑기
-- CTE 정의
WITH action_rent_customer AS (
    SELECT DISTINCT r.customer_id
    FROM 
        rental AS r
        INNER JOIN
        inventory AS i ON r.inventory_id = i.inventory_id
        INNER JOIN
        film_category AS fc ON i.film_id = fc.film_id
        INNER JOIN 
        category AS cat ON fc.category_id = cat.category_id
    WHERE cat.name = 'Action'
    
)
-- 2단계 : 고객이 해당 목록에 존재하는지
    -- "모든 고객" 대상 -> 대여한 적이 있는지 여부 판단
-- 메인 쿼리
SELECT c.first_name, c.last_name
FROM customer AS c -- 기준 테이블
    LEFT JOIN 
    action_rent_customer AS arc
    ON c.customer_id = arc.customer_id
WHERE arc.customer_id IS NULL;


-- [2] 우수 고객이 실제로 소비한 영화 목록 뽑기 (콘텐츠 추천/편성 후보군)
-- (참고) 서브쿼리
-- 서브퀴리 안에 서브쿼리가 중첩된 구조를 띄고 있다.
-- => CTE로 변환하기 위해 가장 내부에 있는 서브쿼리부터 하나씩 작성
SELECT DISTINCT f.title
FROM film f
WHERE f.film_id IN (
    SELECT i.film_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE r.customer_id IN (
        SELECT customer_id
        FROM rental
        GROUP BY customer_id
        HAVING COUNT(*) >= 40
    )
);

-- 1단계 : 대여 횟수가 40회 이상인 고객목록을 뽑는다.
WITH heavy_user AS (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) >= 40
),
-- 2단계 : heavy_user가 대여한 영화 목록 뽑기
rentedfilm_by_heavyuser AS (
    SELECT DISTINCT i.film_id
    FROM inventory AS i
    JOIN rental AS r
    ON i.inventory_id = r.inventory_id
    WHERE r.customer_id IN (
        SELECT customer_id
        FROM heavy_user -- CTE 1 사용
    )
)
-- 3단계 : 마지막에 영화 제목으로 매핑한다.
SELECT f.title
FROM film AS f
JOIN rentedfilm_by_heavyuser AS rfh
ON f.film_id = rfh.film_id;
