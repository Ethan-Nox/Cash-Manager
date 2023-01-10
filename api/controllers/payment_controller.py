##
## EPITECH PROJECT, 2023
## T-DEV-CASHMANAGER
## File description:
## payment
##
import os
from dotenv import load_dotenv
from fastapi import HTTPException
from pydantic import BaseModel
import stripe

class CreditCard(BaseModel):
    number: str
    exp_month: int
    exp_year: int
    cvc: str
    amount: int

def charge(payment):
    load_dotenv()
    stripe.api_key = os.getenv("STRIPE")
    try:
        token = stripe.Token.create(
            card={
                "number": payment.number,
                "exp_month": payment.exp_month,
                "exp_year": payment.exp_year,
                "cvc": payment.cvc,
            },
        )
        charge = stripe.Charge.create(
            amount=payment.amount, #example amount
            currency="eur",
            description="Example charge",
            source=token.id,
        )
        return {"message":"Successful charge"}
    except stripe.error.CardError as e:
        raise HTTPException(status_code=400, detail=e.user_message)