FROM ubuntu

LABEL maintainer="Chris Wiegman <contact@chriswiegman.com>"

ENV DEBIAN_FRONTEND noninteractive

ENV TTRSS_VERSION="19.2"

RUN  apt-get update && \
     apt-get install -yy software-properties-common && \
     add-apt-repository ppa:ondrej/php -y && \
     apt-get update \
     && apt-get install -yy \
            apache2 \
            libapache2-mod-php \
            php7.3-gd \
            php7.3-curl \
            php7.3-mysql \
            php7.3-mbstring \
            php7.3-pgsql \
            php7.3-xml \
            php7.3-imagick \
            wget \
            unzip \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD php.ini /etc/php/7.3/apache2/php.ini

ADD entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ADD ttrss.conf /etc/init.d/ttrss
RUN chmod +x /etc/init.d/ttrss

ENTRYPOINT /entrypoint.sh
EXPOSE 80

RUN apt-get autoremove --purge -y
