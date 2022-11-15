from api.models.user_model import User

class UserController:
    def __init__(self):
        pass

    def get_user(self, uuid: str) -> User:
        return User(
            firstname="John",
            lastname="Doe",
            uuid=uuid,
            email="