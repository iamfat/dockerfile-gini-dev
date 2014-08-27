Docker Hub: iamfat/gini-dev
===========

## Gini Dev Environment (PHPUnit + Gini + Composer + PHP5.5)
```bash
docker build -t iamfat/gini-dev gini-dev

export BASE_DIR=/mnt/sda1/data
docker run --name gini-dev --privileged \
    -v /dev/log:/dev/log -v $BASE_DIR:/data \
    --link mysql:mysql --link redis:redis \
    -d iamfat/gini-dev
```
