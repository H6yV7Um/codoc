#!/bin/bash

workdir=/data0/z
cd $workdir

pkg_time=`date +%Y%m%d`
tarfile=/home/zxg/online_8u151_${pkg_time}.tar

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

mv src/nginxHtml src/nginxHtml_bak_${bak_time}
mv src/tomcatROOT src/tomcatROOT_bak_${bak_time}


mv /data1/www/htdocs/jy.mydomain.com/ng_docs /data1/www/htdocs/jy.mydomain.com/ng_docs_bak_${bak_time}
mv /data1/www/htdocs/jy.mydomain.com/tomcat_docs /data1/www/htdocs/jy.mydomain.com/tomcat_docs_bak_${bak_time}


cp -rf buildresult/online_8u151/nginxHtml/ src/
cp -rf buildresult/online_8u151/tomcatROOT/ src/


mkdir -p /data1/www/htdocs/jy.mydomain.com/ng_docs
cp -rf buildresult/online_8u151/nginxHtml/* /data1/www/htdocs/jy.mydomain.com/ng_docs/

mkdir -p /data1/www/htdocs/jy.mydomain.com/tomcat_docs
cp -rf buildresult/online_8u151/tomcatROOT/* /data1/www/htdocs/jy.mydomain.com/tomcat_docs/


if [[ `docker ps -af name=jy_tomcat | wc -l` == 2 ]]; then
	docker stop jy_tomcat && docker rm jy_tomcat && docker run --name jy_tomcat \
	--net=host \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data0/z/src/tomcatROOT:/usr/local/tomcat/webapps/ROOT \
	-v /data0/z/dfs:/data0/z/dfs \
	-v /etc/hosts:/etc/hosts \
	-v /data0/z/logs:/usr/local/tomcat/logs \
	-d hd-tomcat:v1 
else
	docker run --name jy_tomcat \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /data0/z/src/tomcatROOT:/usr/local/tomcat/webapps/ROOT \
        -v /data0/z/dfs:/data0/z/dfs \
        -v /etc/hosts:/etc/hosts \
        -v /data0/z/logs:/usr/local/tomcat/logs \
        -d hd-tomcat:v1
fi





#docker stop jy_nginx && docker rm jy_nginx && docker run --name jy_nginx \
#	--net=host \
#	-v /etc/localtime:/etc/localtime:ro \
#	-v /data0/nginxdata/conf/jy.conf:/etc/nginx/nginx.conf \
#	-v /data0/nginxdata/logs:/var/log/nginx \
#	-v /data0/nginxdata/default_root:/usr/share/nginx/html \
#	-v /data0/z/src/nginxHtml:/var/www/html \
#	-v /data0/z/dfs:/var/www/html/dfs \
#	-d hd-nginx:v1







