#!/bin/bash

# Script para instalar LAMP en Ubuntu Server

# Comprobar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor ejecuta como root o con sudo"
  exit 1
fi

# Ejecuta Script de instalacion y configuracion de Apache2
sudo ./apache2.sh

# Instalando MariaDB. Es un Mysql gratuito que funciona igual.

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

echo -e "\n------------------\nInstalando MariaDB\n------------------\n"
apt install mariadb-server mariadb-client -y
systemctl enable mariadb
systemctl start mariadb

echo -e "\n"
read -p "Pulsa ENTER para continuar"
echo -e "\n"

echo -e "\n---------------------------\nSeguridad básica de MariaDB\n---------------------------\n"
mysql_secure_installation <<EOF

y
123456
123456
y
y
y
y
EOF

echo -e "\nLa contraseña de MariaDB se a establecido como: 123456\n"
echo -e "\nCambia la contraseña despues de la instalacion con el script 'config/mariadb-pass.sh\n"

echo -e "\n"
read -p "Pulsa ENTER para continuar"
echo -e "\n"

echo -e "\n--------------------------------\nInstalando PHP y módulos comunes\n--------------------------------\n"
apt install php php-mysql libapache2-mod-php php-cli php-curl php-gd php-mbstring php-xml php-zip -y

echo -e "\n"
read -p "Pulsa ENTER para continuar"
echo -e "\n"

echo -e "\nReiniciando Apache para aplicar cambios\n"
systemctl restart apache2

echo -e "\nCreando pagina index.php e info.php\n"
sudo cp -r -v config/info.php /var/www/web/html
sudo mv -v config/index.html /var/www/web/html/index.php


echo -e "\nLAMP instalado correctamente!\n"
hotname -I
echo -e "\nPuedes comprobar tu web: http://IP y tu php: http://IP/info.php
echo "No olvides ejecutar el script config/mariadb-pass.sh para cambiar la contraseña. por defecto: 123456"
