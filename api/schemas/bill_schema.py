from pydantic import BaseModel
from schemas.product_schema import Product
from datetime import date as Date

class BillBase(BaseModel):
    id: int
    total_price: float
    date: Date
    products: list[Product] | None = []

class BillCreate(BillBase):
    pass

class Bill(BillBase):
    class Config:
        orm_mode = True