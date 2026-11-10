# Insurance Analytics Platform — Project Report

## 1. Project Overview

The Insurance Analytics Platform is a data engineering and analytics project that demonstrates how raw insurance-related data can be extracted, cleaned, transformed, stored in a relational database, and analyzed to identify useful patterns.

The project uses Python and Pandas to build an ETL pipeline, PostgreSQL to store the processed data, and SQL to perform data quality checks and analytical queries.

The dataset contains demographic and health-related attributes alongside insurance charges. The original `charges` field is renamed to `claim_amount` during transformation for the purposes of this project.

## 2. Technology Stack

| Technology | Purpose |
|---|---|
| Python | ETL pipeline development |
| Pandas | Data extraction, cleaning, and transformation |
| PostgreSQL | Relational database storage |
| SQLAlchemy | Python-to-database connectivity |
| psycopg2 | PostgreSQL database driver |
| SQL | Data validation and analysis |
| Git | Version control |

## 3. Project Architecture

The project follows a three-stage ETL workflow:

1. **Extract:** Read the raw CSV dataset using Pandas.
2. **Transform:** Rename columns, remove duplicate records, handle missing values, and create additional analytical features.
3. **Load:** Transfer the cleaned DataFrame into a PostgreSQL database using SQLAlchemy.

The pipeline is orchestrated through `main.py`, which executes the extraction, transformation, and loading stages in sequence.

## 4. Data Transformation

The transformation process includes:

- Renaming `charges` to `claim_amount`.
- Removing exact duplicate records.
- Removing rows containing missing values.
- Creating age groups using conditional bins.
- Creating a Boolean `high_claim` feature using a $15,000 threshold.
- Categorizing BMI into Underweight, Normal, Overweight, and Obese.
- Exporting the cleaned dataset to `data/processed/claims_cleaned.csv`.

## 5. Data Quality Results

The original dataset contained 1,338 records.

| Data Quality Metric | Result |
|---|---:|
| Original records | 1,338 |
| Original duplicate records | 1 |
| Original missing values | 0 |
| Duplicate records removed | 1 |
| Rows removed for missing values | 0 |
| Final records | 1,337 |
| Remaining duplicate records | 0 |
| Remaining missing values | 0 |

The original claim amount total was approximately $17,755,824.99. After removing the duplicate record, the cleaned total was approximately $17,754,185.43.

The difference of approximately $1,639.56 corresponds to the duplicate record removed during transformation.

## 6. Database Implementation

PostgreSQL is used to store the cleaned dataset in the `insurance_db` database.

The Python loading module uses SQLAlchemy and the psycopg2 driver to establish the database connection. The password is requested at runtime through Python's `getpass` module rather than being hardcoded in the source code.

The cleaned records are loaded into the `claims` table. A separate `regions` lookup table supports regional analysis through SQL joins.

## 7. SQL Analytics

Five SQL scripts were developed to investigate data quality and analytical patterns.

### 7.1 Data Quality Analysis

Validated:
- Total record count.
- Missing values across relevant columns.
- Duplicate records.
- Total, average, minimum, and maximum claim amounts.

### 7.2 Claim Summary Analysis

Examined overall claim statistics and compared average claim amounts by smoking status and BMI category.

**Smoking status results:**

| Category | Records | Average Claim |
|---|---:|---:|
| Smoker | 274 | $32,050.23 |
| Non-smoker | 1,063 | $8,440.66 |

The average claim amount for smokers was approximately 3.8 times the average for non-smokers in this dataset.

### 7.3 Regional Analysis

Used `GROUP BY`, `INNER JOIN`, common table expressions, and a scalar subquery to compare regional averages.

| Region | Records | Average Claim |
|---|---:|---:|
| Southeast | 364 | $14,735.41 |
| Northeast | 324 | $13,406.38 |
| Northwest | 324 | $12,450.84 |
| Southwest | 325 | $12,346.94 |

The Southeast had the highest average claim amount among the four regions.

### 7.4 Claim Category Analysis

Used SQL `CASE` expressions to classify records:

- Low: Below $5,000.
- Medium: $5,000 to below $15,000.
- High: $15,000 or greater.

| Category | Records | Average Claim |
|---|---:|---:|
| High | 358 | $30,128.10 |
| Medium | 621 | $9,497.18 |
| Low | 358 | $2,990.44 |

High-category records represented approximately 26.8% of all records and 60.8% of the total claim amount.

These thresholds are project-defined analytical categories, not official industry classifications.

### 7.5 Advanced SQL Analysis

Applied more advanced SQL techniques to identify regional patterns and individual high-value records.

Techniques included:
- `RANK()` window function to rank regions by average claim amount.
- `AVG() OVER (PARTITION BY region)` to calculate regional averages alongside individual records.
- Scalar subqueries to identify the 15 highest claim amounts above the overall average.
- Common table expressions and conditional aggregation using `FILTER` to calculate above-average claim percentages.

**Above-average claim results:**

| Region | Above-Average Records | Percentage |
|---|---:|---:|
| Southeast | 130 | 35.71% |
| Northeast | 109 | 33.64% |
| Northwest | 96 | 29.63% |
| Southwest | 85 | 26.15% |

Across the entire dataset, 420 of 1,337 records had claim amounts above the overall average, approximately 31.41%.

## 8. SQL Skills Demonstrated

The project demonstrates practical use of:

- Aggregate functions: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()`.
- Grouping and filtering: `GROUP BY`, `WHERE`, and `HAVING`.
- Conditional logic: `CASE`.
- Joins: `INNER JOIN` and `CROSS JOIN`.
- Common Table Expressions (CTEs).
- Scalar subqueries.
- Window functions: `RANK()` and `AVG() OVER (PARTITION BY ...)`.
- Conditional aggregation using `FILTER`.

## 9. Current Limitations

- The project uses a static dataset rather than live insurance transaction data.
- Duplicate removal is based on exact row matching because the dataset does not contain a unique customer or transaction identifier.
- Missing-value handling is implemented, but the original dataset contained no missing values.
- The current loading process replaces the `claims` table on each full ETL run.
- The analytical categories use project-defined thresholds.
- The current findings are descriptive and do not establish causal relationships.
- An interactive dashboard and predictive analytics component have not yet been implemented.

## 10. Future Enhancements

Potential improvements include:

- Building an interactive dashboard to visualize claim trends and regional comparisons.
- Implementing automated ETL scheduling and execution logging.
- Adding incremental database loading.
- Expanding data validation and error handling.
- Developing predictive models for claim analysis.
- Adding more datasets and analytical dimensions.

## 11. Conclusion

The Insurance Analytics Platform demonstrates an end-to-end data workflow using Python, Pandas, PostgreSQL, SQLAlchemy, and SQL.

The project successfully extracts and transforms 1,338 original records, removes one duplicate, validates the cleaned dataset, and loads 1,337 records into PostgreSQL. Five SQL analysis scripts demonstrate data quality validation, aggregations, joins, subqueries, CTEs, and window functions.

The completed work provides a foundation for further development in data engineering, business intelligence, and insurance analytics.