FROM iamfat/gini
MAINTAINER maintain@geneegroup.com

# Install XDebug
RUN apt-get install -y php5-xdebug

# Install test-helpers
ADD test_helpers.so /usr/lib/php5/20121212/test_helpers.so
RUN echo "zend_extension=test_helpers.so" > /etc/php5/mods-available/test_helpers.ini && \
    php5enmod test_helpers

# Install PHPUnit and PHP-CS-Fixer
RUN composer global require 'phpunit/phpunit:@stable' 'fabpot/php-cs-fixer:@stable' --prefer-dist

# Make sure /var/lib/php5 accessible for php5-fpm
RUN chmod a+wt,go-r /var/lib/php5

# VOLUME ["/data", "/var/log/supervisor", "/etc/nginx/sites-enabled", "/var/log/nginx"]

EXPOSE 9000
EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]
