FROM node:20-alpine AS build
WORKDIR /app

# Dependencies ఇన్స్టాలేషన్
COPY package*.json ./
RUN npm install

# పూర్తి కోడ్ కాపీ చేసి బిల్డ్ చేయడం
COPY . .
# ఒకవేళ నీ vite.config.ts రూట్ లో లేకపోతే, పాత్ కరెక్ట్ గా ఇవ్వాలి
RUN npx vite build --base ./

# రెండవ స్టేజ్: కేవలం బిల్డ్ అయిన ఫైల్స్ ని Nginx లో పెట్టడం 
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html

# అజూర్ వెబ్ యాప్ కోసం పోర్ట్ 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]