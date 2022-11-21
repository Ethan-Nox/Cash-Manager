FROM python:3.10.0

WORKDIR /app

COPY requirements.txt .

<<<<<<< HEAD
# RUN pip install fastapi uvicorn pydantic
RUN pip install -r ./requirements.txt


EXPOSE 8000:8000

WORKDIR /usr/src/CashManager

ENV PORT 8000
=======
RUN pip install -r requirements.txt

COPY . .
ENV PORT 8080
>>>>>>> b10fa30 (fix(Docker): fastApi reload)
ENV HOST "0.0.0.0"
EXPOSE 8080

<<<<<<< HEAD
COPY ./src/ /CashManager/src
COPY ./main.py /CashManager/

WORKDIR /CashManager

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
=======
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080" , "--reload"]
>>>>>>> b10fa30 (fix(Docker): fastApi reload)
