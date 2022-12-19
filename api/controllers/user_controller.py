from sqlalchemy.orm import Session
from models.user_model import User as UserModel
from models.article_model import Article as ArticleModel
from schemas.user_schema import User as UserSchema
from controllers.article_controller import get_article
from core.hashing import Hasher
from uuid import UUID
import copy

def get_user(db: Session, user_id: UUID):
    return db.query(UserModel).filter(UserModel.id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(UserModel).filter(UserModel.email == email).first()

def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(UserModel).offset(skip).limit(limit).all()

def delete_user(db: Session, user_id: UUID):
    db_user = db.query(UserModel).filter(UserModel.id == user_id).first()
    db.delete(db_user)
    db.commit()
    return db_user

def create_user(db: Session, user: UserSchema):
    db_user = UserModel(
        email=user.email,
        hashed_password=Hasher.get_password_hash(user.password),
        firstname=user.firstname,
        lastname=user.lastname,
        birthdate=user.birthdate,
        genre=user.genre,
        role=1,
        articles=[]
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def update_user(db: Session, user: UserSchema):
    db_user = db.query(UserModel).filter(UserModel.id == user.id).first()
    db_user.email = user.email
    db_user.firstname = user.firstname
    db_user.lastname = user.lastname
    db_user.birthdate = user.birthdate
    db_user.genre = user.genre
    db.commit()
    db.refresh(db_user)
    return db_user

def login(db: Session, email: str, password: str):
    user = get_user_by_email(db, email)
    if not user:
        return False
    if not Hasher.verify_password(password, user.hashed_password):
        return False
    return user

def add_article_to_user(db: Session, article_id: UUID, user_id: UUID):
    db_user: UserModel = get_user(db, user_id)
    db_article: ArticleModel = get_article(db, article_id)
    db_user.articles.append(db_article)
    db.commit()
    db.refresh(db_user)
    return True