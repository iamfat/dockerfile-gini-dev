FROM genee/gini:alpine
MAINTAINER Jia Huang <iamfat@gmail.com>

ENV GINI_ENV=development \
    SONAR_RUNNER_VERSION=3.0.1.733

# Install less and bash-completion and vim for easier use
RUN apk add --no-cache less bash bash-completion vim

# Install XDebug
RUN curl -sLo /usr/lib/php7/modules/xdebug.so http://files.docker.genee.in/php7/xdebug.so && \
    echo "zend_extension=xdebug.so" > /etc/php7/conf.d/xdebug.ini

# Install uopz
RUN curl -sLo /usr/lib/php7/modules/uopz.so http://files.docker.genee.in/php7/uopz.so && \
    printf "; priority=99\nzend_extension=uopz.so" > /etc/php7/conf.d/uopz.ini

# Install PHPUnit and PHP-CS-Fixer
RUN composer global require -q --prefer-dist 'phpunit/phpunit:@stable' 'fabpot/php-cs-fixer:@stable'

# Install "git-up"
RUN apk add --no-cache py-pip && \
    pip install -U pip && pip install git-up && \
    apk del py-pip

# Install SonarQube Runner
RUN apk add --no-cache unzip openjdk8-jre && \
    curl -sLo sonar-scanner-cli-${SONAR_RUNNER_VERSION}.zip \
        https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_RUNNER_VERSION}-linux.zip \
    && unzip sonar-scanner-cli-${SONAR_RUNNER_VERSION}.zip -d /tmp \
    && rm sonar-scanner-cli-${SONAR_RUNNER_VERSION}.zip \
    && mv /tmp/sonar-scanner-cli-${SONAR_RUNNER_VERSION} /usr/local/share/sonar-scanner-cli && \
    echo 'export PATH="/usr/local/share/sonar-scanner-cli/bin:$PATH"' >> /etc/profile.d/sonar-scanner.sh