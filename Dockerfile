FROM node:18
WORKDIR /usr/src/app
COPY package.json .
RUN npm i
COPY . .
CMD ["node","index.js"] 
EXPOSE 3000
