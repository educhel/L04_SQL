-- SHOW 명령어 : 확인한다.

-- (1) 데이터베이스 목록 확인
SHOW DATABASES;

-- (2) 데이터베이스 선택
USE sakila;

-- (3) 데이터베이스 내 테이블 목록 확인
SHOW TABLES;

-- 데이터 구조 파악하기
-- 테이블 별 속성의 이름, 유형, 결측여부 등을 파악 가능
-- (Basic) 구성
DESCRIBE actor;
DESC city;


-- (+) 테이블 생성시, 작성한 쿼리 원문 확인하기
-- 테이블의 구조를 설계단부터 파악하고 싶을 때 사용
SHOW CREATE TABLE sakila.actor;