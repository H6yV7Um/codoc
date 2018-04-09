#!/bin/bash

workdir=/data0/z
cd $workdir

pkg_time=`date +%Y%m%d`
tarfile=/home/xiangguang/online_8u151_${pkg_time}.tar

if [[ $# > 1 ]]; then
        tarfile=$1
fi

if [[ ! -f $tarfile ]]; then
        echo "File ${tarfile} Doesn't exist!! "
	exit
fi


rm -rf buildresult
tar xvf $tarfile


bak_time=`date +%Y%m%d%H%M`

mv src/jobLib src/jobLib_bak_${bak_time}
mv /data1/www/htdocs/jy.mydomain.com/jobs /data1/www/htdocs/jy.mydomain.com/jobs_bak_${bak_time}


cp -rf buildresult/online_8u151/jobLib/ src/

mkdir -p /data1/www/htdocs/jy.mydomain.com/jobs
cp -rf  buildresult/online_8u151/jobLib/* /data1/www/htdocs/jy.mydomain.com/jobs/





if [[ `docker ps -af name=snap1 | wc -l` == 2 ]]; then
	docker stop snap1 && docker rm snap1 && docker run --name snap1 \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/z/snaplogs/snap8020:/usr/local/tomcat \
	-v /data0/z/src/jobLib:/usr/local/joblib \
	-v /data0/z/conf/snap8020.conf:/etc/supervisor/conf.d/supervisord.conf \
	-d hd-java8u151_tomcat_xvfb_spvr:v1
else
	docker run --name snap1 \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/z/snaplogs/snap8020:/usr/local/tomcat \
        -v /data0/z/src/jobLib:/usr/local/joblib \
        -v /data0/z/conf/snap8020.conf:/etc/supervisor/conf.d/supervisord.conf \
        -d hd-java8u151_tomcat_xvfb_spvr:v1

fi


if [[ `docker ps -af name=snap2 | wc -l` == 2 ]]; then
	docker stop snap2 && docker rm snap2 && docker run --name snap2 \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/z/snaplogs/snap8030:/usr/local/tomcat \
	-v /data0/z/src/jobLib:/usr/local/joblib \
	-v /data0/z/conf/snap8030.conf:/etc/supervisor/conf.d/supervisord.conf \
	-d hd-java8u151_tomcat_xvfb_spvr:v1
else
	docker run --name snap2 \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/z/snaplogs/snap8030:/usr/local/tomcat \
        -v /data0/z/src/jobLib:/usr/local/joblib \
        -v /data0/z/conf/snap8030.conf:/etc/supervisor/conf.d/supervisord.conf \
        -d hd-java8u151_tomcat_xvfb_spvr:v1
fi


if [[ `docker ps -af name=jy_dfs | wc -l` == 2 ]]; then
	docker stop jy_dfs && docker rm jy_dfs && docker run --name jy_dfs \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/z/dfs:/usr/local/tomcat/dfs \
	-v /data0/z/src/jobLib:/usr/local/joblib \
	-d hd-tomcat:v1  \
	java -cp classes:/usr/local/joblib/* com.sina.z.job.ZDfsServer /usr/local/tomcat/dfs 10.85.47.55 8060 10.85.47.54/16 8061
else
	docker run --name jy_dfs \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/z/dfs:/usr/local/tomcat/dfs \
        -v /data0/z/src/jobLib:/usr/local/joblib \
        -d hd-tomcat:v1  \
        java -cp classes:/usr/local/joblib/* com.sina.z.job.ZDfsServer /usr/local/tomcat/dfs 10.85.47.55 8060 10.85.47.54/16 8061
fi

