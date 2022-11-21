# from fastapi import Depends, HTTPException
# from sqlalchemy.orm import Session
# from schemas.user_schema import User as UserSchema, UserCreate
# import views.user_view as UserView
# from main import app, get_db
# class UserController(app, get_db):
#     def __init__(self):
#         pass

#     @app.post("/users/", response_model=UserSchema)
#     def create_user(user: UserCreate, db: Session = Depends(get_db)):
#         db_user = UserView.get_user_by_email(db, email=user.email)
#         if db_user:
#             raise HTTPException(status_code=400, detail="Email already registered")
#         return UserView.create_user(db=db, user=user)


#     @app.get("/users/", response_model=list[UserSchema])
#     def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
#         users = UserView.get_users(db, skip=skip, limit=limit)
#         return users


#     @app.get("/users/{user_id}", response_model=UserSchema)
#     def read_user(user_id: int, db: Session = Depends(get_db)):
#         db_user = UserView.get_user(db, user_id=user_id)
#         if db_user is None:
#             raise HTTPException(status_code=404, detail="User not found")
#         return db_user