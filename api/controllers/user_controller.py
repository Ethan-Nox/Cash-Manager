from pydantic import BaseModel
from sqlalchemy.orm import Session
from schemas.user_schema import User
from models.user_model import User as UserModel
from models.article_model import Article as ArticleModel
from models.bill_model import Bill as BillModel
from models.product_model import Product as ProductModel
from schemas.user_schema import User as UserSchema
from controllers.article_controller import get_article, get_article_by_code
from core.hashing import Hasher
from uuid import UUID
from datetime import date
from fastapi import HTTPException

# Get user by id
def get_user(db: Session, user_id: UUID):
    return db.query(UserModel).filter(UserModel.id == user_id).first()
# Get user by email
def get_user_by_email(db: Session, email: str):
    return db.query(UserModel).filter(UserModel.email == email).first()

# Get all users
def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(UserModel).offset(skip).limit(limit).all()

# Delete user
def delete_user(db: Session, user_id: UUID):
    db_user = db.query(UserModel).filter(UserModel.id == user_id).first()
    db.delete(db_user)
    db.commit()
    return db_user

# Create user
def create_user(db: Session, user: UserSchema):
    db_user = UserModel(
        email=user.email,
        hashed_password=Hasher.get_password_hash(user.password), # Hash the provided password
        firstname=user.firstname,
        lastname=user.lastname,
        birthdate=user.birthdate,
        genre=user.genre,
        role=1, # 0 by default for basic users
        products=[], # Empty products
        bills=[] # Empty bills
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# Update user
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

# Login with email and password
def login(db: Session, email: str, password: str):
    user = get_user_by_email(db, email) # Get user by email to verify his password later
    if not user: # No user found
        return False
    if not Hasher.verify_password(password, user.hashed_password): # Verify if the password provided is good
        return False
    return user

# Add article to user product list
def add_article_to_user(db: Session, article_id: int, user_id: UUID, quantity: int):
    db_user: UserModel = get_user(db, user_id) # Get user by uuid from token
    # No need to verify if user exist since we already verified the token
    db_article: ArticleModel = get_article(db, article_id) # Get article from id asked
    if db_user is None: # But we need to verify the article
        raise HTTPException(status_code=404, detail="Article not founnd")
    db_product = ProductModel(
        article=db_article,
        quantity=quantity
    ) # Create product with article and quatity
    if (db_product.quantity <= 0): # If quantity is null or negative
        for product in db_user.products:
            if product.article.id == db_product.article.id: # Delete product from user product list
                db_user.products.remove(product)
    db.add(db_product)
    db.commit()
    db.refresh(db_product) # Save in the db
    for product in db_user.products:
        if product.article.id == db_product.article.id: # Verify if this product is already in user product list
            db_user.products.remove(product) # Replace it if it's the case
    db_user.products.append(db_product) # So the quantity is updated
    db.commit()
    db.refresh(db_user)
    return True # Everything went well

def remove_article_to_user(db: Session, article_id: int, user_id: UUID):
    db_user: UserModel = get_user(db, user_id) # Get user by uuid from token
    # No need to verify if user exist since we already verified the token
    db_article: ArticleModel = get_article(db, article_id) # Get article from id asked
    if db_user is None: # But we need to verify the article
        raise HTTPException(status_code=404, detail="Article not founnd")
    for product in db_user.products:
        if product.article.id == db_article.id: # Delete product from user product list
            db_user.products.remove(product)
            return True # Everything went well
    return False # Article not in product list

# Add article to user product list by scanning bar code
def add_article_to_user_with_scan(db: Session, code: str, user_id: UUID):
    db_user: UserModel = get_user(db, user_id) # Get user from token user uid
    # No need to verify if user exist since we already verified the token
    db_article: ArticleModel = get_article_by_code(db, code) # Get article from code
    if db_user is None: # But we need to verify the article
        raise HTTPException(status_code=404, detail="Article not founnd")
    my_bool = False # Boolean to verify is product is alreay in user product list

    for product in db_user.products:
        if product.article.id == db_article.id: # If product is already there
            product.quantity += 1 # We add new one so increment by one the quantity
            my_bool = True # Set bool to true for not duplication
            db.commit()
            db.refresh(product)
    if (my_bool == False): # If it's the first time this article in product list
        db_product = ProductModel(
            article=db_article,
            quantity=1
        ) # We create new one with basic quantity as 1
        db.add(db_product)
        db.commit()
        db.refresh(db_product)
        db_user.products.append(db_product) # And then we add it
    db.commit()
    db.refresh(db_user)

    return True # Everything went well

class BillResponse(BaseModel): # Bill class for resquest response
    status: bool
    id: int

def new_bill(db: Session, user_id: UUID):
    db_user: User = get_user(db, user_id) # Get user from token user id
    # No need to verify if user exist since we already verified the token
    if (len(db_user.products) < 1): # If there is no product in user product list
        return BillResponse(status=False, id=0) # We return False and id = 0 so it doesn't correspond to any id

    total_price = 0 # Init total price
    for product in db_user.products: # For every product in product list
        total_price += product.quantity * product.article.price # We had the price of article multiplied by quantity
        if (product.quantity > product.article.stock): # If asked quantity is higher than article stock
            return BillResponse(status=False, id=product.article.id) # User can buy it so we return False and id = article.id which had trouble
    db_bill = BillModel(
        total_price = total_price,
        products = db_user.products,
        user = db_user,
        date = date.today()
    ) # Created new bill with the total price and the current date
    db.add(db_bill)
    db.commit()
    db.refresh(db_bill)
    db_user.bills.append(db_bill) # Adding the bill to user bill list
    for product in db_user.products: # For each bought products
        product.article.stock -= product.quantity # We update stocks by retrieving quantity
        db.refresh(product)
    db_user.products = [] # And we clean user product lsit
    db.commit()
    db.refresh(db_user)

    return BillResponse(status=True, id=0) # Everything went well