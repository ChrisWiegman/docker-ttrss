#!/bin/bash

if [ ! -f /var/www/config.php ]; then
	wget -q https://git.tt-rss.org/fox/tt-rss/archive/${TTRSS_VERSION}.tar.gz -O - | tar xzf - -C /var/www --strip-components=1
fi

chown -R www-data:www-data /var/www

mkdir -pv /config/php/apache2.d
find /config/php/apache2.d -type f | while read file; do
	ln -svf "${file}" "/etc/php/7.0/apache2/conf.d/$(basename "${file}")";
done;

sed -i "s/\/var\/www\/html/\/var\/www/g"  /etc/apache2/sites-enabled/000-default.conf

service ttrss start

source /etc/apache2/envvars
apache2ctl -D FOREGROUND