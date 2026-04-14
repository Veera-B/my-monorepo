FROM node:20-alpine
WORKDIR /app

# కంటైనర్ లోపలికి ఫైల్స్ కాపీ చేయండి
COPY package*.json ./

# Nx ప్రాజెక్ట్ కాబట్టి ఇవన్నీ ఫోర్స్ గా ఇన్‌స్టాల్ చేద్దాం
RUN npm install
RUN npm install react react-dom @vitejs/plugin-react vite

COPY . .

# tsconfig లేదని ఎర్రర్ రాకుండా ఒకవేళ అది వేరే పేరుతో ఉంటే (ఉదా: tsconfig.app.json) 
# దాన్ని tsconfig.json గా లింక్ చేయాలి లేదా ఫైల్ అక్కడ ఉండేలా చూడాలి.

EXPOSE 4200
CMD ["npx", "vite", "--host", "--port", "4200"]