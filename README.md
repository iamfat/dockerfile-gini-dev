Docker Hub: iamfat/gini-dev
===========

## Gini Dev Environment (PHPUnit + Gini + Composer + PHP5.5 + Nginx + SSH)
```bash
docker build -t iamfat/gini-dev gini-dev

export BASE_DIR=/mnt/sda1/data
docker run --name gini-dev -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/etc/nginx/sites-enabled:/etc/nginx/sites-enabled \
    -v $BASE_DIR/log/nginx:/var/log/nginx \
    --link mysql:mysql --link redis:redis \
    -p 80:80 \
    -d iamfat/gini-dev
```
