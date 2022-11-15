---------------------------------------------------  DOCKER ---------------------------------------------------

# Build Image

docker build -t fastapi .

# Run container

docker run -d --name cashmanager -p 8000:8000 fastapi




---------------------------------------------------  FastAPI ---------------------------------------------------


# API INSTALL

pip install requirements.txt

# API RUN

uvicorn api.main:app --reload
# or
python3 -m uvicorn main:app --reload

