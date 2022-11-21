---------------------------------------------------  DOCKER ---------------------------------------------------

# Build Image

docker build -t fastapi .

# Run container

docker run -d --name cashmanager -p 8000:8000 fastapi




---------------------------------------------------  FastAPI ---------------------------------------------------


# API INSTALL

```console
pip install -r requirements.txt
```

# API RUN

```console
uvicorn api.main:app --reload
```
 **or**
```console
python3 -m uvicorn main:app --reload
```