from etl.extract import extract_data
from etl.transform import transform_data
from etl.load import load_data
from pathlib import Path

def run_pipeline():
    print("Insurance Analytics ETL Pipeline")

    try:
        #Step 1: Extract
        print("\n[1/3] Extracting data...")
        project_root = Path(__file__).resolve().parent
        raw_file = project_root / "data" / "raw" / "claims.csv"
        raw_df = extract_data(raw_file)

        #Step 2: Transform
        print("\n[2/3] Transforming data...")
        cleaned_df = transform_data(raw_df)

        #Step 3: Load
        print("\n[3/3] Loading data into PostgreSQL...")

        load_data(cleaned_df)

        print("\nETL pipeline completed successfully")

    except Exception as error:
        print("\nETL pipeline failed")
        print("Error: ", error)
        raise

if __name__ == "__main__":
    run_pipeline()
    
