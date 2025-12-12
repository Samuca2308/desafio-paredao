FROM node:22 AS build
WORKDIR /app
COPY package*.json ./
COPY . /frontend
RUN npm install --legacy-peer-deps
EXPOSE 4200 3000
CMD ["/bin/bash", "-c", "cd api && npm run start:dev & cd pokedex && npm start"]
