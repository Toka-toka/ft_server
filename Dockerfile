FROM debian:buster

LABEL maintainer="sedric@student.21-school.ru"

RUN apt-get update

# install all services
RUN apt-get install -y \
vim \
nginx \
net-tools \
mariadb-server \
wget zip \
curl \
php7.3-fpm php7.3-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc

# get wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -zxvf latest.tar.gz

#get phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.zip

# create SSL
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 \
-nodes -out /etc/ssl/localhost.crt -keyout /etc/ssl/localhost.key \
-subj "/C=RU/ST=21school/L=21school/O=sedric/CN=www.server_sedric.com"

COPY  ./srcs/start.sh /
COPY  ./srcs/nginx_config /etc/nginx/sites-available/default
COPY  ./srcs/index.sh /

RUN chmod +x *.sh

CMD ./start.sh
