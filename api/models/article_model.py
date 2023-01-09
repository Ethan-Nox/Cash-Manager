from sqlalchemy import Column, Integer, String, Float
from core.database import Base

class Article(Base):
    __tablename__ = "articles"

    id = Column(Integer, primary_key=True, index=True)
    price = Column(Float)
    name = Column(String, index=True, unique=True)
    description = Column(String, nullable=True)
    category = Column(String)
    stock = Column(Integer, nullable=True)
    image = Column(String, nullable=True)