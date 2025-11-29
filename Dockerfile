FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --no-audit --no-fund

COPY server.js ./
COPY data.json ./

EXPOSE 4000

CMD ["node", "server.js"]
