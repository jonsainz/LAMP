#!/bin/bash


# Primero comprobar si es root

if [[ $EUID -ne 0 ]]; then

	echo -e "\nPara ejecutar ese script de instalacion, hace falta tener permisos de Root.\n"
	echo -e "\nEscribe: sudo ./apache2.sh\n"
	exit 1
fi

# Actualizamos el sistema

echo -e "\n------------------------\nActualizando sistema...\n-----------------------\n"

sudo apt update -y && sudo apt upgrade -y

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

# Instalamos apache2

echo -e "\n--------------------\nInstalando Apache...\n--------------------\n"

sudo apt install apache2 -y

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

echo -e "\nConfigurando el firewall\n"

sudo ufw allow 'apache' || sudo ufw allow 80/tcp
sudo ufw reload
sudo ufw status

echo -e "\n"
read -p "Pulsa ENTER para continuar..."


echo -e "\n-------------------------------------\nPreparando configuracion de Apache...\n--------------------------------------\n"

sudo cp -r config/web.conf /etc/apache2/sites-available/

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

#Creando pagina web basica

sudo mkdir /var/www/web/
sudo mkdir /var/www/web/html

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

#ALGO A FALLADO AQUI PORQUE NO EXISTE EL ARCHIVO
sudo cp -r config/index.html /var/www/web/html

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

#Dando permisos al archivo de configuracion
sudo chmod -R 755 /var/www/web/
sudo chown -R www-data:www-data /var/www/web/

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

sudo a2ensite web.conf
sudo a2dissite 000-default.conf

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

sudo apachectl configtest
#Esto quiero mostrarlo en pantalla

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

sudo systemctl restart apache2

echo -e "\nInstalacion y configuracion Acabada\n"
sudo hostname -I
echo -e "\nAbre tu navegador y escribe la IP mostrada: http://IP\n"
