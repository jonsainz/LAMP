#!/bin/bash

# Script para instalar LAMP en Ubuntu Server

# Comprobar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor ejecuta como root o con sudo"
  exit 1
fi

echo "Actualizando el sistema..."
apt update && apt upgrade -y

echo "Instalando Apache..."
apt install apache2 -y
systemctl enable apache2
systemctl start apache2


#CONF FIREWALL


echo "Instalando MariaDB..."
apt install mariadb-server mariadb-client -y
systemctl enable mariadb
systemctl start mariadb

echo "Seguridad básica de MariaDB..."
mysql_secure_installation <<EOF

y
123456
123456
y
y
y
y
EOF

echo "Instalando PHP y módulos comunes..."
apt install php php-mysql libapache2-mod-php php-cli php-curl php-gd php-mbstring php-xml php-zip -y

echo "Reiniciando Apache para aplicar cambios..."
systemctl restart apache2

echo "Configuración de permisos en /var/www/html..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "LAMP instalado correctamente!"
echo "Puedes probar PHP creando un archivo /var/www/html/info.php con el siguiente contenido:"
echo "<?php phpinfo(); ?>"

