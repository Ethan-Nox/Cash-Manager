from fastapi import APIRouter, Depends, HTTPException
from core.database import get_db
from controllers import user_controller
from sqlalchemy.orm import Session
from core import jwt

router = APIRouter()

@router.post("/new_bill", response_model=user_controller.BillResponse, tags=["users"])
def new_bill(db: Session = Depends(get_db), uuid: str = Depends(jwt.get_current_user_id)):
    return user_controller.new_bill(db=db, user_id=uuid)