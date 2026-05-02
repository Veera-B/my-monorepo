# --- STAGE 1: Build Frontend ---
FROM node:20-alpine AS frontend-builder
WORKDIR /app
COPY package*.json ./
RUN npm install --include=dev
COPY . .
# auth-portal ని బిల్డ్ చేయడం
ENV NODE_OPTIONS=--max-old-space-size=4096
RUN npx nx build auth-portal --prod --verbose
RUN ls -la
RUN ls -R apps/micro-frontends/auth-portal/dist || ls -R dist

# --- STAGE 2: Build Backend & Final Image ---
FROM python:3.11-slim
WORKDIR /app

# కంటైనర్ లోపల అవసరమైన సాఫ్ట్‌వేర్ (Nginx)   ఇన్‌స్టాల్ చేయడం
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Backend dependencies ఇన్‌స్టాల్ చేయడం
# ఫోల్డర్ పాత్: apps/micro-services/auth-service/requirements.txt
COPY apps/micro-services/auth-service/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Backend కోడ్ కాపీ చేయడం
COPY apps/micro-services/auth-service/ ./

# Frontend బిల్డ్ ఫైల్స్ ని Nginx ఫోల్డర్‌లోకి కాపీ చేయడం
# పాత లైన్ ని తీసేసి ఇది పెట్టు:
COPY --from=frontend-builder /app/apps/micro-frontends/auth-portal/dist /usr/share/nginx/html
# Nginx కాన్ఫిగరేషన్ (Frontend ని 80 పోర్ట్ మీద రన్ చేయడానికి)
RUN echo 'server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        try_files $uri $uri/ /index.html; \
    } \
    location /api/ { \
        proxy_pass http://localhost:8000/; \
    } \
}' > /etc/nginx/sites-available/default

# Startup స్క్రిప్ట్: Nginx మరియు Python రెండింటినీ స్టార్ట్ చేయడానికి
RUN echo "#!/bin/bash \n\
nginx \n\
gunicorn app.main:app --bind 0.0.0.0:8000" > /app/start.sh
RUN chmod +x /app/start.sh
RUN find . -name "index.html"

EXPOSE 80
CMD ["/app/start.sh"]