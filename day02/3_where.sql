-- ===== WHERE 조건으로 필터링 하기 =====
USE world;
SHOW TABLES;
DESC country;

-- [1] 비교 연산자
-- (1) 대소비교
-- > 혹은 >= : 크거나 같다
-- < 혹은 <= : 작거나 같다

SELECT *
FROM country AS c
WHERE c.`Population` >= 10000000;

-- (2) 일치 비교
-- = : 같다
-- <> : 같지 않다
SELECT *
FROM country AS c
WHERE c.`Population` = 10000000;

-- [2] 논리 연산자
-- AND : ㅇㅇ이면서 ㅇㅇ를 만족하는 경우에만 필터링
-- OR : oo이거나 oo 둘중 하나라도 만족된다면 필터링
-- NOT : 반대
DESC country;

SELECT *
FROM country AS c
WHERE c.`IndepYear` > 1990 -- 조건1
    AND c.`Continent` = 'Asia'
    AND c.`Population` > 1000000 -- 조건2
    ;  -- 조건3

-- 위에서 아래로 진행
-- 조건1 AND 조건2 -> (조건1 AND 조건2)을 만족한 조건결과 AND 조건3

-- [3] 범위 연산
-- 연속된 범위를 지정할 수 있는 컬럼(숫자의 형태)에 경우 의미가 있다.

-- BETWEEN A AND B : A와 B 사이에 있는 값만을 필터링
-- NOT BETWEEN A AND B : A와 B 사이에 있지 않은 값만을 필터링

SELECT *
FROM country AS c
WHERE c.`LifeExpectancy` BETWEEN 80 AND 100;

-- [4] 포함 연산
-- IN : 목록 안에 있는 모든 케이스에 대해서만 필터링

SELECT *
FROM country AS c
WHERE c.Code IN ('KOR','JPN','CHN');

-- 사실상 똑같다
SELECT *
FROM country AS c
WHERE c.Code  = 'KOR'
    OR c.Code = 'JPN'
    OR c.Code = 'CHN';

-- [5] NULL 여부
-- IS NULL : 결측이면 True, 결측이 아니면 False -> 결측인 경우만 본다.
-- IS NOT NULL : 결측이면 False, 결측이 아니면 True  -> 결측이 아닌 경우만 본다.
DESC country;

SELECT *
FROM country AS c
WHERE c.`LifeExpectancy` IS NULL
    AND c.`IndepYear` IS NOT NULL;

-- [6] 패턴 매칭
-- LIKE : 특정 패턴처럼 보이는 행만 필터링
-- LIKE 뒤에는 "패턴"이 온다
-- "%" : 0개 이상의 글자
-- "_" : 1개의 글자

SELECT *
FROM country AS c
WHERE c.Name LIKE "S%"; -- S로 시작

SELECT *
FROM country AS c
WHERE c.Name LIKE "%S"; -- S로 끝

SELECT *
FROM country AS c
WHERE c.Name LIKE "S_";

-----------------------------

-- WHERE 목적 : 각각의 조건 연산을 이어서 원하는 형태의 행만 선택할 수 있다.
SELECT *
FROM country AS co
WHERE co.`Continent` = 'Asia' -- 일치 연산
    AND co.`IndepYear` > 1930 -- 논리연산
    AND co.`LifeExpectancy` IS NOT NULL -- 결측 여부
    AND NOT co.`Code` IN ('KOR','JPN','CHN')
    AND co.`Name` LIKE '%n%';

