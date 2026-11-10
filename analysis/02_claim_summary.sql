-- INSURANCE ANALYTICS PLATFORM
-- File: 02_claim_summary.sql
-- Purpose: Analyze overall insurance claim amounts


-- 1. Overall claim statistics
SELECT
    COUNT(*) AS total_records,
    SUM(claim_amount) AS total_claim_amount,
    AVG(claim_amount) AS average_claim_amount,
    MIN(claim_amount) AS minimum_claim,
    MAX(claim_amount) AS maximum_claim
FROM claims;


-- 2. Claim summary by smoking status
SELECT
    smoker,
    COUNT(*) AS total_records,
    ROUND(AVG(claim_amount)::NUMERIC, 2) AS average_claim,
    ROUND(SUM(claim_amount)::NUMERIC, 2) AS total_claim_amount
FROM claims
GROUP BY smoker
ORDER BY average_claim DESC;


-- 3. Claim summary by BMI category
SELECT
    bmi_category,
    COUNT(*) AS total_records,
    ROUND(AVG(claim_amount)::NUMERIC, 2) AS average_claim
FROM claims
GROUP BY bmi_category
ORDER BY average_claim DESC;
