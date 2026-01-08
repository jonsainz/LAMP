#!/bin/bash


# Primero comprobar si es root

if [[ $EUID -ne 0 ]]; then

	echo -e "\nPara ejecutar ese script de instalacion, hace falta tener permisos de Root.\n"
	echo -e "\Escribe: sudo ./apache2.sh\n"
	exit 1
fi

# Actualizamos el sistema

sudo apt update -y && sudo upgrade -y

# Instalamos apache2

sudo apt install apache2 -y

 


