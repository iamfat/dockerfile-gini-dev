Docker Hub: iamfat/gini-dev
===========

## Gini Dev Environment (PHPUnit + Gini + Composer + PHP5.5 + Nginx + SSH)
```bash
docker build -t iamfat/gini-dev gini-dev

docker run --name gini-dev -v /dev/log:/dev/log -v /data:/data --privileged \
    -v /data/config/sites:/etc/nginx/sites-enabled \
    -v /data/logs/nginx:/var/log/nginx \
    -p 80:80 \
    -d iamfat/gini-dev
```
