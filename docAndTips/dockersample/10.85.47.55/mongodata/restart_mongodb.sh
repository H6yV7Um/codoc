#!/bin/bash

workdir=/data0/mongodata


cd $workdir


if [[ `docker ps -af name=mongodb27017 | wc -l` == 2 ]]; then
	docker stop mongodb27017 && docker rm mongodb27017 && docker run --name mongodb27017 \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/mongodata/data/port27017:/data/db \
	-d hd-mongodb:v1 mongod --replSet z
else
	docker run --name mongodb27017 \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/mongodata/data/port27017:/data/db \
        -d hd-mongodb:v1 mongod --replSet z
fi

