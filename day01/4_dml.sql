USE lecture; -- 데이터베이스 지정
SHOW TABLES; -- 데이터베이스 내 테이블 목록 확인
DESCRIBE user_info; -- 테이블 요약 확인

SELECT *
FROM user_info; -- 현재 비어 있는 테이블

-- DML : 데이터 조작
-- [1] INSERT : 데이터 삽입
-- (1) 단일행 입력
INSERT INTO user_info (user_id, name, email, birthday)
VALUES (101,'alex','alex@example.com','2002.01.01');

-- 입력 확인
SELECT *
FROM user_info;

-- (2) 다중행 입력
INSERT INTO user_info (user_id, name, email, birthday)
VALUES  (102, 'jun', 'jun@example.com','1996.10.30'),
        (103, 'chelsea','chelsea@example.com','1990.01.20');

-- 입력 확인
SELECT *
FROM user_info;

-- 혹시 결측이 있어도 될까?
-- INSERT INTO user_info (user_id, name)
-- VALUES (104, 'ken'); -- 불가능 (birthday가 NULL이 올 수 없음)

INSERT INTO user_info (user_id, name, birthday)
VALUES  (104, 'ken','1976.12.03');

SELECT *
FROM user_info;

-- 에러 케이스
-- Error: Duplicate entry '104' for key 'user_info.PRIMARY'
-- INSERT INTO user_info (user_id, name, birthday)
-- VALUES  (104, 'heather','2003.01.18');

-- Error: Incorrect integer value: 'UUID_104' for column 'user_id' at row 1
-- INSERT INTO user_info (user_id, name, birthday)
-- VALUES  ('UUID_104', 'heather','2003.01.18');

-- [2] SELECT : 데이터 조회
SELECT *
FROM user_info
WHERE name = 'jun';

-- [3] UPDATE : 값 수정
UPDATE user_info
SET birthday = '1988-12-31'
WHERE name = 'jun';

SELECT *
FROM user_info;

-- [4] DELETE : 값 삭제
DELETE FROM user_info
WHERE user_id = 101;

SELECT *
FROM user_info;

DELETE FROM user_info
WHERE email IS NULL;

SELECT *
FROM user_info;