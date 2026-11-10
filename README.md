# Insurance Analytics Platform

An end-to-end data analytics project that uses Python, Pandas, and PostgreSQL to clean insurance data, automate ETL processing, validate data quality, and uncover business insights through SQL analytics.

## Project Overview

The Insurance Analytics Platform processes insurance-related data through a Python ETL pipeline and stores the cleaned records in a PostgreSQL database for analysis.

The project demonstrates practical data engineering and analytics skills, including data transformation, relational database management, SQL querying, and data quality validation.

## Technologies Used

| Technology | Purpose |
|---|---|
| Python | ETL pipeline development |
| Pandas | Data extraction and transformation |
| PostgreSQL | Relational database |
| SQLAlchemy | Database connectivity |
| SQL | Data validation and analytics |
| Git | Version control |

## Project Architecture

```text
CSV Dataset
    |
    v
Python ETL Pipeline
    |
    +--> Extract: Read raw CSV data
    |
    +--> Transform: Clean records and engineer features
    |
    +--> Load: Store cleaned data in PostgreSQL
    |
    v
PostgreSQL Database
    |
    v
SQL Analytics
    |
    +--> Data Quality Validation
    +--> Claim Summary Analysis
    +--> Regional Analysis
    +--> Claim Category Analysis
    +--> Advanced SQL Analysis
```

## ETL Pipeline

The ETL pipeline is divided into three stages:

### 1. Extract
- Reads the original CSV dataset using Pandas.
- Extracts 1,338 records.

### 2. Transform
- Renames `charges` to `claim_amount`.
- Removes duplicate records.
- Checks for missing values.
- Creates age groups.
- Categorizes BMI.
- Creates a high-claim indicator.
- Exports the cleaned dataset.

### 3. Load
- Connects Python to PostgreSQL using SQLAlchemy.
- Loads 1,337 cleaned records into the `claims` table.

## Data Quality Results

| Metric | Result |
|---|---:|
| Original records | 1,338 |
| Duplicate records removed | 1 |
| Missing values | 0 |
| Final records | 1,337 |
| Remaining duplicates | 0 |

## Key Analytical Findings

### Smoking Status

| Category | Records | Average Claim |
|---|---:|---:|
| Smoker | 274 | $32,050.23 |
| Non-smoker | 1,063 | $8,440.66 |

The average claim amount for smokers was approximately 3.8 times higher than for non-smokers in this dataset.

### Regional Analysis

| Region | Average Claim |
|---|---:|
| Southeast | $14,735.41 |
| Northeast | $13,406.38 |
| Northwest | $12,450.84 |
| Southwest | $12,346.94 |

The Southeast had the highest average claim amount.

### Claim Categories

| Category | Records | Average Claim |
|---|---:|---:|
| High Claim | 358 | $30,128.10 |
| Medium Claim | 621 | $9,497.18 |
| Low Claim | 358 | $2,990.44 |

High Claim records represented approximately 60.8% of the total claim amount.

## SQL Techniques

The project includes practical examples of:

- Aggregations: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`
- Grouping: `GROUP BY`
- Conditional logic: `CASE`
- Joins: `INNER JOIN`, `CROSS JOIN`
- Common Table Expressions (CTEs)
- Scalar subqueries
- Window functions: `RANK()` and `AVG() OVER(PARTITION BY ...)`
- Conditional aggregation using `FILTER`

## Project Structure

```text
insurance-analytics-platform/
|
|-- analysis/
|   |-- 01_data_quality.sql
|   |-- 02_claim_summary.sql
|   |-- 03_regional_analysis.sql
|   |-- 04_claim_categories.sql
|   |-- 05_advanced_sql_analysis.sql
|
|-- data/
|   |-- raw/
|   |-- processed/
|
|-- database/
|   |-- schema.sql
|   |-- seed_regions.sql
|
|-- docs/
|   |-- project_report.md
|
|-- etl/
|   |-- extract.py
|   |-- transform.py
|   |-- load.py
|
|-- main.py
|-- requirements.txt
|-- README.md
```

## How to Run the Project

### 1. Clone the repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd insurance-analytics-platform
```

### 2. Create a virtual environment

```bash
python -m venv venv
```

Activate it on Windows:

```cmd
venv\Scripts\activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure PostgreSQL

Create a PostgreSQL database named:

```sql
CREATE DATABASE insurance_db;
```

Configure your local database connection credentials in the ETL loading script. Do not commit passwords or other secrets.

### 5. Run the ETL pipeline

```bash
python main.py
```

### 6. Execute SQL analysis

For example, using PostgreSQL 18 on Windows:

```cmd
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d insurance_db -f analysis\01_data_quality.sql
```

Repeat for the other SQL files in the `analysis` directory.

## Future Enhancements

- Develop an interactive analytics dashboard.
- Add automated ETL scheduling and logging.
- Implement incremental database loading.
- Expand data validation.
- Introduce predictive claim analytics.

## Project Notes

This project uses a static insurance-related dataset. The claim categories and thresholds are defined for analytical purposes. Findings describe relationships within the dataset and should not be interpreted as causal conclusions or official insurance pricing recommendations.