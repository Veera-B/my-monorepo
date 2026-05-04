FROM python:3.9-slim
WORKDIR /app
# రూట్ నుండి ఆ సర్వీస్ ఫోల్డర్ లోని ఫైల్స్ కాపీ చేయడం 
COPY apps/micro-services/auth-service/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY apps/micro-services/auth-service/ .
EXPOSE 80
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]