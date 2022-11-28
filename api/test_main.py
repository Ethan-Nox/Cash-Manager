from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


class TestAuth:

    def test_login_unauthorize(self):
        response = client.post("/login", json={"email": "test@test.com", "password": "test"})
        assert response.status_code == 401

    def test_login_authorize(self):
        response = client.post("/login", json={"email": "ogrodnik.lucas@gmail.com", "password": "oui"})
        assert response.status_code == 200

    def test_register_unauthorize(self):
        response = client.post("/register", json={
            "first_name": "Lucas",
            "last_name": "Ogrodnik",
            "email": "ogrodnik.lucas@gmail.com",
            "password": "oui",
            "birth_date": "1999-01-01",
            "genre": 0,
            "role": 0
        })
        assert response.status_code == 400

class TestUserAdmin:

    headers: dict = { "token": "" }

    def test_login_admin(self):
        response = client.post("/login", json={"email": "ogrodnik.lucas@gmail.com", "password": "oui"})
        response_body = response.json()
        assert response.status_code == 200
        self.headers["token"] = response_body["token"]["access_token"]

    def test_get_users(self):
        response = client.get("/users/", headers=self.headers)
        assert response.status_code == 200

class TestUser:

    headers: dict = { "token": "" }

    def test_login_user(self):
        response = client.post("/login", json={"email": "user@example.com", "password": "string"})
        response_body = response.json()
        assert response.status_code == 200
        self.headers["token"] = response_body["token"]["access_token"]

    def test_get_users(self):
        response = client.get("/users/", headers=self.headers)
        assert response.status_code == 403