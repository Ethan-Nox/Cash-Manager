from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session
from core.database import SessionLocal, engine
from schemas import user_schema
from views import user_view

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()