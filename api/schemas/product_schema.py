from pydantic import BaseModel
from schemas.article_schema import Article

class ProductBase(BaseModel):
    article: Article
    quantity: int

class ProductCreate(ProductBase):
    pass

class Product(ProductBase):

    class Config:
        orm_mode = True