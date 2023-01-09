from sqlalchemy import Column, ForeignKey, Integer, String, DateTime, ARRAY, Table
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from uuid import uuid4
from core.database import Base
from models.bill_model import Bill

product_user_association = Table('product_user_association', Base.metadata,
    Column('products_id', Integer, ForeignKey('products.id')),
    Column('users_id', String, ForeignKey('users.id'))
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
    role = Column(Integer, nullable=False, default=0)

    products_id = Column(ARRAY(Integer, ForeignKey('products.id')))
    products = relationship("Product", secondary="product_user_association")
    bills = relationship("Bill", back_populates="user")