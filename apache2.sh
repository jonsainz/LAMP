#!/bin/bash


# Primero comprobar si es root

if [[ $EUID -ne 0 ]]; then

	echo -e "\nPara ejecutar ese script de instalacion, hace falta tener permisos de Root.\n"
	echo -e "\Escribe: sudo ./apache2.sh\n"
	exit 1
fi

# Actualizamos el sistema

echo -n "\n------------------------\nActualizando sistema...\n-----------------------\n"

sudo apt update -y && sudo upgrade -y

# Instalamos apache2

echo -n "\n--------------------\nInstalando Apache...\n--------------------\n"

sudo apt install apache2 -y

echo -n "\n-------------------------------------\nPreparando configuracion de Apache...\n--------------------------------------\n"

sudo cp -r config/web.conf /etc/apache2/sites-available/

#Creando pagina web basica

sudo mkdir /var/www/web/
sudo mkdir /var/www/web/html
sudo cp -r /config/index.html /var/www/web/html

#Dando permisos al archivo de configuracion
sudo chmod -R 755 /var/www/web/html/index.html
sudo chown www-data:www-data /var/www/web/html/index.html

sudo a2ensite web.conf
sudo a2dissite 000-default.conf

sudo apachectl configtest
#Esto quiero mostrarlo en pantalla


sudo systemctl restart apache2

echo -n "\nInstalacion y configuracion Acabada\n"
sudo hostname -I
echo -n "\nAbre tu navegador y escribe la IP mostrada: http://IP\n" 

