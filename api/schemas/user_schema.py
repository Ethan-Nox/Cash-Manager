from pydantic import BaseModel, EmailStr
from datetime import date as Date
from uuid import UUID
from fastapi import Body

class UserBase(BaseModel):
    firstname: str | None = Body(default=None)
    lastname: str | None = Body(default=None)
    email: EmailStr
    birthdate: Date | None = Body(default=None)
    genre: int | None = Body(default=None) #(1 = male, 2 = female, 3 = other)
    #billList: list of bill (foreign keys)
    #articles: list of articles (foreign keys)
    #bankInfos: bank (foreign key)
    role: int | None = Body(default=None) #(0 = member, 1 = admin)

class UserCreate(UserBase):
    password: str

class User(UserBase):

    class Config:
        orm_mode = True