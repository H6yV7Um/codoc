#!/bin/bash

isMonday=`date | grep 'Mon'|wc -l`
fileName=`date +%Y%m%d_*.sql.gz`
logFile=`date +%Y%m%d.log`
cd /backup/mysql

if [ "${isMonday}" == 1 ] && ! [ -e "$fileName" ]; then

   /bin/sleep 6300
   /usr/bin/wget --ftp-user=autoget --ftp-password=mypw -o ./words_tool_$logFile  ftp://host.com/words_tool_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=mypw -o ./auth_$logFile  ftp://host.com/auth_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=mypw -o ./gtd_$logFile  ftp://host.com/gtd_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=mypw -o ./studymate_$logFile  ftp://host.com/studymate_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=mypw -o ./super_memory_$logFile  ftp://host.com/super_memory_$fileName

   /usr/bin/wget --ftp-user=autoget --ftp-password=mypw -o ./inactive_data_$logFile  ftp://host.com/inactive_data_$fileName

fi

/sbin/shutdown -h 15








