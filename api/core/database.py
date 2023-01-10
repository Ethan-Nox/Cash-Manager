from fastapi import Request
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Create a sql engine instance
SQLALCHEMY_DATABASE_URL = "postgresql://postgres:postgres@db:5432/cash_db"

# Init engine
engine = create_engine(
    SQLALCHEMY_DATABASE_URL
)

# Create Session
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Declare base
Base = declarative_base()

# Return the db where everything is stocked in
def get_db(request: Request):
    return request.state.db