#!/bin/bash

workdir=/data0/redisdata

cd $workdir



if [[ `docker ps -af name=redisSlave6382_to_54 | wc -l` == 2 ]]; then
	docker stop redisSlave6382_to_54 && docker rm redisSlave6382_to_54 && docker run --name redisSlave6382_to_54 \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/redisdata/conf/slave6382_to_54.conf:/usr/local/etc/redis.conf \
	-v /data0/redisdata/data/slave6382_to_54:/data  \
	-d hd-redis:v1 redis-server /usr/local/etc/redis.conf
else
	docker run --name redisSlave6382_to_54 \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/redisdata/conf/slave6382_to_54.conf:/usr/local/etc/redis.conf \
        -v /data0/redisdata/data/slave6382_to_54:/data  \
        -d hd-redis:v1 redis-server /usr/local/etc/redis.conf
fi




if [[ `docker ps -af name=redisSlave6383_to_55 | wc -l` == 2 ]]; then
	docker stop redisSlave6383_to_55 && docker rm redisSlave6383_to_55 && docker run --name redisSlave6383_to_55 \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/redisdata/conf/slave6383_to_55.conf:/usr/local/etc/redis.conf \
	-v /data0/redisdata/data/slave6383_to_55:/data  \
	-d hd-redis:v1 redis-server /usr/local/etc/redis.conf
else
	docker run --name redisSlave6383_to_55 \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/redisdata/conf/slave6383_to_55.conf:/usr/local/etc/redis.conf \
        -v /data0/redisdata/data/slave6383_to_55:/data  \
        -d hd-redis:v1 redis-server /usr/local/etc/redis.conf
fi
