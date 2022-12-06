from fastapi import APIRouter, Depends, HTTPException
from core.database import get_db
from schemas import article_schema
from controllers import article_controller
from sqlalchemy.orm import Session

router = APIRouter()

# Create a new article
@router.post("/article/", response_model=article_schema.Article, tags=["articles"])
def create_article(article: article_schema.ArticleCreate, db: Session = Depends(get_db)):
    db_article = article_controller.get_article_by_name(db, name=article.name) # get by name et non get by title
    if db_article:
        raise HTTPException(status_code=400, detail="Article already registered with this name")
    return article_controller.create_article(db=db, article=article)

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

# Partch an article
@router.patch("/articles/", response_model=article_schema.Article, tags=["articles"])
def update_article(article: article_schema.Article, db: Session = Depends(get_db)): # Article et pas ArticleUpdate
    db_article = article_controller.get_article(db, id=article.id)
    if db_article is None:
        raise HTTPException(status_code=404, detail="Article not found")
    return article_controller.update_article(db, article=article)

# Delete an article
@router.delete("/articles/", response_model=article_schema.Article, tags=["articles"])
def delete_article(article_id: str, db: Session = Depends(get_db)):
    db_article = article_controller.get_article(db, id=article_id)
    if db_article is None:
        raise HTTPException(status_code=404, detail="Article not found")
    return article_controller.delete_article(db, id=article_id)


@router.get("/test")
def test():
    return {"message": "test"}

