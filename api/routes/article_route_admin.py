from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from core.database import get_db
from schemas import article_schema
from controllers import article_controller
from sqlalchemy.orm import Session

router = APIRouter()

# Create a new article
@router.post("/article/", response_model=article_schema.Article, tags=["articles"])
async def create_article(article: article_schema.ArticleCreate = Depends(article_schema.ArticleCreate.as_form), file: UploadFile = File(...), db: Session = Depends(get_db)):
    db_article = article_controller.get_article_by_name(db, name=article.name) # Get article by name so no dupplicate
    if db_article: # If there is already an article with that name
        raise HTTPException(status_code=400, detail="Article already registered with this name") # Throw error no dupplication
    return await article_controller.create_article(db=db, article=article, file=file)

# Patch an article
@router.patch("/articles/", response_model=article_schema.Article, tags=["articles"])
def update_article(article: article_schema.Article, db: Session = Depends(get_db)):
    db_article = article_controller.get_article(db, id=article.id) # Get article so we verifiy it exists
    if db_article is None: # If not exist
        raise HTTPException(status_code=404, detail="Article not found")
    return article_controller.update_article(db, article=article)

# Delete an article
@router.delete("/articles/", response_model=article_schema.Article, tags=["articles"])
def delete_article(article_id: str, db: Session = Depends(get_db)):
    db_article = article_controller.get_article(db, article_id=article_id) # Get article so we verifiy it exists
    if db_article is None: # If not exist
        raise HTTPException(status_code=404, detail="Article not found")
    return article_controller.delete_article(db, id=article_id)