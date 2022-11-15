from pydantic import BaseModel, EmailStr
from datetime import date as Date
from uuid import UUID
from fastapi import Body

class User(BaseModel):
    firstname: str | None = Body(default=None)
    lastname: str | None = Body(default=None)
    uuid: UUID
    email: EmailStr
    birthdate: Date | None = Body(default=None)
    genre: int | None = Body(default=None) #(1 = male, 2 = female, 3 = other)
    password: str #(crypted)
    #billList: list of bill (foreign keys)
    #articles: list of articles (foreign keys)
    #bankInfos: bank (foreign key)
    role: int #(0 = member, 1 = admin)
