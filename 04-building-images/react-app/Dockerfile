# FROM node:22.11-alpine3.20
# # COPY package.json README.md  /app/
# # COPY package*.json  /app/

# COPY .  /app/


# FROM node:22.11-alpine3.20
# RUN addgroup react-app && adduser -S -G react-app daniel
# USER daniel
# WORKDIR /app
# COPY . .
# RUN npm install
# ENV API_URL=http://apu.myapp.com
# EXPOSE  3000

# --------------------------------------------------

FROM node:22.11-alpine3.20
# Create a group and user early
RUN addgroup react-app && adduser -S -G react-app daniel
# Set working directory
WORKDIR /app
# Copy files and change ownership to the non-root user
COPY . .
RUN chown -R daniel:react-app /app
# Switch to the non-root user
USER daniel
# Install dependencies
RUN npm install
# Set environment variable
ENV API_URL=http://apu.myapp.com
# Expose application port
EXPOSE 3000
CMD ["npm", "start"]
