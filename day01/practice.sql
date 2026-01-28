-- 실전! DDL과 DML
-- [1] practice 데이터베이스를 만들고, practice를 사용할 데이터베이스로 선택하세요.

-- 문제 의도 : 데이터베이스 구조 생성(DDL)
CREATE DATABASE practice;
SHOW DATABASES;

USE practice;
SHOW TABLES;

-- [2] 학생(student) 테이블을 다음과 같이 생성하는 SQL 문을 작성하세요.
-- 문제 의도 : 테이블 구조 생성(DDL)

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    grade INT
    -- grade ENUM('1학년','2학년','3학년','4학년') -- 열거형의 경우
);

SHOW TABLES;
DESC student;

SELECT *
FROM student; -- 비어 있음

-- [3] 위에서 생성한 student 테이블에 아래 데이터를 "삽입"하는 SQL 문을 작성하세요.
-- 문제 의도 : 값 추가(DML)
INSERT INTO student (name, grade)
VALUES  ('홍길동',3),
        ('김철수',2),
        ('박병철',1),
        ('안새싹',3);

SELECT *
FROM student; -- 데이터 확인(조회)

-- [4] student 테이블에서 이름이 '안새싹'인 학생의 학년을 4로 수정하는 SQL 문을 작성하세요.
-- 문제 의도 : 값 수정(DML)
UPDATE student
SET grade = 4
WHERE name = '안새싹';

SELECT *
FROM student; -- 데이터 확인(조회)

-- [5] student 테이블에서 학년이 2인 학생을 삭제하는 SQL 문을 작성하세요.
-- 문제 의도 : 값 삭제 (DML)
DELETE FROM student
WHERE grade = 2;

SELECT *
FROM student; -- 데이터 확인(조회)

-- [6] 실습에서 사용 완료한 practice 데이터베이스를 삭제하세요.
-- 문제의도 : 구조 삭제 (DDL)
DROP DATABASE IF EXISTS practice;

SHOW DATABASES;