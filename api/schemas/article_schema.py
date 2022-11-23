from sqlalchemy.dialects.postgresql import UUID
from pydantic import BaseModel, EmailStr
from datetime import date as Date
from fastapi import Body


class ArticleBase(BaseModel):
    id: UUID
    price: float
    name: str
    description: str | None = None
    category: str | None = None
    leftavailable: int | None = None


class ArticleCreate(ArticleBase):
    pass


class Article(ArticleBase):
    # id: int

    class Config:
        orm_mode = True