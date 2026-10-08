# Hackademic ships no Dockerfile (upstream: copy the source into a LAMP web root, then run the
# install wizard at /installation/install.php). This image does that on PHP 5.6 with Apache (its
# Smarty 3.1.8 predates PHP 7): the source from app/ goes to /var/www/html/, writable by Apache as
# upstream's chmod asks, and the command first starts install.sh in the background, which runs
# upstream's install wizard once (admin / hackademic, database on the db machine) so the lab
# starts ready.
FROM docker.io/library/php:5.6-apache

RUN docker-php-ext-install pdo_mysql mysqli \
 && printf 'date.timezone = UTC\n' > /usr/local/etc/php/conf.d/hackademic.ini

COPY --chown=www-data:www-data app/ /var/www/html/
RUN mkdir -p /var/www/html/view/compiled_view && chown -R www-data:www-data /var/www/html

COPY install.sh /usr/local/bin/hackademic-install
CMD ["sh", "-c", "sh /usr/local/bin/hackademic-install & exec apache2-foreground"]
