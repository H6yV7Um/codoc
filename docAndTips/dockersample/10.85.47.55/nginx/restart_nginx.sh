#!/bin/bash


if [[ `docker ps -af name=wbcsc_nginx | wc -l` == 2 ]]; then
docker stop wbcsc_nginx && docker rm wbcsc_nginx && docker run --name wbcsc_nginx \
--net=host \
-v /etc/localtime:/etc/localtime:ro \
-v /data0/nginx/nginx.conf:/etc/nginx/nginx.conf \
-v /data0/nginx/vhost:/etc/nginx/conf.d \
-v /data1/www/htdocs/jy.mydomain.com:/var/www/html/jy.mydomain.com \
-v /data0/z/dfs:/var/www/html/dfs \
-v /data1/www/logs:/var/log/nginx \
-d hd-nginx:v1
else
docker run --name wbcsc_nginx \
--net=host \
-v /etc/localtime:/etc/localtime:ro \
-v /data0/nginx/nginx.conf:/etc/nginx/nginx.conf \
-v /data0/nginx/vhost:/etc/nginx/conf.d \
-v /data1/www/htdocs/jy.mydomain.com:/var/www/html/jy.mydomain.com \
-v /data0/z/dfs:/var/www/html/dfs \
-v /data1/www/logs:/var/log/nginx \
-d hd-nginx:v1

fi


