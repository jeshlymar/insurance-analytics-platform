-- INSURANCE ANALYTICS PLATFORM
-- File: 01_data_quality.sql
-- Purpose: Validate data loaded into PostgreSQL


-- 1. Verify total number of records
SELECT
    COUNT(*) AS total_records
FROM claims;


-- 2. Check for missing values
SELECT
    COUNT(*) FILTER (WHERE age IS NULL) AS missing_age,
    COUNT(*) FILTER (WHERE sex IS NULL) AS missing_sex,
    COUNT(*) FILTER (WHERE bmi IS NULL) AS missing_bmi,
    COUNT(*) FILTER (WHERE children IS NULL) AS missing_children,
    COUNT(*) FILTER (WHERE smoker IS NULL) AS missing_smoker,
    COUNT(*) FILTER (WHERE region IS NULL) AS missing_region,
    COUNT(*) FILTER (WHERE claim_amount IS NULL) AS missing_claim_amount
FROM claims;


-- 3. Check for duplicate records
WITH duplicate_groups AS (
    SELECT
        age, sex, bmi, children, smoker, region,
        claim_amount, age_group, high_claim, bmi_category,
        COUNT(*) AS duplicate_count
    FROM claims
    GROUP BY
        age, sex, bmi, children, smoker, region,
        claim_amount, age_group, high_claim, bmi_category
    HAVING COUNT(*) > 1
)
SELECT
    COUNT(*) AS duplicate_groups,
    COALESCE(SUM(duplicate_count - 1), 0) AS duplicate_records
FROM duplicate_groups;


-- 4. Verify claim amount statistics
SELECT
    COUNT(*) AS total_records,
    SUM(claim_amount) AS total_claim_amount,
    AVG(claim_amount) AS average_claim_amount,
    MIN(claim_amount) AS minimum_claim,
    MAX(claim_amount) AS maximum_claim
FROM claims;
