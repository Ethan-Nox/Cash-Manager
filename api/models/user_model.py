from sqlalchemy import Column, ForeignKey, Integer, String, DateTime, ARRAY, Table
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from uuid import uuid4
from core.database import Base

article_user_association = Table('article_user_association', Base.metadata,
    Column('articles_id', Integer, ForeignKey('articles.id')),
    Column('users_id', UUID, ForeignKey('users.id'))
)

class User(Base):
    __tablename__ = "users"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    firstname = Column(String)
    lastname = Column(String)
    email = Column(String, unique=True, index=True)
    birthdate = Column(DateTime(timezone=True))
    genre = Column(Integer, nullable=False, default=0)
    hashed_password = Column(String)
    articles_id = Column(ARRAY(Integer, ForeignKey('articles.id')))
    articles = relationship("Article", secondary="article_user_association")
    role = Column(Integer, nullable=False, default=0)