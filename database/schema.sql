-- INSURANCE ANALYTICS PLATFORM
-- File: schema.sql
-- Purpose: Define database tables
-- Database: insurance_db


-- Claims table
-- Loaded and recreated by the Python ETL pipeline

CREATE TABLE IF NOT EXISTS claims (
    age INTEGER,
    sex VARCHAR(20),
    bmi DOUBLE PRECISION,
    children INTEGER,
    smoker VARCHAR(10),
    region VARCHAR(50),
    claim_amount DOUBLE PRECISION,
    age_group VARCHAR(30),
    high_claim BOOLEAN,
    bmi_category VARCHAR(30)
);

-- Regional lookup table

CREATE TABLE IF NOT EXISTS regions (
    region VARCHAR(50) PRIMARY KEY,
    region_description VARCHAR(100)
);