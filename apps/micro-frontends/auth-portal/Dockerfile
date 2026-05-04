# Stage 1: Build
FROM node:20-alpine AS build
WORKDIR /app

# Dependencies ఇన్స్టాలేషన్ (Root level)
COPY package*.json ./
RUN npm install

# పూర్తి కోడ్ కాపీ చేయడం
COPY . .

# బిల్డ్ చేసే ముందు ఆ ఫోల్డర్ లోకి వెళ్ళాలి
WORKDIR /app/apps/micro-frontends/auth-portal

# ఇక్కడ Vite కి స్పష్టంగా root పాత్ ఇదేనని చెబుతున్నాం
RUN npx vite build --root . --base ./

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine

# Nginx SPA కాన్ఫిగరేషన్ (ఇది 503 రాకుండా చూస్తుంది)
RUN echo 'server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# బిల్డ్ అయిన ఫైల్స్ ని కాపీ చేయడం
COPY --from=build /app/apps/micro-frontends/auth-portal/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]