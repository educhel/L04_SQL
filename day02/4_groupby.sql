-- ===== Group by로 집계하기 ===== 

USE world;
SHOW TABLES;
DESC country;

-- 예시 : 대륙별로 몇 개의 나라가 있는지 확인하기
-- GROUP BY의 기본 형태
SELECT co.`Continent` AS 대륙별, COUNT(*) AS 나라수
FROM country AS co
GROUP BY co.`Continent`;

-- Group 별로 나누는 이유는?
-- 그룹별 특정 컬럼이 어떻게 되는지 비교하고 싶어서
-- 너무나도 많은 행들이 있으니, 이걸 요약하자!
-- => 요약 가능한 집계 함수들과 함께 쓰인다.

DESC country;

-- Error: Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'world.co.Region' 
-- which is not functionally dependent on columns in GROUP BY clause; 
-- this is incompatible with sql_mode=only_full_group_by

SELECT co.`Continent` AS 대륙별, co.`Region` AS 그룹별, COUNT(*) AS 나라수
FROM country AS co
GROUP BY co.`Continent`;

-- 불가능!

-- GROUP BY 사용시 유의할 점
-- SELECT 에는 
-- 1) GROUP BY 절에서 사용한 기준 컬럼이 오거나
-- 2) 집계함수만 올 수 있다.

-- 예시1: Region 별 평균 인구
SELECT co.`Region` AS 지역, AVG(co.`Population`) AS 평균인구
FROM country AS co
GROUP BY co.`Region`;

-- 예시2: 대륙 별 최소 / 최대 인구
SELECT co.`Continent` AS 대륙별, 
        MIN(co.`Population`) AS 최소인구, 
        MAX(co.`Population`) AS 최대인구
FROM country AS co
GROUP BY co.`Continent`;

-- 예시3: 대륙 별 "인구가 1000만 이상"인 국가의 수
-- 조건 추가 : "인구가 1000만 이상"인 경우만 셀 수 있도록
SELECT co.`Continent`, COUNT(*) -- 1
FROM country AS co -- 2 (정답)
WHERE co.`Population` >= 10000000
GROUP BY co.`Continent`; --- 3



