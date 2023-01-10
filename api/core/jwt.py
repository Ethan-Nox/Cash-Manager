from fastapi import Depends, HTTPException, status, Header
from fastapi.security import OAuth2PasswordBearer

from jose import JWTError, jwt
from pydantic import BaseModel
from uuid import UUID
from datetime import datetime, timedelta
from datetime import timedelta
from sqlalchemy.orm import Session

from controllers.user_controller import get_user
from schemas.user_schema import User
from core.database import get_db

OAuth2_Scheme = OAuth2PasswordBearer(tokenUrl="token")

# Files var used in following functions
SECRET_KEY='35c432abea7ef2e6f6dda8ec69d2d32fa952601bdc9c6f7792430e680b720ced'
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
)

# Classes for request returns
class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    user_id: UUID | None = None

class LoginResponse(BaseModel):
    token: Token
    user: User

# Create an acces token after log or register
def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy() # Replication of the user so it creates a new reference
    if expires_delta:
        expire = datetime.utcnow() + expires_delta # Set expire time of the token if it's asked
    else:
        expire = datetime.utcnow() + timedelta(hours=15) # Otherwise set a default expire time
    to_encode.update({"exp": expire}) # Add expire time for encode purpose
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM) # Create the token with the expire time and the user
    return encoded_jwt

# Return the user from the access token provided
async def get_current_user(token: str = Header(), db: Session = Depends(get_db)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms = [ALGORITHM]) # Decode the token to get informations
        uuid: UUID = payload.get("sub") # Retrieve the user from decoded informations
        if uuid is None:
            raise credentials_exception # If there is no user in the token
        token_data = TokenData(user_id=uuid)
    except JWTError:
        raise credentials_exception # If there is no Token
    user = get_user(db, user_id = token_data.user_id) # Get the good user
    if user is None:
        raise credentials_exception # If user has been deleted since the token has been created
    return user

# Verify is the user connected is admin
async def is_admin(current_user: User = Depends(get_current_user)):
    if current_user.role == 1: # Verify if the user is admin
        return True
    raise HTTPException(status_code=403, detail="Not admin") # Otherwise forbidden

# Return the user id from the access token provided
def get_current_user_id(token: str = Header(), db: Session = Depends(get_db)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms = [ALGORITHM]) # Decode the token to get informations
        uuid: UUID = payload.get("sub") # Retrieve the user id from decoded informations
        if uuid is None:
            raise credentials_exception # If there is no user in the token
    except JWTError:
        raise credentials_exception # If there is no token
    return uuid