#!/bin/bash

# Rutas a los archivos y directorios
DOCKERFILE_PATH="/home/user/test/docker/Dockerfile"
APP_SRC_PATH="/home/user/test/docker/src/"
NGINX_CONF_PATH="/home/user/test/docker/nginx.conf"
DOCKER_COMPOSE_PATH="/home/user/test/docker/docker-compose.yml"

# Compilar la imagen con el Dockerfile
docker build -t goi.v1.0 -f "$DOCKERFILE_PATH" "$APP_SRC_PATH"

# Crear el archivo docker-compose.yml
cat << EOF > "$DOCKER_COMPOSE_PATH"
version: '3'
services:
  myapp:
    image: goi.v1.0
    networks:
      - mynetwork
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - $NGINX_CONF_PATH:/etc/nginx/conf.d/default.conf
    networks:
      - mynetwork

networks:
  mynetwork:
EOF

# Levantar los servicios con docker-compose
docker-compose -f "$DOCKER_COMPOSE_PATH" up 

# Esperar un poco para asegurarse de que los servicios estén funcionando
sleep 5

echo "Script completado."

