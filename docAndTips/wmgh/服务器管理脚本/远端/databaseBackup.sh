#!/bin/bash


lock_file="${0}.lock"
if [[ -e "$lock_file" ]]
then
    echo "$0 is already running."
    exit 1
fi

touch "$lock_file"
trap "rm -f ${lock_file}" EXIT



############################################################ backup words_tool

DATE=`date +%Y%m%d_%H%M-`

/alidata/server/mysql/bin/mysqldump -uroot -pWeareBest888 --skip-opt --add-drop-table --single-transaction --hex-blob --quick --create-option --disable-keys --extended-insert --set-charset words_tool | gzip > /duoyuan_data/data_backup/mysql/words_tool_$DATE.sql.gz


DATE_END=`date +%H%M`
new_file=words_tool_$DATE$DATE_END
mv /duoyuan_data/data_backup/mysql/words_tool_$DATE.sql.gz /duoyuan_data/data_backup/mysql/$new_file.sql.gz



#############remove data 5 days ago
logdir=/duoyuan_data/data_backup/mysql
cd ${logdir}
declare -i filesum=`ls words_tool_* | wc -l`
declare -i delnum=$filesum-5
if [ "${delnum}" -ge 1 ];then
rm -rf `ls -tr words_tool_* | head -${delnum}`
fi



############################################################ backup inactive_data

DATE=`date +%Y%m%d_%H%M-`

/alidata/server/mysql/bin/mysqldump -uroot -pWeareBest888 --skip-opt --add-drop-table --single-transaction --hex-blob --quick --create-option --disable-keys --extended-insert --set-charset inactive_data | gzip > /duoyuan_data/data_backup/mysql/inactive_data_$DATE.sql.gz


DATE_END=`date +%H%M`
new_file=inactive_data_$DATE$DATE_END
mv /duoyuan_data/data_backup/mysql/inactive_data_$DATE.sql.gz /duoyuan_data/data_backup/mysql/$new_file.sql.gz



#############remove data 5 days ago
logdir=/duoyuan_data/data_backup/mysql
cd ${logdir}
declare -i filesum=`ls inactive_data_* | wc -l`
declare -i delnum=$filesum-5
if [ "${delnum}" -ge 1 ];then
rm -rf `ls -tr inactive_data_* | head -${delnum}`
fi



############################################################ backup auth

DATE=`date +%Y%m%d_%H%M-`

/alidata/server/mysql/bin/mysqldump -uroot -pWeareBest888 --skip-opt --add-drop-table --single-transaction --hex-blob --quick --create-option --disable-keys --extended-insert --set-charset auth | gzip > /duoyuan_data/data_backup/mysql/auth_$DATE.sql.gz


DATE_END=`date +%H%M`
new_file=auth_$DATE$DATE_END
mv /duoyuan_data/data_backup/mysql/auth_$DATE.sql.gz /duoyuan_data/data_backup/mysql/$new_file.sql.gz



#############remove data 5 days ago
logdir=/duoyuan_data/data_backup/mysql
cd ${logdir}
declare -i filesum=`ls auth_* | wc -l`
declare -i delnum=$filesum-5
if [ "${delnum}" -ge 1 ];then
rm -rf `ls -tr auth_* | head -${delnum}`
fi



############################################################ backup gtd

DATE=`date +%Y%m%d_%H%M-`

/alidata/server/mysql/bin/mysqldump -uroot -pWeareBest888 --skip-opt --add-drop-table --single-transaction --hex-blob --quick --create-option --disable-keys --extended-insert --set-charset gtd | gzip > /duoyuan_data/data_backup/mysql/gtd_$DATE.sql.gz


DATE_END=`date +%H%M`
new_file=gtd_$DATE$DATE_END
mv /duoyuan_data/data_backup/mysql/gtd_$DATE.sql.gz /duoyuan_data/data_backup/mysql/$new_file.sql.gz



#############remove data 5 days ago
logdir=/duoyuan_data/data_backup/mysql
cd ${logdir}
declare -i filesum=`ls gtd_* | wc -l`
declare -i delnum=$filesum-5
if [ "${delnum}" -ge 1 ];then
rm -rf `ls -tr gtd_* | head -${delnum}`
fi



############################################################ backup studymate

DATE=`date +%Y%m%d_%H%M-`

/alidata/server/mysql/bin/mysqldump -uroot -pWeareBest888 --skip-opt --add-drop-table --single-transaction --hex-blob --quick --create-option --disable-keys --extended-insert --set-charset studymate | gzip > /duoyuan_data/data_backup/mysql/studymate_$DATE.sql.gz


DATE_END=`date +%H%M`
new_file=studymate_$DATE$DATE_END
mv /duoyuan_data/data_backup/mysql/studymate_$DATE.sql.gz /duoyuan_data/data_backup/mysql/$new_file.sql.gz



#############remove data 5 days ago
logdir=/duoyuan_data/data_backup/mysql
cd ${logdir}
declare -i filesum=`ls studymate_* | wc -l`
declare -i delnum=$filesum-5
if [ "${delnum}" -ge 1 ];then
rm -rf `ls -tr studymate_* | head -${delnum}`
fi





############################################################ backup super_memory ------connected from port 3307

DATE=`date +%Y%m%d_%H%M-`

/alidata/server/mysql/bin/mysqldump -uroot -pWeareBest888 -P3307 --skip-opt --add-drop-table --single-transaction --hex-blob --quick --create-option --disable-keys --extended-insert --set-charset super_memory | gzip > /duoyuan_data/data_backup/mysql/super_memory_$DATE.sql.gz


DATE_END=`date +%H%M`
new_file=super_memory_$DATE$DATE_END
mv /duoyuan_data/data_backup/mysql/super_memory_$DATE.sql.gz /duoyuan_data/data_backup/mysql/$new_file.sql.gz



#############remove data 5 days ago
logdir=/duoyuan_data/data_backup/mysql
cd ${logdir}
declare -i filesum=`ls super_memory_* | wc -l`
declare -i delnum=$filesum-5
if [ "${delnum}" -ge 1 ];then
rm -rf `ls -tr super_memory_* | head -${delnum}`
fi















cd -














