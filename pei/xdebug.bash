PHP_MODULE_PATH=php-$(echo "<?= PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION ?>"|php7)

curl -sLo /usr/lib/php7/modules/xdebug.so "http://files.docker.genee.in/alpine/${PHP_MODULE_PATH}/xdebug.so" \
    && printf "zend_extension=xdebug.so\n" > /etc/php7/conf.d/00_xdebug.ini
