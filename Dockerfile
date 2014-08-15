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

EXPOSE 9000
EXPOSE 80

CMD ["/usr/sbin/php5-fpm", "--nodaemonize", "--fpm-config", "/etc/php5/fpm/php-fpm.conf"]
