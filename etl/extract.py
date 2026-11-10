
import pandas as pd
from pathlib import Path

def extract_data(file_path):
    df = pd.read_csv(file_path)
    print("Data extracted successfully")
    print(df.head())
    return df

if __name__ == "__main__":
    project_root = Path(__file__).resolve().parent.parent
    file_path = project_root / "data" / "raw" / "claims.csv"
    extract_data(file_path)
