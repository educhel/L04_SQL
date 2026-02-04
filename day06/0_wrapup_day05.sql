-- 가상 테이블

-- [1] VIEW
USE sakila;
SHOW TABLES;

SHOW CREATE VIEW nicer_but_slower_film_list; -- VIEW 객체 확인
-- 확인을 통해 파악한 VIEW 저장 쿼리
select `film`.`film_id` AS `FID`,
    `film`.`title` AS `title`,
    `film`.`description` AS `description`,
    `category`.`name` AS `category`,
    `film`.`rental_rate` AS `price`,
    `film`.`length` AS `length`,
    `film`.`rating` AS `rating`,
    group_concat(concat(concat(upper(substr(`actor`.`first_name`,1,1)),lower(substr(`actor`.`first_name`,2,length(`actor`.`first_name`))),_utf8mb4' ',concat(upper(substr(`actor`.`last_name`,1,1)),lower(substr(`actor`.`last_name`,2,length(`actor`.`last_name`)))))) separator ', ') AS `actors`
from ((((`film` 
    left join 
    `film_category` 
    on((`film_category`.`film_id` = `film`.`film_id`))) 
    left join `category` 
    on((`category`.`category_id` = `film_category`.`category_id`)))
    left join `film_actor` 
    on((`film`.`film_id` = `film_actor`.`film_id`))) 
    left join `actor` 
    on((`film_actor`.`actor_id` = `actor`.`actor_id`))) 
group by `film`.`film_id`,`category`.`name`;

-- [2] 서브 쿼리
-- 쿼리 안에 쿼리

-- 반환 형태 : 단일행, 다중행, 다중열
-- 동작 방식 : 비연관, 연관

-- 예시 : “Horror 장르 영화를 한 번이라도 대여한 경험이 있는 고객만 추려달라”
SELECT c.first_name, c.last_name
FROM customer AS c
WHERE EXISTS (
    SELECT 1
    FROM 
        rental AS r 
        JOIN inventory AS i ON r.inventory_id = i.inventory_id
        JOIN film AS f ON i.film_id = f.film_id
        JOIN film_category AS fc ON f.film_id = fc.film_id
        JOIN category AS cat ON fc.category_id = cat.category_id
    WHERE cat.name = 'Horror'
        AND c.customer_id = r.customer_id
);

-- [3] CTE
-- 쿼리문 안에서 임시뷰를 선언 -> 이번 쿼리에서만 재사용할 수 있는 "임시뷰"
-- 단계를 나누어서 쿼리문 작성

-- 1단계 : Horror를 한 번이라도 빌려본 고객의 목록 CTE 정의
WITH horror_renters AS (
    SELECT DISTINCT r.customer_id
    FROM 
        rental AS r 
        JOIN inventory AS i ON r.inventory_id = i.inventory_id
        JOIN film AS f ON i.film_id = f.film_id
        JOIN film_category AS fc ON f.film_id = fc.film_id
        JOIN category AS cat ON fc.category_id = cat.category_id
    WHERE cat.name = 'Horror'
)
-- 2단계 : CTE를 이용하여, 메인쿼리에서 대여한 경험이 있는 고객만 이름 조회
SELECT c.first_name, c.last_name
FROM customer AS c
    LEFT JOIN
    horror_renters AS hr
    ON c.customer_id = hr.customer_id
WHERE hr.customer_id IS NOT NULL;

-- ====== 함수 ======
-- [1] 단일행 함수
-- 행에 대해 개별적으로 작동

-- 함수 블럭의 동작
-- 입력 : 값 하나 <- 단일행으로 불리는 이유
-- ~~~ 함수 처리 ~~~
-- 반환 : 값 하나

-- (1) 문자
WITH horror_renters AS (
    SELECT DISTINCT r.customer_id
    FROM 
        rental AS r 
        JOIN inventory AS i ON r.inventory_id = i.inventory_id
        JOIN film AS f ON i.film_id = f.film_id
        JOIN film_category AS fc ON f.film_id = fc.film_id
        JOIN category AS cat ON fc.category_id = cat.category_id
    WHERE cat.name = 'Horror'
)
SELECT CONCAT(c.first_name, ", ", c.last_name)
FROM customer AS c
    LEFT JOIN
    horror_renters AS hr
    ON c.customer_id = hr.customer_id
WHERE hr.customer_id IS NOT NULL;
-- 내가 무엇을 하고 싶은가를 확인 -> 찾아보기

-- (2) 숫자
-- 산술연산 가능
SELECT ROUND(3.14, 1);

SELECT p.amount, FLOOR(p.amount)
FROM payment AS p;

-- (3) 날짜
SELECT NOW(), CURDATE();
SELECT YEAR(NOW()), WEEKDAY(NOW());

SELECT 
    DATE_FORMAT(r.rental_date,'%a') AS 요일별, 
    COUNT(*)
FROM rental AS r
GROUP BY DATE_FORMAT(r.rental_date,'%a');

-- (4) NULL
DESCRIBE rental;

SELECT r.rental_id,r.rental_date, r.return_date
FROM rental AS r
WHERE r.return_date IS NULL;

SELECT 
    r.rental_id,
    r.rental_date, 
    r.return_date,
    COALESCE(r.return_date, r.rental_date, NOW())
FROM rental AS r
WHERE r.return_date IS NULL;

SELECT 
    r.rental_id,
    r.rental_date, 
    r.return_date,
    IFNULL(r.return_date, r.rental_date)
FROM rental AS r
WHERE r.return_date IS NULL;

-- [2] 다중행 함수
-- 여러행에 대해 그룹화 -> 요약, 하나의 대표값으로 반환

-- (1) 집계함수 -> GROUP BY 때 이미 배움
-- (2) 그룹함수 -> 다루지 않음
-- (3) 윈도우함수 -> 오늘 새로 배울 내용

-- ==== 조건 분기 ====
-- [1] IF
-- 주어진 조건에 대해 참 / 거짓 판단
-- 참 반환값, 거짓 반환값
SELECT 
    r.rental_id,
    r.rental_date, 
    r.return_date,
    IF(r.return_date IS NULL,'대여중','반납완료') AS status
FROM rental AS r
ORDER BY r.return_date
LIMIT 6
OFFSET 180;

-- [2] CASE 표현식
-- 다중조건식 구문을 SQL에서 사용하고자 할 때 사용
-- CASE 
--     WHEN 조건1 THEN  결과1
--     WHEN 조건2 THEN  결과2
--     WHEN 조건3 THEN  결과3
--     ELSE  그외값
-- END

WITH film_detail AS (
    SELECT 
        f.title AS 영화명,
        cat.name AS 장르,
        f.rental_rate AS 대여료,
        f.rental_duration AS 대여기간
    FROM 
        film AS f
        JOIN
        film_category AS fc
        ON f.film_id = fc.film_id
        JOIN
        category AS cat
        ON fc.category_id = cat.category_id
    )
SELECT fd.장르,COUNT(*)
FROM film_detail AS fd
GROUP BY fd.장르
ORDER BY COUNT(*) DESC;

SELECT 
    f.title AS 영화명,
    cat.name AS 장르,
    f.rental_rate AS 대여료,
    f.rental_duration AS 대여기간,
    CASE 
        WHEN cat.name IN ('Sports','Family','Foreign') THEN  '인기장르'
        WHEN cat.name IN ('Action','Animation','Documentary') THEN '남성인기'
        WHEN cat.name IN ('New','Drama') THEN '여성인기'
        ELSE '그외'
    END AS '장르분류'
FROM 
    film AS f
    JOIN
    film_category AS fc
    ON f.film_id = fc.film_id
    JOIN
    category AS cat
    ON fc.category_id = cat.category_id