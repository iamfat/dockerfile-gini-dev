Docker Hub: genee/gini-dev
===========

## Gini Dev Environment (PHPUnit + Gini + Composer + PHP5.5)
```bash
docker build -t iamfat/gini-dev dockerfile-gini-dev

export BASE_DIR=/mnt/sda1/data
docker run --name gini-dev --privileged \
    -v /dev/log:/dev/log -v $BASE_DIR:/data \
    --link mysql:mysql --link redis:redis \
    -d iamfat/gini-dev

docker run --name gini --privileged -v /usr/local/share/gini-modules:/usr/local/share/gini-modules -v /dev/log:/dev/log -p 127.0.0.1:9000:9000 -d iamfat/gini
# run sonar-runner
sonar-runner -D sonar.host.url=http://172.17.42.1:9000 -D sonar.jdbc.url="jdbc:mysql://mysql:3306/sonar?useUnicode=true&characterEncoding=utf8" -D sonar.jdbc.username=genee -D sonar.jdbc.password=83719730

sonar-runner -D sonar.host.url=http://172.17.42.1:9000 -D sonar.jdbc.url="jdbc:mysql://172.17.42.1:6306/sonar?useUnicode=true&characterEncoding=utf8" -D sonar.jdbc.username=genee -D sonar.jdbc.password=83719730
```
