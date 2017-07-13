#!/bin/bash


time=$(date -d 'today' +%Y-%m-%d_%H:%M:%S)
mv /alidata/log/alipay/apayLog.txt /alidata/log/alipay/apayLog_${time}.txt
mv /alidata/log/php/php-error /alidata/log/php/php-error_${time}


################################################################################
################## reserve the latest 20 apache log files #######################
################################################################################


declare -i reservelines=20;
logdir=/alidata/log/httpd


cd ${logdir}

for i in *
do
    if [ -d $logdir/$i ];then

        declare -i filesum=`ls $logdir/$i/access_log_* | wc -l`
        declare -i delnum=$filesum-reservelines

        if [ "${delnum}" -ge 1 ];then
                rm -rf `ls -tr $logdir/$i/access_log_* | head -${delnum}`
        fi

        declare -i filesum=`ls $logdir/$i/error_log_* | wc -l`
        declare -i delnum=$filesum-reservelines
        if [ "${delnum}" -ge 1 ];then
                rm -rf `ls -tr $logdir/$i/error_log_* | head -${delnum}`
        fi

    fi

done


