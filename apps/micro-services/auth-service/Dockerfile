FROM python:3.9-slim
WORKDIR /app

COPY apps/micro-services/auth-service/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY apps/micro-services/auth-service/ .
EXPOSE 80
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
