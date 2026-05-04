# Stage 1: Build
FROM node:20-alpine AS build
WORKDIR /app

# Dependencies ఇన్స్టాలేషన్
COPY package*.json ./
RUN npm install

# పూర్తి కోడ్ కాపీ చేయడం
COPY . .

# ఇక్కడ మార్పు ఉంది: బిల్డ్ చేసే ముందు ఆ ఫోల్డర్ లోకి వెళ్ళాలి
WORKDIR /app/apps/micro-frontends/auth-portal
RUN npx vite build --base ./

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine
# బిల్డ్ అయిన ఫైల్స్ సాధారణంగా ఆ ఫోల్డర్ లోని 'dist' లో ఉంటాయి
COPY --from=build /app/apps/micro-frontends/auth-portal/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]