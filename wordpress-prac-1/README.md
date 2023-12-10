### STACK LEMP  - 1

Estaremos usando el stack-Lemp con unas instancias de GCP - Compute-Engine, nuestros server sera Ubuntu en esta ocasión.
lo primero que estaremos haciendo es actualizar nuestros paquetes y instalando los paquetes necesarios.
```Bash
sudo apt update ; sudo apt upgrade -y ; sudo apt install -y nginx mysql-server php-fpm php-mysql
```
despuúes de la instalación de nuestros paquetes estaremos revisando el estatus de los servicios.
```Bash
sudo systemctl status nginx 
sudo systemctl status mysql
```
# Descargar e instalar Wordpress
Creación de la carpeta para almacenar nuestro wordpress.
```Bash
sudo mkdir -p /var/www/html/hola.com 
```
descarga de wordpress en la carpeta creada.
```Bash
sudo wget -P /var/www/html/hola.com  https://wordpress.org/latest.tar.gz 
```
la el archivo de descarga de nuestro wordpress.
```Bash
tar -xzvf /var/www/html/hola.com/latest.tar.gz -C /var/www/html/hola.com/
```
# configuración de Mysql
procederemos a configurar nuestra base de datos - Mysql.
```Sql
sudo mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password'; # Cambia 'password' por una contraseña fuerte
GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EXIT
MYSQL_SCRIPT
```
# Configurar WordPress
copiaremos el archivo "wp-config-sample.php" a un nuevo archivo para configurarlo nuestro wordpress.
```Bash
sudo cp -r /var/www/html/hola.com/wordpress/wp-config-sample.php  /var/www/html/hola.com/wordpress/wp-config.php
```
introduciremos los nombres de nuestras config y la de nuestra base de datos.
```Bash
sudo sed -i "s/database_name_here/wordpress/g" /var/www/html/hola.com/wordpress/wp-config.php
sudo sed -i "s/username_here/wordpressuser/g" /var/www/html/hola.com/wordpress/wp-config.php
sudo sed -i "s/password_here/password/g" /var/www/html/hola.com/wordpress/wp-config.php
```
configurar Nginx para Wordpress backup.
```Bash
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup
```
en la carpeta "/etc/nginx/sites-available/default" cambiamos por un configuración mas optima.
```Bash
sudo bash -c 'cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name tudominio.com; # Reemplaza con tu dominio

    root /var/www/html/hola.com/wordpress; # Reemplaza con la ruta a tu instalación de WordPress

    index index.php index.html index.htm;

    access_log /var/log/nginx/tudominio_access.log;
    error_log /var/log/nginx/tudominio_error.log;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock; # Reemplaza con tu versión de PHP
    }

    location ~ /\.ht {
        deny all;
    }

    location = /favicon.ico { log_not_found off; access_log off; }
    location = /robots.txt { log_not_found off; access_log off; allow all; }
    location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
        expires max;
        log_not_found off;
    }

    # Otros ajustes específicos de WordPress si es necesario
}
EOF'
```
Creamos un enlace simbolico para nuestro carpeta de nginx de "/etc/nginx/sites-enabled".
```Bash
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
```
revisamos nuestra sintaxis de nginx 
```Bash
sudo nginx -t 
```
# Reiniciar Nginx
```Bash
sudo systemctl restart nginx 
```
echo "WordPress ha sido instalado y configurado correctamente. Puedes acceder a tu sitio en: http://midominio.com"
si no tienes un dominio podes configurarlo 

