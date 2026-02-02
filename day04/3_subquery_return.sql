-- "데이터 반환 형태"에 따른 서브쿼리
USE world;

-- [1] 단일행 서브쿼리
-- 서브쿼리가 단일한 "값" 반환
-- 하나의 값 -> 비교 연산과 주로 사용된다.

-- 예시 1 : "평균 인구수보다 인구가 많은" 도시 조회
-- 대상 테이블 : city
-- 필터링 : 평균인구수보다 크다 (비교연산)
    -- => 평균인구수는? 집계해야만 알수 있음
-- 필터링 걸기 위한 꼭 필요한 "평균 인구수"를 서브쿼리로 만든다.

-- 메인쿼리
SELECT *
FROM city AS ct
WHERE ct.`Population` > (
    SELECT AVG(ct.`Population`)
    FROM city AS ct
    ); -- 서브쿼리 (값 반환)

-- 예시 2: "가장 많은 인구를 가진 도시"의 국가 정보
-- 대상 테이블 
    -- city
    -- country
-- 조건 : 가장 많은 인구의 도시 

SELECT *
FROM country AS co
WHERE co.`Code` = (
    SELECT ct.`CountryCode`
    FROM city AS ct
    ORDER BY ct.`Population` DESC
    LIMIT 1
);

SELECT ct.`CountryCode`
FROM city AS ct
ORDER BY ct.`Population` DESC
LIMIT 1; -- 서브쿼리 반환 (값 하나)


-- [2] 다중행 서브쿼리
-- 서브쿼리가 반환하는 값이 여러개
-- 여러값을 한번에 비교하기 어려워서, "IN", NOT IN, EXISTS 등 사용

-- 예시 : "'English'를 공식 언어로 사용하는 모든 국가"의 이름을 조회하는 경우
-- 대상 테이블
    -- 1) country
    -- 2) contrylanguage -> 서브쿼리
-- 조건 : English + 공식언어
-- 메인쿼리
SELECT co.`Name`
FROM country AS co
WHERE co.`Code` IN (
    SELECT cl.`CountryCode`
    FROM countrylanguage AS cl
    WHERE cl.`Language` = 'English'
    AND cl.`IsOfficial` = 'T'
);

-- 서브쿼리 (반환값 여러개)
-- 여러 행 -> 다중행 서브쿼리
SELECT cl.`CountryCode`
FROM countrylanguage AS cl
WHERE cl.`Language` = 'English'
AND cl.`IsOfficial` = 'T';


-- [3] 다중컬럼 서브쿼리
-- 여러행, 여러컬럼 -> 테이블 형태

-- (1) 인라인 뷰 형태
SELECT bc.`Name`, bc.District, bc.`Population`
FROM (
    SELECT *
    FROM city AS ct
    WHERE ct.`Population` > 5000000
) AS bc;

SELECT ct.`Name`, ct.`Population`
FROM city AS ct
WHERE ct.`Population` > 5000000;

-- 각 나라에서 가장 인구가 많은 도시의 정보를 조회하는 경우
SELECT ct1.`CountryCode`, ct1.`Population`
FROM city AS ct1
WHERE (ct1.`CountryCode`, ct1.`Population`) IN (
    SELECT ct2.`CountryCode`, MAX(ct2.`Population`)
    FROM city AS ct2
    GROUP BY ct2.`CountryCode`
    );