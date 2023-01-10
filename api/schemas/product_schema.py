from pydantic import BaseModel
from schemas.article_schema import Article

######################
#       PRODUCT      #
#                    #
# Product is article #
# with quantity      #
#                    #
######################
class ProductBase(BaseModel): # Product class for base
    article: Article
    quantity: int

class ProductCreate(ProductBase): # Product class for base creation
    pass

class Product(ProductBase): # Product class for generic usages

    class Config:
        orm_mode = True