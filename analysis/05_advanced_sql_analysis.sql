-- INSURANCE ANALYTICS PLATFORM
-- File: 05_advanced_sql_analysis.sql
-- Purpose: Advanced SQL analytics


-- 1. Rank regions by average claim amount
SELECT
    region,
    COUNT(*) AS total_records,
    ROUND(AVG(claim_amount)::NUMERIC, 2) AS average_claim,
    RANK() OVER (
        ORDER BY AVG(claim_amount) DESC
    ) AS claim_rank
FROM claims
GROUP BY region
ORDER BY claim_rank;


-- 2. Compare individual claims against their regional average
SELECT
    region,
    age,
    claim_amount,
    ROUND(
        AVG(claim_amount) OVER (
            PARTITION BY region
        )::NUMERIC,
        2
    ) AS regional_average,
    ROUND(
        (
            claim_amount - AVG(claim_amount) OVER (
                PARTITION BY region
            )
        )::NUMERIC,
        2
    ) AS difference_from_average
FROM claims
ORDER BY region, claim_amount DESC
LIMIT 15;


-- 3. Find the 15 highest claims above the overall average
SELECT
    age,
    region,
    claim_amount
FROM claims
WHERE claim_amount > (
    SELECT AVG(claim_amount)
    FROM claims
)
ORDER BY claim_amount DESC
LIMIT 15;


-- 4. Compare above-average claims across regions
WITH overall_average AS (
    SELECT AVG(claim_amount) AS avg_claim
    FROM claims
)
SELECT
    c.region,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (
        WHERE c.claim_amount > o.avg_claim
    ) AS above_average_claims,
    ROUND(
        (
            100.0 * COUNT(*) FILTER (
                WHERE c.claim_amount > o.avg_claim
            ) / COUNT(*)
        )::NUMERIC,
        2
    ) AS percentage_above_average
FROM claims c
CROSS JOIN overall_average o
GROUP BY c.region
ORDER BY percentage_above_average DESC;
