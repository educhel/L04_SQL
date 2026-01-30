-- 세 개 이상의 테이블 JOIN하기
USE world;
SELECT DATABASE();

-- 예시1 : world 데이터 베이스

SELECT 
    co.`Name` AS 국가명,
    ct.`Name` AS 수도명,
    cl.`Language` AS 공식언어
FROM 
    country AS co
    INNER JOIN 
    city AS ct
    ON co.`Capital` = ct.`ID` -- 수도의 케이스만 JOIN
    INNER JOIN
    countrylanguage AS cl
    ON cl.`CountryCode` = co.`Code`
WHERE cl.`IsOfficial` = 'T';

-- 예시 2: sakila
USE sakila;

-- 배우가 출연한 영화
-- 대상테이블
    -- 1) 영화(film)
    -- 2) film_actor
    -- 3) 배우(actor)

SELECT 
    a.first_name AS 이름,
    a.last_name AS 성,
    f.title AS 영화이름
FROM 
    film AS f
    INNER JOIN
    film_actor AS fa
    ON f.film_id = fa.film_id
    INNER JOIN
    actor AS a
    ON a.actor_id = fa.actor_id
ORDER BY 이름, 성
LIMIT 5;


-- 예시 : 같은 컬럼명일때의 USING 사용
USE sakila;
SELECT 
    a.first_name,
    a.last_name,
    f.title
FROM 
    actor AS a
    INNER JOIN
    film_actor AS fa
    USING (actor_id)
    INNER JOIN
    film AS f
    USING (film_id);

-- 공백, 들여쓰기, 개행의 형태는 편한대로 작성할 것 
-- 단, 가독성 확보는 필수!