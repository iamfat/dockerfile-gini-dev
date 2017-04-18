FROM genee/gini:alpine
MAINTAINER Jia Huang <iamfat@gmail.com>

ENV GINI_ENV=development \
    SONAR_RUNNER_VERSION=3.0.1.733

# Install less and bash-completion and vim for easier use
RUN apk add --no-cache less bash bash-completion vim

# Install XDebug
RUN curl -sLo /usr/lib/php7/modules/xdebug.so http://files.docker.genee.in/php7/xdebug.so && \
    echo "zend_extension=xdebug.so" > /etc/php7/conf.d/xdebug.ini

# Install PHPUnit and PHP-CS-Fixer
RUN composer global require -q --prefer-dist 'phpunit/phpunit:@stable' 'fabpot/php-cs-fixer:@stable'

# Install "git-up"
RUN apk add --no-cache py-pip && \
    pip install -U pip && pip install git-up && \
    apk del py-pip

# Install SonarQube Runner
RUN apk add --no-cache unzip openjdk8-jre && \
    curl -skLo /tmp/sonar-scanner-${SONAR_RUNNER_VERSION}.zip \
        https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_RUNNER_VERSION}.zip \
    && unzip /tmp/sonar-scanner-${SONAR_RUNNER_VERSION}.zip -d /tmp \
    && rm /tmp/sonar-scanner-${SONAR_RUNNER_VERSION}.zip \
    && mv /tmp/sonar-scanner-${SONAR_RUNNER_VERSION} /usr/local/share/sonar-scanner && \
    echo 'export PATH="/usr/local/share/sonar-scanner/bin:$PATH"' >> /etc/profile.d/sonar-scanner.sh
