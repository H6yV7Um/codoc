#!/bin/bash

time=`date "+%Y-%m-%d %H:%M:%S"`
MAILFILE=/root/crontab-tasks/mail_content
MAIL_SUBMIT=http://all.vic.sina.com.cn/wbframework/space_check.php
has_warnning=0
SEND_AFTER_TIME=3600
MEM_LIMIT=50
CPU_LIMIT=90
DISK_LIMIT=90
SERVER_NAME=10.13.130.23

###################################### disk status ###############################
DISKFILE=/dev/vda1
declare -i disk_ratio=`df | grep "${DISKFILE}" | awk '{print $5}' | cut -f 1 -d '%'`
if [ $disk_ratio -gt $DISK_LIMIT ]; then
	echo '' > /var/log/recorD.log
	echo '' > /var/log/metad/message.log

	disk_ratio=`df | grep "${DISKFILE}" | awk '{print $5}' | cut -f 1 -d '%'`
	if [ $disk_ratio -gt $DISK_LIMIT ]; then
        	if [ $has_warnning -eq 0 ]; then
                	echo "$time" >> $MAILFILE
	                echo "[$SERVER_NAME]" >> $MAILFILE
        	        echo "<br>" >> $MAILFILE
                	has_warnning=1
	        fi
		echo "$DISKFILE[${disk_ratio}%], >${DISK_LIMIT}%" >> $MAILFILE
		echo "<br>" >> $MAILFILE	
	fi
fi

###################################### process status #############################
ps aux | awk '$3>"'$CPU_LIMIT'" || $4>"'$MEM_LIMIT'"'| while read -r line; do
	pid=`echo $line | awk '{print $2}'`
	declare -i cup_ratio=`echo $line | awk '{print $3}' | cut -f 1 -d '.'`
	declare -i mem_ratio=`echo $line | awk '{print $4}' | cut -f 1 -d '.'`
	cmd=`echo $line | awk '{for (i=11;i<=NF;i++)printf("%s ", $i);print ""}'`
	#cmd=`echo $line | awk '{print $11}'`

	if [ $cup_ratio -gt $CPU_LIMIT ]; then
        	if [ $has_warnning -eq 0 ]; then
                	echo "$time " >> $MAILFILE
			echo "[$SERVER_NAME]" >> $MAILFILE
			echo "<br>" >> $MAILFILE
        	        has_warnning=1
	        fi
        	echo "CPU[${cup_ratio}%], >${CPU_LIMIT}%, process[${pid}], cmd[${cmd}]" >>  $MAILFILE
		echo "<br>" >> $MAILFILE
	fi

	if [ $mem_ratio -gt $MEM_LIMIT ]; then
        	if [ $has_warnning -eq 0 ]; then
                	echo "$time" >> $MAILFILE
			echo "[$SERVER_NAME]" >> $MAILFILE
			echo "<br>" >> $MAILFILE
        	        has_warnning=1
	        fi
        	echo "MEM[${mem_ratio}%], >${MEM_LIMIT}%, process[${pid}], cmd[${cmd}]" >>  $MAILFILE
		echo "<br>" >> $MAILFILE
	fi
done


if [ $has_warnning -ne 0 ]; then
        echo "<br><br>" >> $MAILFILE
fi

if [ -e $MAILFILE ]; then
	MAIL_FIRST_LINE=`head -1 $MAILFILE`
	lasttime=`date +%s -d "$MAIL_FIRST_LINE"`
	curtime=`date +%s -d "$time"`
	diff=`expr $curtime - $lasttime`
	if [ $diff -gt $SEND_AFTER_TIME ]; then
        	mail_content=`cat  $MAILFILE`
		curl --data-urlencode "test_mail=xiangguang@staff.weibo.com" --data-urlencode "receive_body=$mail_content" $MAIL_SUBMIT 
	 	rm -f $MAILFILE
	fi	
fi

