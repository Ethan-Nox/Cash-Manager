from fastapi import Depends, FastAPI, Request, Response
from core.database import SessionLocal, Base, engine
from routes import user_route, auth_route, article_route_user, article_route_admin, bill_route
from core import jwt, images
from sqladmin import Admin, ModelView
from models import user_model, article_model, bill_model

Base.metadata.create_all(bind=engine) # Init engine database

app = FastAPI() # Init FASTAPI

#AUTH
app.include_router(auth_route.router)
app.include_router(
    auth_route.router_easy_log,
    dependencies=[Depends(jwt.get_current_user)])

#USER
app.include_router(
    user_route.router,
    dependencies=[Depends(jwt.get_current_user), Depends(jwt.is_admin)],
)
app.include_router(
    article_route_admin.router,
    dependencies=[Depends(jwt.get_current_user), Depends(jwt.is_admin)],
)

#ARTICLE
app.include_router(
    article_route_user.router,
    dependencies=[Depends(jwt.get_current_user)]
)

#IMAGE
app.include_router(
    images.router,
)

#BILL
app.include_router(
    bill_route.router,
    dependencies=[Depends(jwt.get_current_user)]
)

# Middleware that verify each request and queue
@app.middleware("http")
async def db_session_middleware(request: Request, call_next):
    response = Response("Internal server error", status_code=500)
    try:
        request.state.db = SessionLocal()
        response = await call_next(request)
    finally:
        request.state.db.close()
    return response

# Init Admin page
admin = Admin(app, engine)
class UserAdmin(ModelView, model=user_model.User): # Setup Users class to admin page
    column_list = [user_model.User.id, user_model.User.email, user_model.User.firstname, user_model.User.lastname, user_model.User.role, user_model.User.birthdate, user_model.User.genre]

class ArticleAdmin(ModelView, model=article_model.Article): # Setup Article class to admin page
    column_list = [article_model.Article.id, article_model.Article.name, article_model.Article.description, article_model.Article.price, article_model.Article.stock, article_model.Article.category, article_model.Article.code]

class BillAdmin(ModelView, model=bill_model.Bill): # Setup Bill class to admin page
    column_list = [bill_model.Bill.id, bill_model.Bill.date, bill_model.Bill.total_price]


# Admin views to admin page
admin.add_view(UserAdmin)
admin.add_view(ArticleAdmin)
admin.add_view(BillAdmin)