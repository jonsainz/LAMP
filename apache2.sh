#!/bin/bash


# Primero comprobar si es root

if [[ $EUID -ne 0 ]]; then

	echo -e "\nPara ejecutar ese script de instalacion, hace falta tener permisos de Root.\n"
	echo -e "\nEscribe: sudo ./apache2.sh\n"
	exit 1
fi

# Actualizamos el sistema

echo -e "\n-----------------------\nActualizando sistema...\n-----------------------\n"

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

echo -e "\n------------------------Configurando el firewall------------------------\n"

sudo ufw allow 'apache' || sudo ufw allow 80/tcp
sudo ufw reload
sudo ufw status

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"


echo -e "\n-------------------------------------\nPreparando configuracion de Apache...\n--------------------------------------\n"

sudo cp -r -v config/web.conf /etc/apache2/sites-available/

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

#Creando pagina web basica
echo -e "\n-------------------------\nCreando pagina web basica\n------------------------\n"

sudo mkdir -v /var/www/web/
sudo mkdir -v /var/www/web/html

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

sudo cp -r -v config/index.html /var/www/web/html

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

echo -e "\n-----------------------\nConfigurando pagina web\n-----------------------\n"

sudo chmod -R -v 755 /var/www/web/
sudo chown -R -v www-data:www-data /var/www/web/

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

sudo a2ensite web.conf
sudo a2dissite 000-default.conf

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

echo -e "\n--------------------------------\nTest de configuracion de apache\n-------------------------------\n"
sudo apachectl configtest

echo -e "\n"
read -p "Pulsa ENTER para continuar..."
echo -e "\n"

sudo systemctl restart apache2

echo -e "\n-----------------------------------\nInstalacion y configuracion Acabada\n-----------------------------------\n"
sudo hostname -I
echo -e "\nAbre tu navegador y escribe la IP mostrada: http://IP\n"
