from pydantic import BaseModel
from fastapi import Form

#########################
#       ARTICLE         #
#                       #
# Articles for shopping #
#                       #
#########################

class ArticleBase(BaseModel): # Article class for base
    price: float
    name: str
    description: str | None = None
    category: str | None = None
    stock: int | None = None
    code: str | None = None


class ArticleCreate(ArticleBase): # Article class for base creation

    @classmethod # Convert application/json item to form item
    def as_form(cls, price: float = Form(...), name: str = Form(...), description: str = Form(...),
    category: str = Form(...), stock: int = Form(...)):
        return cls(price=price, name=name, description=description, category=category, stock=stock)

    pass

class Article(ArticleBase): # Article class for generic usages
    id: int
    image: str
    class Config:
        orm_mode = True