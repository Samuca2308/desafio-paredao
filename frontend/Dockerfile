FROM node:22 AS build

WORKDIR /frontend

RUN npm install -g @angular/cli

COPY package*.json ./

COPY . /frontend

RUN npm install --legacy-peer-deps

EXPOSE 4200

# Start Angular development server
CMD ["ng", "serve", "--host", "0.0.0.0", "--proxy-config", "src/proxy.conf.json"]

#CMD ["/bin/bash", "-c", "npm run start"]
