from fastapi import APIRouter, Depends, HTTPException
from core.database import get_db
from schemas import user_schema
from controllers import user_controller
from sqlalchemy.orm import Session

router = APIRouter()

@router.post("/users/", response_model=user_schema.UserForAdmin, tags=["users"])
def create_user(user: user_schema.UserCreate, db: Session = Depends(get_db)):
    db_user = user_controller.get_user_by_email(db, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    return user_controller.create_user(db=db, user=user)

@router.get("/users/", response_model=list[user_schema.UserForAdmin], tags=["users"])
def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    users = user_controller.get_users(db, skip=skip, limit=limit)
    return users

@router.get("/users/{user_id}", response_model=user_schema.UserForAdmin, tags=["users"])
def read_user(user_id: str, db: Session = Depends(get_db)):
    db_user = user_controller.get_user(db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user

@router.delete("/users/", response_model=user_schema.UserForAdmin, tags=["users"])
def delete_user(user_id: str, db: Session = Depends(get_db)):
    db_user = user_controller.get_user(db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user_controller.delete_user(db, user_id=user_id)

@router.patch("/users/", response_model=user_schema.UserForAdmin, tags=["users"])
def update_user(user: user_schema.UserForAdmin, db: Session = Depends(get_db)):
    db_user = user_controller.get_user(db, user_id=user.id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user_controller.update_user(db, user=user)
