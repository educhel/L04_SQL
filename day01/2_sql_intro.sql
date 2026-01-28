-- SQL의 특징
-- (1) 쿼리가 끝났음을 알리는 세미콜론 ;
USE world;
SHOW TABLES;

-- (2) 대소문자 구분
-- (권장)
-- SQL 키워드는 대소문자를 가리지 않음
-- 하지만, 가독성을 위해 키워드는 대문자 
SELECT *
FROM city
LIMIT 5;

-- 똑같다.
select * from city limit 5;

-- 테이블명, 칼럼명은 소문자 혹은 스네이크 케이스로 사용할 것
SELECT *
FROM city
LIMIT 5;

-- (3) 주석
-- ctrl + / : vscode 상 지원
-- 뒤에 값들은 코드로서 인정되지 않는다. (주석처리)
SELECT c.`Name`, c.`District`, c.`Population`
FROM city AS c
WHERE c.`Population` > 10000000; -- 인구가 1000만 초과인 경우만 필터링

/*
여러줄
주석도
가능합니다.
*/
SHOW TABLES;

-- (4) 정렬과 띄어쓰기
-- 공백 갯수와 쿼리 값의 결과는 무관

-- 가독성에 따라 쿼리를 적절하게 개행해 줘야 된다.
SELECT c.`Name`, c.`District`, c.`Population` FROM city AS c WHERE c.`Population` > 10000000;

-- 똑같다.
SELECT c.`Name`, c.`District`, c.`Population`
FROM city AS c
WHERE c.`Population` > 10000000;