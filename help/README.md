# LAMP

Es un script de instalacion de Apache para Ubuntu. Este script instala y configura apache para que funcione directamente.
Hay que tener en cuneta que esto es para que funicone en HHTP. Para que funcione en HHTPS hay otro scripts-

- Instala Apache
- Configura archivo de confoiguracion .conf
- Da permisos de Firewall
- Activa la web
- Da los permisos necesarios a los archivos

--

## Organizacion


1) instalar apache

- Usar instalador apache2.sh


--

### Instalacion manual

- Instalar Apache

- dentro de /etc/apache2/sites-available hay un archivo qeu es 000-default.conf. Copiarlo como archivo WEB.conf
  Dentro de ese archivo web.conf configurar el archivo poniendo donde esta la web /var/www/WEB/html

- Configurar bien el archivo web.conf:

<VirtualHost *:80>
    # 1. Identificación (Opcional si es local, pero buena práctica)
    ServerName localhost (web: web.duckdns.org xejemplo)
    ServerAdmin webmaster@localhost

    # 2. Ruta de los archivos (Donde está tu index.html)
    DocumentRoot /var/www/web/html

    # 3. Permisos de acceso (Vital para evitar el error 403)
    <Directory /var/www/web/html>
        Options Indexes FollowSymLinks
	# (Indexes: si no encuentra index.html te muestra lista, perfecto para el desarrollo pero no para cuando este lista//
	# Fowwolsymlink: permite accesos directos a mi disco por si hay un enlace a algo en mi ordenador//)

        AllowOverride All (lee las reglas del htaccess como contraseñas para careptas o re4direcciones)
        Require all granted (Permite que todo el mundo vea pued aver el contenido de esta carpeta, sin esto da error)
    </Directory>

    # 4. Archivos de registro (Para saber qué falla)
    ErrorLog ${APACHE_LOG_DIR}/error_web.log (guarda fallos)
    CustomLog ${APACHE_LOG_DIR}/access_web.log combined (quien a entrado)
</VirtualHost>

- Activar sitio WEB:

	sudo a2ensite WEB.conf
	sudo a2dissite 000-default.conf
	sudo systemctl restart apache2

- Crear el archivo index.html para probar el http://localhost o http://IP (puedes sabrerla escibiendo: hostname -I)
- Dar permisos a la nueva web:

	sudo chmod -R 755 /var/www/WEB
	sudo chown www-data:www-data /var/www/WEB/html/index.html
	sudo chmod 644 /var/www/WEB/html/index.html


