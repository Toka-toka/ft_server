#! /bin/bash

var1=$(grep -c 'autoindex on' /etc/nginx/sites-available/default)
echo -e "\n- - - - - - - - - - - - - - - - - - - - - -"
if [ $var1 -eq 1 ]
then
	echo -e "Autoindex disabled. To enable use ./index.sh"
	sed -i "s/autoindex on/autoindex off/" /etc/nginx/sites-available/default
else
	echo -e "Autoindex enabled. To disable use ./index.sh"
	sed -i "s/autoindex off/autoindex on/" /etc/nginx/sites-available/default
fi
echo -e "- - - - - - - - - - - - - - - - - - - - - - \n"
service nginx restart