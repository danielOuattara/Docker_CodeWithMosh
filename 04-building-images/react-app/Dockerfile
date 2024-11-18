# FROM node:22.11-alpine3.20
# # COPY package.json README.md  /app/
# # COPY package*.json  /app/

# COPY .  /app/


FROM node:22.11-alpine3.20
WORKDIR /app/
COPY . .
RUN npm install
ENV API_URL=http://apu.myapp.com
EXPOSE  3000
RUN addgroup react-app && adduser -S -G react-app daniel
USER daniel