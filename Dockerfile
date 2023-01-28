FROM node:19.5.0
WORKDIR /app
COPY src/package*.json ./
RUN npm install
COPY src/. .
EXPOSE 8080
CMD ["node", "server.js"]