FROM python:3.10.0

WORKDIR /CashManager
COPY ./requirements.txt /CashManager/requirements.txt


# RUN pip install fastapi uvicorn pydantic
RUN pip install -r ./requirements.txt


EXPOSE 8080:8080

WORKDIR /usr/src/CashManager

ENV PORT 8080
ENV HOST "0.0.0.0"

COPY . /CashManager/
# COPY ./main.py /CashManager/

WORKDIR /CashManager

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]