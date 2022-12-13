from uuid import UUID # Mauvais import de la lib uuid
from pydantic import BaseModel

class ArticleBase(BaseModel): # On ne met pas d'id ici sinon il sera obligatoire lors de la création d'un article
    price: float
    name: str
    description: str | None = None
    category: str | None = None
    stock: int | None = None # Rename leftAvailable to stock

class ArticleCreate(ArticleBase):
    pass

class Article(ArticleBase):
    id: int # On ajoute l'id ici car il sera obligatoire lors de la récupération d'un article
    class Config:
        orm_mode = True