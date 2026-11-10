-- INSURANCE ANALYTICS PLATFORM
-- File: seed_regions.sql
-- Purpose: Populate regional lookup table


INSERT INTO regions(region, region_description)
VALUES
    ('southwest', 'Southwestern Region'),
    ('southeast', 'Southeastern Region'),
    ('northwest', 'Northwestern Region'),
    ('northeast', 'Northeastern Region')
ON CONFLICT (region)
DO UPDATE SET
    region_description = EXCLUDED.region_description;