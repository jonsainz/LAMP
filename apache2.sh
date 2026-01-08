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

echo -n "\n-----------------\nInstalando Apache\n-----------------\n"

sudo apt install apache2 -y

 


