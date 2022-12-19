from pydantic import BaseModel
from fastapi import Form

class ArticleBase(BaseModel):
    price: float
    name: str
    description: str | None = None
    category: str | None = None
    stock: int | None = None


class ArticleCreate(ArticleBase):

    @classmethod
    def as_form(cls, price: float = Form(...), name: str = Form(...), description: str = Form(...),
    category: str = Form(...), stock: int = Form(...)):
        return cls(price=price, name=name, description=description, category=category, stock=stock)

    pass

class Article(ArticleBase):
    id: int
    image: str
    class Config:
        orm_mode = True