docker build .
docker build -f Dockerfile.dev .  == the -f indicates a particular file
docker build .   ==  for building the normal; Dockerfile

docker run 6abac884ced5   == will run our project in a container
docker run -p 3000:3000 6abac884ced5  == we are matching our local host port to docker

docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app 9fb37317fb88

sudo docker volume stop id
sudo docker volume re id

#to wipe docker clean from scratch
sudo docker container stop $(docker container ls –aq) && docker system prune –af ––volumes

#Running test in docker
docker build -f Dockerfile.dev .
docker run f42c40798675 npm run test

ngnix server == open source web server for load balancing, caching, media streaming and more.
it helps us to use our application in production environment
we can use it to host simple static content

docker build .
sudo docker run -p 8080:80 84efc8072fe0 == rus ngnix

...............
version: '3'
services:
  web:
    stdin_open: true
    environment:
      - CHOKIDAR_USEPOLLING=true
    build: .
    ports:
      - '3000:3000'
    volumes:
      - /app/node_modules
      - .:/app

  .........................................

  FROM node:alpine
  WORKDIR '/app'
  COPY package.json .
  RUN npm install
  COPY . .
  RUN npm run build

  FROM nginx
  COPY --from=0 /app/build /usr/share/nginx/html
  .............................................
