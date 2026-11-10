import pandas as pd
from sqlalchemy import create_engine, URL
from getpass import getpass

def load_data(df):
    #Check that the datafrane contains data
    if df.empty:
        raise ValueError("Cannot load an empty dataset.")

    #Request database password securely
    password = getpass("Enter PostgreSQL password: ")

    #Create PostgreSQL connection
    connection_url = URL.create(
drivername = "postgresql+psycopg2",
username = "postgres",
password = password,
host = "localhost",
port = 5432,
database = "insurance_db") #builds the database connection details

    engine = create_engine(connection_url) #establishes the PostgreSQL connection

    try:
        print("Connecting to PostgresSQL...")

        #Load transformed data into the claims table
        df.to_sql( #Transfers your Dataframe into PostgreSQL
name = "claims", #names the database table
con = engine,
if_exists = "replace", #replaces the existing table when rerunning
index = False) #Prevents Pandas from adding an unnecessary index column

        print("Data successfully loaded into PostgreSQL")
        print(f"Records loaded: {len(df)}")
        print("Database: insurance_db")
        print("Table: claims")
    except Exception as error:
        print("Error loading data:", error)
        raise

    finally:
        engine.dispose()