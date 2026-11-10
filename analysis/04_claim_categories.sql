-- INSURANCE ANALYTICS PLATFORM
-- File: 04_claim_categories.sql
-- Purpose: Categorize and analyze claim amounts


-- 1. Classify records by claim amount
SELECT
    CASE
        WHEN claim_amount < 5000 THEN 'Low Claim'
        WHEN claim_amount < 15000 THEN 'Medium Claim'
        ELSE 'High Claim'
    END AS claim_category,
    COUNT(*) AS total_records,
    ROUND(AVG(claim_amount)::NUMERIC, 2) AS average_claim,
    ROUND(SUM(claim_amount)::NUMERIC, 2) AS total_claims
FROM claims
GROUP BY
    CASE
        WHEN claim_amount < 5000 THEN 'Low Claim'
        WHEN claim_amount < 15000 THEN 'Medium Claim'
        ELSE 'High Claim'
    END
ORDER BY average_claim DESC;


-- 2. Count records by engineered high-claim indicator
SELECT
    high_claim,
    COUNT(*) AS total_records,
    ROUND(AVG(claim_amount)::NUMERIC, 2) AS average_claim
FROM claims
GROUP BY high_claim
ORDER BY high_claim DESC;
