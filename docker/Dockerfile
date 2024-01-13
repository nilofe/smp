# Establece la imagen base a utilizar, en este caso, Golang con Alpine 1.18
FROM golang:1.18-alpine

# Instala las herramientas vim y git sin caché para mantener la imagen más ligera
RUN apk add --no-cache  vim git

# Copia el contenido del directorio actual al directorio /app en el contenedor
COPY . /app

# Establece el directorio de trabajo en /app
WORKDIR /app

# Descarga las dependencias del módulo y compila
RUN go mod download ;  go build -o ./app/main

# Establece el usuario predeterminado en "nobody"
USER nobody

# Comando por defecto a ejecutar cuando se inicie el contenedor
CMD ["./app/main"]

