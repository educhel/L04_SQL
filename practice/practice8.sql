-- 실전! SQL 실습 (8)

-- [1] 카테고리 기반 영화 목록 조회 
-- (기준 목록이 먼저 필요한 경우) 비연관 서브쿼리
-- 메인쿼리와 관계 없이 실행

-- 실행 순서
-- (1) ‘Action’이라는 고정된 기준에 해당하는 영화 ID 목록을 만들기 -> 서브쿼리
-- (2) 그 결과를 바탕으로 영화 정보 조회 -> 메인쿼리

-- 2) 메인쿼리 : 영화 ID 목록에 해당하는 영화 정보를 조회
SELECT f.title, f.description
FROM film AS f
WHERE f.film_id IN ( 
-- 1) 서브쿼리 : Action 카테고리에 속한 영화의 ID 목록을 조회
    SELECT fc.film_id
    FROM 
        film_category AS fc
        INNER JOIN 
        category AS c
        ON c.category_id = fc.category_id
    WHERE c.name = 'Horror'
);


-- [2] 고객별 최신 상태 요약 조회
-- (행마다 기준이 달라지는 경우)
-- => 연관 서브쿼리
-- 메인쿼리와 관련이 있다! 
-- 서브쿼리가 실행이 되는데, 메인쿼리의 값을 사용한다.

SELECT 
    c.first_name,
    c.last_name,
    ( -- 2) 전달받은 customer_id에 해당하는 최신일을 조회
    SELECT MAX(r.rental_date)
    FROM rental AS r
    WHERE r.customer_id = c.customer_id 
    -- 1) 메인쿼리의 값을 전달받음 (참조)
    ) AS last_rental_date
FROM customer AS c;


-- [3] 특정 행동 이력 존재 여부 확인
-- (있다 / 없다만 중요한 경우)
-- => 연관 서브쿼리 (EXISTS 활용)

-- 강의 자료 내 "세부설명" 꼭 확인할 것!