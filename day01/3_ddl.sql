-- DDL : 데이터 구조 정의

-- [1] CREATE : 생성
-- 객체 생성
SHOW DATABASES; -- 생성 이전 데이터 베이스 확인

-- (1) 데이터베이스 생성
CREATE DATABASE lecture;
SHOW DATABASES; -- 생성 확인

-- (2) 테이블 생성
USE lecture; -- 데이터베이스 선택

CREATE TABLE user (
    user_id INT PRIMARY KEY, -- 기본키
    name VARCHAR(50),
    email VARCHAR(100)
);

SHOW TABLES;

-- [2] ALTER : 변경
-- (1) 컬럼 추가
ALTER TABLE `user`
ADD birthday DATE NOT NULL;

DESCRIBE user; -- 확인

-- (2) 컬럼 수정
-- 제약 조건 및 자료 타입 수정
ALTER TABLE user
MODIFY name VARCHAR(20) NOT NULL;

DESC user;

-- [3] DROP : 삭제
CREATE TABLE test (
    id INT PRIMARY KEY,
    name VARCHAR(20)
);
DESC test; -- 잘 생성되었는지 확인


-- 앞서 생성한 test 테이블 삭제
DROP TABLE test;

-- 만약 test 테이블이 없는 경우에는 어떻게 될까?
-- 있는 경우에만 조건을 걸어서 삭제할 수도 있다.
-- DROP TABLE test; -- 없어서 에러 발생
DROP TABLE IF EXISTS test; -- 없어도 에러 발생하지 않음

SHOW TABLES;

-- [4] RENAME : 이름 변경
RENAME TABLE user
TO user_info;

SHOW TABLES;

----
-- 생성의 쿼리 뽑아서 볼 수도 있다.
SHOW CREATE TABLE user_info;