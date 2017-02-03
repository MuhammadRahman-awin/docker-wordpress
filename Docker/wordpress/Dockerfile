FROM wordpress:4.7.2-php7.0-apache

# ca-certificates is required to download from github
RUN apt-get -yq update \
    && apt-get install --assume-yes --no-install-recommends \
    rsync vim

#change working directory to plugin
WORKDIR /var/www/html/

#copy the files into the plugin
COPY . /var/www/html/wp-content/plugins/
COPY Docker/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
