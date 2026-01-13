read -sp "Introduce la nueva contraseña para MariaDB: " password
sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$password';
FLUSH PRIVILEGES;
EOF
echo -e "\n✅ Contraseña actualizada correctamente."

echo -e "\n"
read -p "Pulsa ENTER para probar si el cambio a sido correcto"
echo -e "\n"

mysql -u root -p
