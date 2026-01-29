-- 실전! SQL 실습 (1)

USE world;
SHOW TABLES;

-- [1] 인구가 800만 이상인 "도시"의 Name, Population을 조회하시오
-- 문제 의도 : 비교 연산 (대소비교) 연습
SELECT ct.`Name`, ct.`Population`
FROM city AS ct
WHERE ct.`Population` >= 8000000;

-- [2] 한국(KOR)에 있는 도시의 Name, CountryCode를 조회하시오
-- 문제 의도 : 비교연산 (일치비교) 연습
DESC city;

SELECT ct.`Name`, ct.`CountryCode`
FROM city AS ct
WHERE ct.`CountryCode` = 'KOR';

-- [3] 이름이 'San'으로 시작하는 도시의 Name을 조회하시오

SELECT ct.`Name`
FROM city AS ct
WHERE ct.`Name` LIKE "San%";

-- [4] "인구가 100만에서 200만 사이"인 "한국" 도시의 "Name"을 조회하시오
-- 문제의도 : 문제에 숨겨져 있는 조건을 살펴보아라.
-- 조건 1: "인구가 100만에서 200만 사이" -> 범위
-- 조건 2: "한국" -> 일치
-- (조건1) AND (조건2)로 논리 연산하라

SELECT ct.`Name`
FROM city AS ct
WHERE ct.`Population` BETWEEN 1000000 AND 2000000
    AND ct.`CountryCode` = 'KOR';

-- [5] "인구가 500만 이상"인 "한국, 일본, 중국"의 도시의 Name, CountryCode, Population 을 조회하시오
-- 인구가 500만명 이상 이면서 (AND) 한국,일본,중국이라는 나라 코드를 가진 경우만 선택해서 조회하라

SELECT ct.`Name`, ct.`CountryCode`, ct.`Population`
FROM city AS ct
WHERE ct.`Population` >= 5000000
    AND ct.`CountryCode` IN ('KOR','JPN','CHN');

-- [6] "오세아니아 대륙"에서 "예상 수명의 데이터가 없는" "나라"의 
-- "Name, LifeExpectancy, Continent"를 조회하시오.

-- 대상 테이블 = country
SELECT DISTINCT co.`Continent`
FROM country AS co; -- Oceania 를 뽑아내기 위한 코드

SELECT co.`Name`, co.`LifeExpectancy`, co.`Continent`
FROM country AS co
WHERE co.`Continent` = 'Oceania'
    AND co.`LifeExpectancy` IS NULL;