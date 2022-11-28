from pydantic import BaseModel, EmailStr
from datetime import date as Date
from fastapi import Body
from uuid import UUID

class UserBase(BaseModel):
    firstname: str
    lastname: str
    email: EmailStr
    birthdate: Date
    genre: int #(1 = male, 2 = female, 3 = other)
    #billList: list of bill (foreign keys)
    #articles: list of articles (foreign keys)
    #bankInfos: bank (foreign key)
    role: int = Body(default=0) #(0 = member, 1 = admin)

class UserCreate(UserBase):
    password: str

class User(UserBase):

    class Config:
        orm_mode = True

class UserForAdmin(UserCreate):
    id: UUID