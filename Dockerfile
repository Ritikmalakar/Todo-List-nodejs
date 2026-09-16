FROM node:24.14.1
WORKDIR app
COPY . /app
RUN npm install
EXPOSE 4000
CMD ["node","index.js"]
