-- ==== HAVING으로 추가 필터링하기 ==== 
-- 예시 1: 대륙 별 국가 수가 20개가 넘는 대륙, 국가 수 조회

SELECT co.`Continent`, COUNT(*)
FROM country AS co
GROUP BY co.`Continent`
HAVING COUNT(*) > 30; -- 집계함수에 대한 결과로 그룹을 다시 필터링

-- 예시 2: Region 별 평균 인구가 100000000이 넘는 지역, 평균 인구 조회
SELECT co.`Region` AS 지역, AVG(co.`Population`) AS 평균인구
FROM country AS co
GROUP BY co.`Region`
HAVING 평균인구 > 100000000;

-- 예시3: 대륙 별 인구가 1000만 이상인 국가의 수가 10개가 넘는 대륙, 국가 수 조회
SELECT co.`Continent`, COUNT(*) AS big_countries
FROM country AS co
WHERE co.`Population` >= 10000000 -- 기본행 필터링
GROUP BY co.`Continent`
HAVING big_countries >= 10; -- 집계 결과 추가 필터링

-- 예시4: 평균 인구수가 10000000 이 넘는 대륙 의 국가 수 
-- 평균 인구수 10000000 -> 대륙을 수식

SELECT co.`Continent`, COUNT(*)
FROM country AS co
GROUP BY co.`Continent`
HAVING AVG(co.`Population`) > 10000000;