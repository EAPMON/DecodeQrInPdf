# Usar una imagen base de Python
FROM python:3.12-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    libzbar-dev \
    libzbar0 \
    zbar-tools \
    build-essential \
    python3-dev \
    gcc \
    && apt-get clean

# Copiar los archivos necesarios al contenedor
COPY requirements.txt .
COPY main.py .
COPY railway.json .

# Instalar dependencias de Python, incluyendo hypercorn
RUN pip install --no-cache-dir -r requirements.txt hypercorn

# Exponer el puerto que usará la aplicación
EXPOSE 8000

# Comando para iniciar la aplicación
CMD ["hypercorn", "main:app", "--bind", "[::]:8000"]