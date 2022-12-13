from pydantic import BaseModel, EmailStr
from datetime import date as Date
from fastapi import Body
from uuid import UUID
from schemas.article_schema import Article

class UserBase(BaseModel):
    firstname: str
    lastname: str
    email: EmailStr
    birthdate: Date
    genre: int = Body(default=0) #(1 = male, 2 = female, 3 = other)
    role: int = Body(default=0) #(0 = member, 1 = admin)
    articles: list[Article] | None = []

class UserCreate(UserBase):
    password: str

class User(UserBase):
    class Config:
        orm_mode = True

class UserForAdmin(User):
    id: UUID