FROM genee/gini:alpine
MAINTAINER Jia Huang <iamfat@gmail.com>

ENV GINI_ENV=development \
    SONAR_RUNNER_VERSION=2.9.0.887

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
    curl -sLo sonar-runner-${SONAR_RUNNER_VERSION}.zip \
        https://github.com/SonarSource/sonar-scanner-api/archive/${SONAR_RUNNER_VERSION}.zip \
    && unzip sonar-runner-${SONAR_RUNNER_VERSION}.zip -d /tmp \
    && rm sonar-runner-${SONAR_RUNNER_VERSION}.zip \
    && mv /tmp/sonar-runner-${SONAR_RUNNER_VERSION} /usr/local/share/sonar-runner && \
    echo 'export PATH="/usr/local/share/sonar-runner/bin:$PATH"' >> /etc/profile.d/sonar-runner.sh