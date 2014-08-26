FROM iamfat/gini
MAINTAINER maintain@geneegroup.com

ENV DEBIAN_FRONTEND noninteractive

# Install bash-completion and vim for easier use
RUN apt-get install -y bash-completion vim

# Install XDebug
RUN apt-get install -y php5-xdebug

# Install test-helpers
ADD test_helpers.so /usr/lib/php5/20121212/test_helpers.so
RUN echo "zend_extension=test_helpers.so" > /etc/php5/mods-available/test_helpers.ini && \
    php5enmod test_helpers

# Install PHPUnit and PHP-CS-Fixer
RUN composer global require 'phpunit/phpunit:@stable' 'fabpot/php-cs-fixer:@stable' --prefer-dist

# Install "git-extras"
RUN apt-get install -y bsdmainutils && \
    (cd /tmp && git clone --depth 1 https://github.com/visionmedia/git-extras.git && cd git-extras && sudo make install)

# Install "git-up"
RUN apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev && \
    (curl -sL https://get.rvm.io | bash -s stable) && \
    /bin/bash -c "source /etc/profile.d/rvm.sh && \
        rvm --quiet-curl install 2.1.2 && rvm use 2.1.2 --default && gem install git-up"

EXPOSE 9000

CMD ["/usr/sbin/php5-fpm", "--nodaemonize", "--fpm-config", "/etc/php5/fpm/php-fpm.conf"]
