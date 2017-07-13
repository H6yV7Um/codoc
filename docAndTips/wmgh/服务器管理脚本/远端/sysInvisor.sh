#!/bin/bash

time=`date "+%Y-%m-%d %H:%M:%S"`
echo $time > /var/tmp/mail_content.txt 
is_abnormal=0
###################################### disk status ###############################
system_disk=`df | grep /dev/hda1 | awk '{print $5}' | cut -f 1 -d '%'`
if (( $system_disk > 70 ))
then
	is_abnormal=1
	echo "系统分区的空间已使用${system_disk}%，请及时处理 ;" >> /var/tmp/mail_content.txt
fi

data_disk=`df | grep /dev/xvdb1 | awk '{print $5}' | cut -f 1 -d "%"`
if (( $data_disk > 85 ))
then
	is_abnormal=1
        echo "数据分区的空间已使用${data_disk}%, 请及时处理 ;"  >> /var/tmp/mail_content.txt
fi


###################################### process status #############################

ps aux | awk '$3>50||$4>40{print $2, $3, $4, $11}'|
while read -r line
do

pid=`echo $line | awk '{print $1}'`
declare -i cup_usage=`echo $line | awk '{print $2}' | cut -f 1 -d '.'`
declare -i mem_usage=`echo $line | awk '{print $3}' | cut -f 1 -d '.'`
cmd=`echo $line | awk '{print $4}'`


if (( ${cup_usage} > 50 ))
then
	is_abnormal=1
        echo "进程[${pid}][${cmd}]CPU占用率${cup_usage}% ;" >> /var/tmp/mail_content.txt
fi


if (( ${mem_usage} > 40 ))
then
	is_abnormal=1
        echo "进程[${pid}][${cmd}]内存占用率${mem_usage}% ; " >> /var/tmp/mail_content.txt
fi


done 


if (( ${is_abnormal} == 1 ))
then
	mail -s "System Abnormal Report" sysAdmin -- -f system@iwmgh.com < /var/tmp/mail_content.txt
fi
rm -f /var/tmp/mail_content.txt


#echo $content | mail -s "服务器异常报告" 258468201@qq.com -- -f system@iwmgh.com

