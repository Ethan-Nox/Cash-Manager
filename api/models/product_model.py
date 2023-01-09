from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.orm import relationship
from core.database import Base

class Product(Base):
    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True)
    quantity = Column(Integer)
    article_id = Column(Integer, ForeignKey('articles.id'))
    article = relationship("Article")
