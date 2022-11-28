from fastapi import Depends, FastAPI, Request, Response
from core.database import SessionLocal, Base, engine
from routes import user_route, auth_route, article_route
from core import jwt
from sqladmin import Admin, ModelView
from models import user_model, article_model

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(auth_route.router)
app.include_router(
    user_route.router,
    dependencies=[Depends(jwt.get_current_user), Depends(jwt.is_admin)],
)
app.include_router(
    article_route.router,
    dependencies=[Depends(jwt.get_current_user)]
)


@app.middleware("http")
async def db_session_middleware(request: Request, call_next):
    response = Response("Internal server error", status_code=500)
    try:
        request.state.db = SessionLocal()
        response = await call_next(request)
    finally:
        request.state.db.close()
    return response


admin = Admin(app, engine)
class UserAdmin(ModelView, model=user_model.User):
    column_list = [user_model.User.id, user_model.User.email, user_model.User.firstname, user_model.User.lastname, user_model.User.role, user_model.User.birthdate, user_model.User.genre]

class ArticleAdmin(ModelView, model=article_model.Article):
    column_list = [article_model.Article.id, article_model.Article.name, article_model.Article.description, article_model.Article.price, article_model.Article.leftAvailable, article_model.Article.category]

admin.add_view(UserAdmin)
admin.add_view(ArticleAdmin)