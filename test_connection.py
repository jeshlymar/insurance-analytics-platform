from sqlalchemy import create_engine, URL
from getpass import getpass

password = getpass("Enter PostgreSQL password: ")

url = URL.create(
"postgresql+psycopg2",
username = "postgres",
password = password,
host = "localhost",
port = 5432,
database = "insurance_db")

engine = create_engine(url)

try:
    with engine.connect() as connection:
        print("Successfully connected to insurance_db")

finally:
    engine.dispose()