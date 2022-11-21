from fastapi import Depends, FastAPI, HTTPException, Request, Response
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from core.database import SessionLocal, Base, engine
from schemas import user_schema
from views import user_view

Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.middleware("http")
async def db_session_middleware(request: Request, call_next):
    response = Response("Internal server error", status_code=500)
    try:
        request.state.db = SessionLocal()
        response = await call_next(request)
    finally:
        request.state.db.close()
    return response

def get_db(request: Request):
    return request.state.db

@app.post("/users/", response_model=user_schema.User)
def create_user(user: user_schema.UserCreate, db: Session = Depends(get_db)):
    db_user = user_view.get_user_by_email(db, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    return user_view.create_user(db=db, user=user)


@app.get("/users/", response_model=list[user_schema.User])
def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    users = user_view.get_users(db, skip=skip, limit=limit)
    return users


@app.get("/users/{user_id}", response_model=user_schema.User)
def read_user(user_id: int, db: Session = Depends(get_db)):
    db_user = user_view.get_user(db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user

@app.delete("/users/", response_model=user_schema.User)
def delete_user(user_id: str, db: Session = Depends(get_db)):
    db_user = user_view.get_user(db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user_view.delete_user(db, user_id=user_id)


from fastapi import status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from datetime import timedelta
from views.user_view import login
from core.jwt import LoginResponse, create_access_token
import json
from uuid import UUID

class UUIDEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, UUID):
            # if the obj is uuid, we simply return the value of uuid
            return obj.hex
        return json.JSONEncoder.default(self, obj)

@app.post("/login", response_model=LoginResponse)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = login(db, email = form_data.username, password = form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=30)
    access_token = create_access_token(
        data={"sub": json.dumps(user.id, cls=UUIDEncoder)}, expires_delta=access_token_expires
    )
    return {"token": {"access_token": access_token, "token_type": "bearer"}, "user": user}

@app.post("/register", response_model=LoginResponse)
async def register_for_access_token(user: user_schema.UserCreate, db: Session = Depends(get_db)):
    db_user = user_view.get_user_by_email(db, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    user = user_view.create_user(db=db, user=user)
    access_token_expires = timedelta(minutes=30)
    access_token = create_access_token(
        data={"sub": json.dumps(user.id, cls=UUIDEncoder)}, expires_delta=access_token_expires
    )
    return {"token": {"access_token": access_token, "token_type": "bearer"}, "user": user}