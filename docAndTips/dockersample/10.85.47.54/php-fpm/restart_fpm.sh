#!/bin/bash


if [[ `docker ps -af name=wbcsc_fpm | wc -l` == 2 ]]; then
docker stop wbcsc_fpm && docker rm wbcsc_fpm && docker run --name wbcsc_fpm \
--net=host \
-v /etc/localtime:/etc/localtime:ro \
-v /data0/php-fpm/php-fpm.conf:/usr/local/etc/php-fpm.conf \
-v /data0/php-fpm/php-fpm.d:/usr/local/etc/php-fpm.d \
-v /data0/php-fpm/wbcsc-php.ini:/usr/local/etc/php/conf.d/wbcsc-php.ini \
-v /data1/www/cache:/data1/www/cache:rw \
-v /data1/www/htdocs:/var/www/html \
-v /data1/www/logs/fpm:/data/logs \
-d hd-fpm:v5 php-fpm
else
docker run --name wbcsc_fpm \
--net=host \
-v /etc/localtime:/etc/localtime:ro \
-v /data0/php-fpm/php-fpm.conf:/usr/local/etc/php-fpm.conf \
-v /data0/php-fpm/php-fpm.d:/usr/local/etc/php-fpm.d \
-v /data0/php-fpm/wbcsc-php.ini:/usr/local/etc/php/conf.d/wbcsc-php.ini \
-v /data1/www/cache:/data1/www/cache:rw \
-v /data1/www/htdocs:/var/www/html \
-v /data1/www/logs/fpm:/data/logs \
-d hd-fpm:v5 php-fpm

fi

