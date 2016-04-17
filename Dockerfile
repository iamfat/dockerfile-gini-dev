FROM genee/gini:alpine
MAINTAINER Jia Huang <iamfat@gmail.com>

ENV GINI_ENV development

# Install less and bash-completion and vim for easier use
RUN apk add --no-cache less bash bash-completion vim

# Install XDebug
RUN curl -sLo /usr/lib/php/modules/xdebug.so http://files.docker.genee.in/php5/xdebug.so && \
    echo "zend_extension=xdebug.so" > /etc/php/conf.d/xdebug.ini

# Install uopz
RUN curl -sLo /usr/lib/php/modules/uopz.so http://files.docker.genee.in/php5/uopz.so && \
    printf "; priority=99\nzend_extension=uopz.so" > /etc/php/conf.d/uopz.ini

# Install PHPUnit and PHP-CS-Fixer
RUN composer global require -q --prefer-dist 'phpunit/phpunit:@stable' 'fabpot/php-cs-fixer:@stable'

# Install "git-up"
RUN apk add --no-cache py-pip && \
    pip install -U pip && pip install git-up && \
    apk del py-pip

# Install SonarQube Runner
RUN apk add --no-cache unzip openjdk7-jre && \
    curl -sLo sonar-runner-dist-2.4.zip \
        http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip && \
    unzip sonar-runner-dist-2.4.zip -d /tmp && rm sonar-runner-dist-2.4.zip && \
    mv /tmp/sonar-runner-2.4 /usr/local/share/sonar-runner && \
    echo 'export PATH="/usr/local/share/sonar-runner/bin:$PATH"' >> /etc/profile.d/sonar-runner.sh