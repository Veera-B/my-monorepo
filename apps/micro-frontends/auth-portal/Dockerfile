FROM node:20-alpine
WORKDIR /app

COPY package*.json ./


RUN npm install
RUN npm install react react-dom @vitejs/plugin-react vite

COPY . .



EXPOSE 4200
CMD ["npx", "vite", "--host", "--port", "4200"]
