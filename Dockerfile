FROM genee/gini
MAINTAINER maintain@geneegroup.com

ENV DEBIAN_FRONTEND noninteractive

# Install bash-completion and vim for easier use
RUN apt-get update && apt-get install -y procps bash-completion vim

# Install XDebug
RUN apt-get install -y php5-xdebug

# Install test-helpers
RUN curl -sLo /usr/lib/php5/20121212/test_helpers.so http://d.genee.cn/packages/test_helpers.so && \
    printf "; priority=99\nzend_extension=test_helpers.so" > /etc/php5/mods-available/test_helpers.ini && \
    php5enmod test_helpers

# Install PHPUnit and PHP-CS-Fixer
RUN composer global require -q --prefer-dist 'phpunit/phpunit:@stable' 'fabpot/php-cs-fixer:@stable'

# Install "git-up"
RUN apt-get install -y python-pip && pip install git-up

# Install "git-extras"
RUN apt-get install -y bsdmainutils && \
    (git clone --depth 1 https://github.com/visionmedia/git-extras.git && make -C git-extras install && rm -rf git-extras)

# Install SonarQube Runner
RUN apt-get install -y unzip openjdk-7-jre-headless && \
    curl -sLo sonar-runner-dist-2.4.zip \
        http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip && \
    unzip sonar-runner-dist-2.4.zip -d /tmp && rm sonar-runner-dist-2.4.zip && \
    mv /tmp/sonar-runner-2.4 /usr/local/share/sonar-runner && \
    echo 'export PATH="/usr/local/share/sonar-runner/bin:$PATH"' >> /etc/profile.d/sonar-runner.sh

# Set ENV to "development"
RUN echo "export GINI_ENV=development">/etc/profile.d/gini.sh
