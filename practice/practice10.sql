-- ==== 실전! SQL 실습 (10) ====
USE sakila;
SELECT DATABASE();

-- [1] 고객 표시용 이름 컬럼 만들기
DESCRIBE customer;

-- 의도 : 문자열 함수 -> concat을 사용하여 값 연결
SELECT CONCAT(c.last_name, ", ", c.first_name) AS fullname
FROM customer AS c;


-- [2] 출력 포맷 통일을 위한 문자열 변환
DESCRIBE film;

-- 의도 : 문자열 함수 -> UPPER, LOWER
SELECT UPPER(f.title), LOWER(f.description)
FROM film AS f;

-- [3] 이메일 주소에서 사용자 ID 분리
-- 의도 : 문자열 분할 -> "@"
SELECT c.email, SUBSTRING_INDEX(c.email,'@', 1) AS 사용자ID
FROM customer AS c;

-- [4] 금액 처리 기준에 따른 값 차이 확인
SELECT 
    p.amount,
    ROUND(p.amount) AS 반올림,
    CEIL(p.amount) AS 올림,
    FLOOR(p.amount) AS 버림
FROM payment AS p;


-- [5] 리포트용 날짜 포맷 변환
-- 의도 : DATE_FORMAT 을 통한 표기방식 변환
SELECT DATE_FORMAT(r.rental_date,'%Y-%m-%d (%a)')
FROM rental AS r
LIMIT 10;

-- [6] 요일별 매출 패턴 분석
-- 대상 테이블 : rental + payment
-- 집계의 기준 : 요일별 -> %a를 통한 요일별 변환

SELECT 
    DATE_FORMAT(r.rental_date,'%a') AS 요일별,
    COUNT(*) AS 렌탈건수,
    SUM(p.amount) AS 총수익
FROM 
    rental AS r
    INNER JOIN
    payment AS p
    ON r.rental_id = p.rental_id
GROUP BY DATE_FORMAT(r.rental_date,'%a')
ORDER BY 렌탈건수 DESC;


-- [7] 실제 대여 기간 계산
-- 날짜 - 날짜 연산

SELECT DATEDIFF(r.return_date,r.rental_date) AS 대여기간
FROM rental AS r;

SELECT AVG(DATEDIFF(r.return_date,r.rental_date)) AS 평균대여일수
FROM rental AS r;

-- - 연산 시, 의도한 바와 다르게 연산되는 모습을 확인 가능
SELECT r.return_date - r.rental_date
FROM rental AS r;
