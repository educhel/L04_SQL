-- ===== 윈도우 함수 =====
-- 각 행의 개별 정보 유지 + 집계된 값을 붙이기
-- 행을 유지한채로 파티션별 추가 집계된 정보를 붙여서 "비교" 가능

SELECT
    co.`Name`,
    co.`Continent`,
    co.`GNP`,
    AVG(co.`GNP`) OVER(PARTITION BY co.`Continent`) AS 대륙평균GNP
FROM country AS co;

-- GROUP BY로 계산한 결과에 대해 JOIN 하는 형태로 추가했던 이전 방식보다
-- 훨씬 더 쉽고 간단하게 원본 행에 집계 값을 추가하여 표시할 수 있다.

-- 이전이었다면?
WITH avg_gnp AS (
    SELECT `Continent`, AVG(GNP) AS 평균GNP
    FROM country
    GROUP BY `Continent`
)
SELECT 
    co.`Name`,
    co.`Continent`,
    ag.평균GNP
FROM country AS co
    JOIN
    avg_gnp as ag
    ON co.`Continent` = ag.`Continent`;

-- [1] 대표 프레임
-- 예시 : 누적합계
-- 아시아 국가들을 인구수를 기준으로 내림차순하고, 이들을 누적합
SELECT
    co.`Name` AS 국가명,
    co.`Population` AS 인구수,
    SUM(co.`Population`) OVER(
                            ORDER BY co.`Population` DESC 
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- 생략 가능(자동 인식)
                            ) AS "인구수 누적합"
FROM country AS co
WHERE co.`Continent` = 'Asia';

-- 예시 : 이동평균
SELECT 
    co.`Name`,
    co.`GNP`,
    AVG(co.`GNP`) OVER(
                    ORDER BY co.`GNP`
                    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
                    ) AS 3개국_이동평균
FROM country AS co
WHERE co.`Continent` = 'Europe'; -- 시계열 데이터에서 스무딩 시키고자 할 때
