from pydantic import BaseModel
from schemas.product_schema import Product
from datetime import date as Date

########################
#         BILL         #
#                      #
# When user paid for   #
# his articles         #
#                      #
# Also provide a       #
# historic of shopping #
#                      #
########################

class BillBase(BaseModel): # Bill clas for base
    id: int
    total_price: float
    date: Date
    products: list[Product] | None = []

class BillCreate(BillBase): # Bill class for base creation
    pass

class Bill(BillBase): # Bill class for generic usages
    class Config:
        orm_mode = True