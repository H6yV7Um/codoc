#!/bin/bash


if [[ `docker ps -af name=wbcsc_nginx | wc -l` == 2 ]]; then
docker stop wbcsc_nginx && docker rm wbcsc_nginx && docker run --name wbcsc_nginx \
--net=host \
-v /etc/localtime:/etc/localtime:ro \
-v /data0/nginx/nginx.conf:/etc/nginx/nginx.conf \
-v /data0/nginx/vhost:/etc/nginx/conf.d \
-v /data1/www/cache:/data1/www/cache:rw \
-v /data1/www/htdocs:/var/www/html \
-v /data1/www/logs:/var/log/nginx \
-d hd-nginx:v1
else
docker run --name wbcsc_nginx \
--net=host \
-v /etc/localtime:/etc/localtime:ro \
-v /data0/nginx/nginx.conf:/etc/nginx/nginx.conf \
-v /data0/nginx/vhost:/etc/nginx/conf.d \
-v /data1/www/cache:/data1/www/cache:rw \
-v /data1/www/htdocs:/var/www/html \
-v /data1/www/logs:/var/log/nginx \
-d hd-nginx:v1
fi


