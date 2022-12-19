from fastapi import Depends, HTTPException, status, Header
from fastapi.security import OAuth2PasswordBearer

from jose import JWTError, jwt
import json
from pydantic import BaseModel
from uuid import UUID
from datetime import datetime, timedelta
from datetime import timedelta
from sqlalchemy.orm import Session

from controllers.user_controller import get_user
from schemas.user_schema import User
from core.database import get_db

OAuth2_Scheme = OAuth2PasswordBearer(tokenUrl="token")

SECRET_KEY='35c432abea7ef2e6f6dda8ec69d2d32fa952601bdc9c6f7792430e680b720ced'
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    user_id: UUID | None = None

class LoginResponse(BaseModel):
    token: Token
    user: User

def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(hours=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

async def get_current_user(token: str = Header(), db: Session = Depends(get_db)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms = [ALGORITHM])
        uuid: UUID = payload.get("sub")
        if uuid is None:
            raise credentials_exception
        token_data = TokenData(user_id=uuid)
    except JWTError:
        raise credentials_exception
    user = get_user(db, user_id = token_data.user_id)
    if user is None:
        raise credentials_exception
    return user

async def is_admin(current_user: User = Depends(get_current_user)):
    if current_user.role == 1:
        return True
    raise HTTPException(status_code=403, detail="Not admin")

def get_current_user_id(token: str = Header(), db: Session = Depends(get_db)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms = [ALGORITHM])
        uuid: UUID = payload.get("sub")
        if uuid is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    return uuid