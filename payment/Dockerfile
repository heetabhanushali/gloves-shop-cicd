FROM --platform=linux/amd64 python:3.9-slim

EXPOSE 8080

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libc-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY *.py /app/
COPY payment.ini /app/

CMD ["uwsgi", "--ini", "payment.ini"]
