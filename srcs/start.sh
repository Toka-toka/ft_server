#! /bin/bash

service mysql start

# Create MYSQL
mysql -e "CREATE DATABASE server_sedric"
mysql -e "CREATE USER 'sedric'@'localhost' IDENTIFIED BY 'sedric';"
mysql -e "GRANT ALL ON *.* TO 'sedric'@'localhost' IDENTIFIED BY 'sedric' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES"

# Install wordpress
mv wordpress/wp-config-sample.php wordpress/wp-config.php
mv wordpress/ /var/www/html/

sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', 'server_sedric' );/" /var/www/html/wordpress/wp-config.php
sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', 'sedric' );/" /var/www/html/wordpress/wp-config.php
sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', 'sedric' );/" /var/www/html/wordpress/wp-config.php

# Install phpmyadmin
unzip phpMyAdmin-5.0.2-all-languages.zip 1>/dev/null
rm -rf phpMyAdmin-5.0.2-all-languages.zip
mv phpMyAdmin-5.0.2-all-languages/ /var/www/html/phpmyadmin
ln -s /usr/share/phpmyadmin/  /var/www/html/phpmyadmin

service php7.3-fpm start
service nginx start

echo -e "\n- - - - - - - - - - - - - - - - - - - - - -"
echo -e "To enable autoindex use ./index.sh"
echo -e "- - - - - - - - - - - - - - - - - - - - - -\n"

bash
