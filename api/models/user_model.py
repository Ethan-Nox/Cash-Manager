from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from uuid import uuid4
from core.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    firstname = Column(String, nullable=True)
    lastname = Column(String, nullable=True)
    email = Column(String, unique=True, index=True)
    birthdate = Column(DateTime(timezone=True))
    genre = Column(Integer, nullable=True)
    hashed_password = Column(String)
    # articles = relationship("Article", back_populates="user")
    role = Column(Integer, nullable=True)