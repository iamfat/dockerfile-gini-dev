Docker Hub: genee/gini-dev
===========

## Gini Dev Environment (PHPUnit + Gini + Composer + PHP5.5)
```bash

docker run --name gini-dev -v /dev/log:/dev/log -v /path/to/data:/data -d genee/gini-dev

# run sonar-runner
sonar-runner -D sonar.host.url=http://172.17.42.1:9000 -D sonar.jdbc.url="jdbc:mysql://mysql:3306/sonar?useUnicode=true&characterEncoding=utf8" -D sonar.jdbc.username=genee -D sonar.jdbc.password=83719730

sonar-runner -D sonar.host.url=http://172.17.42.1:9000 -D sonar.jdbc.url="jdbc:mysql://172.17.42.1:6306/sonar?useUnicode=true&characterEncoding=utf8" -D sonar.jdbc.username=genee -D sonar.jdbc.password=83719730
```
