FROM python:3.10.0

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .
ENV PORT 8080
ENV HOST "0.0.0.0"
EXPOSE 8080

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080" , "--reload"]