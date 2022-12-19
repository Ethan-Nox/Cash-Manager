from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel
from sqlalchemy.orm import Session

from core.database import get_db
from core.jwt import LoginResponse, create_access_token
from controllers.user_controller import login, get_user_by_email, create_user
from schemas.user_schema import UserCreate

router = APIRouter()

class Logs(BaseModel):
    email: str
    password: str

@router.post("/login", response_model=LoginResponse, tags=["auth"])
async def login_for_access_token(logs: Logs, db: Session = Depends(get_db)):
    user = login(db, email = logs.email, password = logs.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=180)
    access_token = create_access_token(
        data={"sub": str(user.id)}, expires_delta=access_token_expires
    )
    return {"token": {"access_token": access_token, "token_type": "bearer"}, "user": user}

@router.post("/register", response_model=LoginResponse, tags=["auth"])
async def register_for_access_token(user: UserCreate, db: Session = Depends(get_db)):
    db_user = get_user_by_email(db, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    user = create_user(db=db, user=user)
    access_token_expires = timedelta(minutes=30)
    access_token = create_access_token(
        data={"sub": str(user.id)}, expires_delta=access_token_expires
    )
    return {"token": {"access_token": access_token, "token_type": "bearer"}, "user": user}