-- INSURANCE ANALYTICS PLATFORM
-- File: 03_regional_analysis.sql
-- Purpose: Compare insurance claims across regions


-- 1. Regional claim summary
SELECT
    region,
    COUNT(*) AS total_records,
    ROUND(AVG(claim_amount)::NUMERIC, 2) AS average_claim,
    ROUND(SUM(claim_amount)::NUMERIC, 2) AS total_claims
FROM claims
GROUP BY region
ORDER BY average_claim DESC;


-- 2. Regional analysis using a lookup table
SELECT
    c.region,
    r.region_description,
    COUNT(*) AS total_records,
    ROUND(AVG(c.claim_amount)::NUMERIC, 2) AS average_claim,
    ROUND(SUM(c.claim_amount)::NUMERIC, 2) AS total_claims
FROM claims c
INNER JOIN regions r
    ON c.region = r.region
GROUP BY
    c.region,
    r.region_description
ORDER BY average_claim DESC;


-- 3. Identify regions above the overall average
WITH regional_summary AS (
    SELECT
        region,
        COUNT(*) AS total_records,
        AVG(claim_amount) AS average_claim
    FROM claims
    GROUP BY region
)
SELECT
    region,
    total_records,
    ROUND(average_claim::NUMERIC, 2) AS average_claim
FROM regional_summary
WHERE average_claim > (
    SELECT AVG(claim_amount)
    FROM claims
)
ORDER BY average_claim DESC;
