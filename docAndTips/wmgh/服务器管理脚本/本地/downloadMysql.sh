#!/bin/bash

isMonday=`date | grep 'Mon'|wc -l`
fileName=`date +%Y%m%d_*.sql.gz`
logFile=`date +%Y%m%d.log`
cd /backup/mysql

if [ "${isMonday}" == 1 ] && ! [ -e "$fileName" ]; then

   /bin/sleep 6300
   /usr/bin/wget --ftp-user=autoget --ftp-password=weareb1Est -o ./words_tool_$logFile  ftp://iwmgh.com/words_tool_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=weareb1Est -o ./auth_$logFile  ftp://iwmgh.com/auth_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=weareb1Est -o ./gtd_$logFile  ftp://iwmgh.com/gtd_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=weareb1Est -o ./studymate_$logFile  ftp://iwmgh.com/studymate_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=weareb1Est -o ./super_memory_$logFile  ftp://iwmgh.com/super_memory_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=weareb1Est -o ./inactive_data_$logFile  ftp://iwmgh.com/inactive_data_$fileName

fi

/sbin/shutdown -h 15








