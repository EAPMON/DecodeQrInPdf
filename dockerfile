FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    libzbar0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código
COPY . .

# Ejecutar la app
CMD ["hypercorn", "main:app"]
