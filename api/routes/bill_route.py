from fastapi import APIRouter, Depends, HTTPException
from core.database import get_db
from controllers import user_controller, payment_controller
from sqlalchemy.orm import Session
from core import jwt

router = APIRouter()

# Create a bill from user products list
@router.post("/new_bill", response_model=user_controller.BillResponse, tags=["users"])
def new_bill(db: Session = Depends(get_db), uuid: str = Depends(jwt.get_current_user_id)):
    return user_controller.new_bill(db=db, user_id=uuid)

@router.post("/pay", tags=["users"])
def pay(payment: payment_controller.CreditCard):
    return payment_controller.charge(payment)