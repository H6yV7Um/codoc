#!/bin/bash

workdir=/data0/redisdata

cd $workdir


if [[ `docker ps -af name=redisMaster6379 | wc -l` == 2 ]]; then
	docker stop redisMaster6379 && docker rm redisMaster6379 && docker run --name redisMaster6379 \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/redisdata/conf/master6379.conf:/usr/local/etc/redis.conf \
	-v /data0/redisdata/data/master6379:/data \
	-d hd-redis:v1 redis-server /usr/local/etc/redis.conf
else
	docker run --name redisMaster6379 \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/redisdata/conf/master6379.conf:/usr/local/etc/redis.conf \
        -v /data0/redisdata/data/master6379:/data \
        -d hd-redis:v1 redis-server /usr/local/etc/redis.conf

fi




if [[ `docker ps -af name=redisSentinel26379 | wc -l` == 2 ]]; then
	docker stop redisSentinel26379 && docker rm redisSentinel26379 && docker run --name redisSentinel26379 \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/redisdata/conf/sentinel26379.conf:/usr/local/etc/redis/sentinel.conf \
	-v /data0/redisdata/data/sentinel26379:/data \
	-d hd-redis:v1 redis-sentinel /usr/local/etc/redis/sentinel.conf
else
	docker run --name redisSentinel26379 \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/redisdata/conf/sentinel26379.conf:/usr/local/etc/redis/sentinel.conf \
        -v /data0/redisdata/data/sentinel26379:/data \
        -d hd-redis:v1 redis-sentinel /usr/local/etc/redis/sentinel.conf
fi




if [[ `docker ps -af name=redisSlave6381_to_55 | wc -l` == 2 ]]; then
	docker stop redisSlave6381_to_55 && docker rm redisSlave6381_to_55 && docker run --name redisSlave6381_to_55 \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/redisdata/conf/slave6381_to_55.conf:/usr/local/etc/redis.conf \
	-v /data0/redisdata/data/slave6381_to_55:/data \
	-d hd-redis:v1 redis-server /usr/local/etc/redis.conf
else
	docker run --name redisSlave6381_to_55 \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/redisdata/conf/slave6381_to_55.conf:/usr/local/etc/redis.conf \
        -v /data0/redisdata/data/slave6381_to_55:/data \
        -d hd-redis:v1 redis-server /usr/local/etc/redis.conf
fi


