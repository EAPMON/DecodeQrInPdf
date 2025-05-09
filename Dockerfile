FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libzbar-dev \
    libzbar0 \
    zbar-tools \
    build-essential \
    python3-dev \
    gcc \
    && apt-get clean

COPY requirements.txt .
COPY main.py .
COPY railway.json .

RUN pip install --no-cache-dir -r requirements.txt hypercorn

EXPOSE 8000

CMD [ "sh", "-c", "hypercorn main:app --bind 0.0.0.0:${PORT}" ]
