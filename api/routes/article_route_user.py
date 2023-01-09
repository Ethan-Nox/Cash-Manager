from fastapi import APIRouter, Depends, HTTPException
from core.database import get_db
from schemas import article_schema
from controllers import article_controller, user_controller
from sqlalchemy.orm import Session
from core import jwt

router = APIRouter()

#  GET ALL ARTICLES
@router.get("/articles/", response_model=list[article_schema.Article], tags=["articles"])
def read_articles(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    articles = article_controller.get_articles(db, skip=skip, limit=limit)
    return articles

@router.get("/article/{article_id}", response_model=article_schema.Article, tags=["articles"])
def read_article(article_id: str, db: Session = Depends(get_db)):
    db_article = article_controller.get_article(db, article_id=article_id)
    if db_article is None:
        raise HTTPException(status_code=404, detail="Article not found")
    return db_article

# ADD ARTICLE TO USER
@router.patch("/add_article", response_model=bool, tags=["users"])
def add_article_to_user(article_id: str, quantity: int,db: Session = Depends(get_db), uuid: str = Depends(jwt.get_current_user_id)):
    db_article = article_controller.get_article(db, article_id=article_id)
    if db_article is None:
        raise HTTPException(status_code=404, detail="Article not found")
    return user_controller.add_article_to_user(db, article_id=article_id, user_id=uuid, quantity=quantity)
