from sqlalchemy import Column, ForeignKey, Integer, ARRAY, Float, Table, DateTime
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from core.database import Base
from uuid import uuid4

product_bill_association = Table('product_bill_association', Base.metadata,
    Column('products_id', Integer, ForeignKey('products.id')),
    Column('bills_id', Integer, ForeignKey('bills.id'))
)

class Bill(Base):
    __tablename__ = "bills"

    id = Column(Integer, primary_key=True, index=True)
    total_price = Column(Float)
    date = Column(DateTime(timezone=True))
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), default=uuid4)
    user = relationship("User", back_populates="bills")

    products_id = Column(ARRAY(Integer, ForeignKey('products.id')))
    products = relationship("Product", secondary="product_bill_association")
