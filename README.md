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
configurar Nginx para Wordpress backup.
```Bash
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup
```
en la carpeta "/etc/nginx/sites-available/default" cambiamos por un configuración mas optima.
```Bash
server {
    listen 80;
    server_name midominio.com; # Cambia esto por tu dominio o IP

    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock; # Cambia la versión de PHP si es necesario
    }
}
```
Creamos un enlace simbolico para nuestro carpeta de nginx de "/etc/nginx/sites-enabled".
```Bash
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
```
# Reiniciar Nginx
```Bash
sudo systemctl restart nginx 
```
# Descargar r instalar Wordpress
```Bash
mkdir -p /var/www/html/hola.com  
sudo wget -P /var/www/html/hola.com  https://wordpress.org/latest.tar.gz 
tar -xzvf latest.tar.gz -C /var/www/html/hola.com/
```

