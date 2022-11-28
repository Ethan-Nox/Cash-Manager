from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, DateTime, Float
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from uuid import uuid4
from core.database import Base

class Article(Base):
    __tablename__ = "articles"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    price = Column(Float)
    name = Column(String, index=True, unique=True)
    description = Column(String, nullable=True)
    category = Column(String)
    leftAvailable = Column(Integer, nullable=True)