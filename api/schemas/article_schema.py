from uuid import UUID
from pydantic import BaseModel

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

    class Config:
        orm_mode = True