from fastapi import APIRouter, Depends, HTTPException
from schemas.product_schema import Product
from schemas.user_schema import User
from core.database import get_db
from schemas import article_schema
from controllers import article_controller, user_controller
from sqlalchemy.orm import Session
from core import jwt

router = APIRouter()

# Get all articles
@router.get("/articles/", response_model=list[article_schema.Article], tags=["articles"])
def read_articles(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    articles = article_controller.get_articles(db, skip=skip, limit=limit)
    return articles

# Get article by id
@router.get("/article/{article_id}", response_model=article_schema.Article, tags=["articles"])
def read_article(article_id: str, db: Session = Depends(get_db)):
    db_article = article_controller.get_article(db, article_id=article_id) # Get article so we verifiy it exists
    if db_article is None: # If not exist
        raise HTTPException(status_code=404, detail="Article not found")
    return db_article

# Add article and quatity to product list of connected user
@router.patch("/add_article", response_model=list[Product], tags=["users"])
def add_article_to_user(article_id: str, quantity: int, db: Session = Depends(get_db), uuid: str = Depends(jwt.get_current_user_id)):
    db_article = article_controller.get_article(db, article_id=article_id) # Get article so we verifiy it exists
    if db_article is None: # If not exist
        raise HTTPException(status_code=404, detail="Article not found")
    if user_controller.add_article_to_user(db, article_id=article_id, user_id=uuid, quantity=quantity) == True: # Add article to product list
        db_user: User = user_controller.get_user(db=db, user_id=uuid) # If it works we get the new user
        return db_user.products # and return product list for front update
    else:
        raise HTTPException(status_code=404, detail="Can't add article") # Otherwise throw error

# Scan an article and add it to product list of connected user
@router.patch("/scan_article", response_model=list[Product], tags=["users"])
def add_article_to_user(code: str, db: Session = Depends(get_db), uuid: str = Depends(jwt.get_current_user_id)):
    db_article = article_controller.get_article_by_code(db, code=code) # Get article so we verifiy it exists
    if db_article is None: # If not exist
        raise HTTPException(status_code=404, detail="Article not found")
    if user_controller.add_article_to_user_with_scan(db, code=code, user_id=uuid) == True: # Add article to product list
        db_user: User = user_controller.get_user(db=db, user_id=uuid) # If it works we get the new user
        return db_user.products # and return product list for front update
    else:
        raise HTTPException(status_code=404, detail="Can't add article") # Otherwise throw error

# Remove article to product list of connected user
@router.patch("/remove_article", response_class=list[Product], tags=["users"])
def remove_article_to_user(article_id: str, db: Session = Depends(get_db), uuid: str = Depends(jwt.get_current_user_id)):
    db_article = article_controller.get_article(db, article_id=article_id) # Get article so we verifiy it exists
    if db_article is None: # If not exist
        raise HTTPException(status_code=404, detail="Article not found")
    if user_controller.remove_article_to_user(db, article_id=article_id, user_id=uuid) == True: # Remove article to product list
        db_user: User = user_controller.get_user(db=db, user_id=uuid) # If it works we get the new user
        return db_user.products # and return product list for front update
    else:
        raise HTTPException(status_code=404, detail="Can't add article") # Otherwise throw error