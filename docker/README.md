## Dockerfile
```Dockerfile
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
```
## Explicación de la funcionalidad del Dockerfile

1. Esta línea indica que esta utilizando la imagen oficial de golang y una version especifica, se usa ```Alpine``` ya que esta pensada para correr en contenedores, evitar usar (Ubuntu o otros).
```Dockerfile
FROM golang:1.18-alpine
```

2. Se utiliza el gestor de paquetes apk de Alpine para instalar las herramientas vim y git en la imagen. El flag```--no-cache``` asegura que no se almacenen en caché los archivos de índice después de la instalación, lo que ayuda a mantener la imagen más pequeña,
no es recomendable instalar dependencias a menos que realmente lo necesites.
```Dockerfile
RUN apk add --no-cache vim git
```

3. Copiar todos los archivos y carpetas del directorio  actual (donde se encuentra el Dockerfile) al directorio ```/app``` en el contenedore.
```Dockerfile
COPY . /app
```

4. Establece el directorio de trabajo actual dentro del contenedor en ```/app```.
```Dockerfile
RUN go mod download ; go build -o ./app/main
```

5. Correr las lineas ```go mod download``` para descargar las dependencias del modulo, se evito usar  ```go get -v -d ./...``` ya que las versiones mas estables de golang ya no las usan y esta en desuso por la version 1.18.
```go build``` compila la app y genera un binario llamado  ```main``` en el directorio  ```/app```.
```Dockerfile
RUN go mod download ; go build -o ./app/main
```

6. usuario predeterminado dentro del contenedor como ```nobody```, un usuario de bajo privilegio que se usa comúnmente para aumentar la seguridad.
```Dockerfile
USER nobody
```

7. A línea establece el comando por defecto que se ejecutará cuando inicies un contenedor a partir de esta imagen. En este caso, se ejecutará el binario ```main``` en el directorio ```/app```.
```Dockerfile
CMD ["./app/main"]
```
# docker-compose
```yaml
version: '3'  # Versión de la sintaxis del archivo de Docker Compose

services:  # Define los servicios que serán administrados por Docker Compose
  myapp:  # Nombre del servicio "myapp"
    image: goi.v1.0  # Imagen a utilizar para este servicio
    networks:
      - mynetwork  # Conectar el servicio a la red "mynetwork"

  nginx:  # Nombre del servicio "nginx"
    image: nginx:latest  # Imagen a utilizar para este servicio
    ports:
      - "8080:80"  # Mapeo de puertos (puerto del host:puerto del contenedor)
    volumes:
      - /home/user/test/docker/nginx.conf:/etc/nginx/conf.d/default.conf  # Montar un archivo de configuración de Nginx
    networks:
      - mynetwork  # Conectar el servicio a la red "mynetwork"

networks:  # Define las redes que serán utilizadas por los servicios
  mynetwork:  # Nombre de la red "mynetwork"
    # Opciones de red (opcional)
```
#### Descripción:
- La versión ```3``` se refiere a la versión de la sintaxis del archivo de Docker Compose que estás utilizando.
- El archivo define dos servicios: ```myapp``` y ```nginx```. Cada servicio representa un contenedor administrado por Docker Compose.
- El servicio ```myapp``` utiliza la imagen ```goi.v1.0```. Está conectado a la red ```mynetwork```.
- El servicio ```nginx``` utiliza la imagen ```nginx:latest```. Está mapeando el puerto ```8080``` del host al puerto ```80``` del contenedor. También se está montando el archivo ```/home/user/test/docker/nginx.conf``` del host en la ruta ```/etc/nginx/conf.d/default.conf``` del contenedor para personalizar la configuración de Nginx. Este servicio también está conectado a la red ```mynetwork```.
- La definición de la red ```mynetwork``` se encuentra en la sección ```networks```. En este caso, no se proporcionaron opciones adicionales para la red.
##### En resumen: 
Este archivo ```docker-compose.yml``` define dos servicios: ```myapp``` y ```nginx```, y los conecta a una red llamada ```mynetwork```. El servicio ```myapp``` utiliza la imagen ```goi.v1.0```, mientras que el servicio nginx utiliza la imagen ```nginx:latest``` y personaliza la configuración de Nginx a través del montaje de un archivo de configuración externo. Ambos servicios están accesibles en la red ```mynetwork``` y pueden comunicarse entre sí.






