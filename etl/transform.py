import pandas as pd
import os

def transform_data(df):
    print("Starting transformation...")

    #Record original dataset statistics
    original_rows = len(df)
    original_missing = df.isnull().sum().sum()
    original_duplicates = df.duplicated().sum()
    original_claim_total = df["charges"].sum()

    print("---Original Data Quality---")
    print("Original records: ", original_rows)
    print("Missing values: ", original_missing)
    print("Duplicate records: ", original_duplicates)

    #Rename charges column
    df = df.rename(columns={"charges": "claim_amount"})

    #Remove any possible duplicates
    df = df.drop_duplicates()
    after_duplicates = len(df)

    #Handle missing values
    df = df.dropna()
    after_missing = len(df)

    #New features
    df["age_group"] = pd.cut(df["age"], bins=[0, 18, 35, 50, 65, 100], labels=["Teen", "Young Adult", "Adult", "Middle-Aged", "Senior"])
    
    df["high_claim"] = df["claim_amount"] > 15000

    df["bmi_category"] = pd.cut(df["bmi"], bins=[0, 18.5, 25, 30, 100], labels=["Underweight", "Normal", "Overweight", "Obese"])
    
    #Validate cleaned data
    print("\n---Cleaned Data Quality---")
    print("Cleaned records: ", len(df))
    print("Remaining missing values: ",  df.isnull().sum().sum())
    print("Remaining duplicates: ", df.duplicated().sum())
    
    print("\n--- Transformation Comparison ---")
    print("Records removed as duplicates: ", original_rows - after_duplicates)
    print("Records removed for missing values: ", after_duplicates - after_missing)
    print("Total records removed: ", original_rows - len(df))

   
    print("Original claim total:", original_claim_total)
    print("Cleaned claim total: ", df["claim_amount"].sum())
    print("Claim total difference: ", original_claim_total - df["claim_amount"].sum())


    os.makedirs("data/processed", exist_ok=True)
    df.to_csv("data/processed/claims_cleaned.csv", index=False)

    print("\nSaved clean data")
    print("Transformation Complete")
    print(df.head())
    return df

