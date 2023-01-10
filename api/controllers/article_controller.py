from fastapi import UploadFile
from sqlalchemy.orm import Session
from models.article_model import Article as ArticleModel
from schemas.article_schema import Article as ArticleSchema
from core.images import upload_file, create_code
from uuid import UUID

# Get article by id
def get_article(db: Session, article_id: int):
    return db.query(ArticleModel).filter(ArticleModel.id == article_id).first()

# Get all articles
def get_articles(db: Session, skip: int = 0, limit: int = 100):
    return db.query(ArticleModel).offset(skip).limit(limit).all()

# Delete article
def delete_article(db: Session, article_id: UUID):
    db_article = db.query(ArticleModel).filter(ArticleModel.id == article_id).first()
    db.delete(db_article)
    db.commit()
    return db_article

# Create article
async def create_article(db: Session, article: ArticleSchema, file: UploadFile):
    db_article = ArticleModel(
        price=article.price,
        name=article.name,
        description=article.description,
        category=article.category,
        stock=article.stock,
        image= await upload_file(file) # Save article image
    )
    db.add(db_article)
    db.commit()
    db.refresh(db_article)
    db_article.code = create_code(db_article.id) # Create code image for article and save the code
    db.commit()
    db.refresh(db_article)
    return db_article

# Update article
def update_article(db: Session, article: ArticleSchema):
    db_article = db.query(ArticleModel).filter(ArticleModel.id == article.id).first()
    db_article.price = article.price
    db_article.name = article.name
    db_article.description = article.description
    db_article.category = article.category
    db_article.stock = article.stock
    db_article.image = article.image
    db_article.code = article.code
    db.commit()
    db.refresh(db_article)
    return db_article

# Get article by name
def get_article_by_name(db: Session, name: str):
    return db.query(ArticleModel).filter(ArticleModel.name == name).first()

# Get article by code
def get_article_by_code(db: Session, code: str):
    return db.query(ArticleModel).filter(ArticleModel.code == code).first()