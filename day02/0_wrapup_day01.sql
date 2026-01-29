-- ====== 1일차 복습 ======
-- 데이터베이스들 > "데이터베이스" > 테이블들 > "테이블"
-- 데이터베이스 목록 확인하기
SHOW DATABASES;

-- 데이터베이스 사용하기
USE lecture;

-- 데이터베이스 내 테이블들의 목록 살펴보기
SHOW TABLES;

DESCRIBE user_info;

-- ====== DDL ======
-- Data Definition Language = 설계자의 언어
-- (구조에 대한) 생성, 변경, 삭제, 객체 이름 변경

-- [1] CREATE : 객체 생성
-- 데이터베이스, 테이블, 뷰 등의 객체 생성

-- 예시 1: 학생 테이블 생성
CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT, -- 
    name VARCHAR(10),
    grade INT NOT NULL, -- 정수 & 결측이 발생 X
    major VARCHAR(20) -- 가변길이문자열
);
SHOW TABLES;
DESC student; 

-- 예시 2: 외래키가 있는 테이블
CREATE TABLE attendace (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT REFERENCES student(student_id), -- 외래키 참조 연결
    date DATETIME,
    status ENUM('출석','미출석')
);

DESC attendace;

-- [2] ALTER : 객체 변경
-- 기존 객체 구조 수정 혹은 추가

-- (1) 컬럼 추가
ALTER TABLE student
ADD phone VARCHAR(20);

DESC student;

-- (2) 컬럼 수정
ALTER TABLE student
MODIFY grade ENUM('1학년','2학년','3학년','4학년');

DESC student;

-- [3] DROP : 객체 삭제
-- 데이터베이스,테이블,뷰 등의 객체를 완전 삭제

SHOW TABLES;

DROP TABLE IF EXISTS attendace;

SHOW TABLES;

-- [4] RENAME : 객체 이름 변경
RENAME TABLE student
TO students;

SHOW TABLES;

-- => 데이터를 담을 그릇과 규칙을 만든다!

-- ===== DML =====
-- Data Manupulation Language = "분석가"를 위한 언어
-- (데이터 값을) 삽입, 조회, 수정, 삭제 
-- => 구조는 건들지 않는다!

-- [1] INSERT : 데이터 삽입
SELECT *
FROM students;

DESC students;

-- 다중행 입력
INSERT INTO students (name, grade, major)
VALUES ('alex','1학년','경제학과'),
        ('jun','4학년','컴퓨터공학과'),
        ('ken','3학년','경영학과');

SELECT *
FROM students;

-- 구조를 따르지 않아(grade 제약조건 위배), 값 삽입 불가능
INSERT INTO students (name, grade)
VALUES ('chelsea','예비입학생');


-- [2] SELECT : 데이터 조회
-- 데이터에 영향을 미치지 않음
-- 단순히 저장되어 있는 데이터들을 원하는 형태로 불러와서 확인함

SELECT name, grade, major
FROM students;

SELECT name, grade, major
FROM students
WHERE major = '경제학과';

-- [3] UPDATE : 데이터 수정
UPDATE students
SET major = '자율전공' -- 특정 컬럼의 값을 수정
WHERE grade = '1학년'; -- 조건에 따라

SELECT name, grade, major
FROM students;

-- [4] DELETE : 데이터 삭제
DELETE FROM students
WHERE student_id = 3;

SELECT *
FROM students;

DELETE FROM students
WHERE phone IS NULL;

SELECT *
FROM students;

-- 오늘 이후로 조회만 한다!
-- lecture 데이터베이스 삭제를 위해서 써야 하는 명령어
DROP DATABASE lecture;
SHOW DATABASES;