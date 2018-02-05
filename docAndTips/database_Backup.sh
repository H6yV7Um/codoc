#/bin/bash


WD=/root/crontab-tasks

lock_file=$WD/databaseBackup.lock

if [[ -e "$lock_file" ]]
then
    echo "databaseBackup program is already running."
    exit 1
fi

touch "$lock_file"
trap "rm -f ${lock_file}" EXIT



############################################################ backup allvic

START_DATE=`date +%Y%m%d_%H%M`
TABLE=allvic
DATAPATH=/root/db-backups

/usr/bin/mysqldump -uroot -proot --skip-opt --add-drop-table --single-transaction --hex-blob --quick --create-option --disable-keys --extended-insert --set-charset $TABLE | gzip > $DATAPATH/${TABLE}_$START_DATE.sql.gz


FIN_DATE=`date +%H%M`
mv $DATAPATH/${TABLE}_$START_DATE.sql.gz $DATAPATH/${TABLE}_${START_DATE}-${FIN_DATE}.sql.gz



#############remove data 5 days ago
cd ${DATAPATH}
declare -i filesum=`ls ${TABLE}_* | wc -l`
echo $filesum
declare -i delnum=$filesum-5
echo $delnum
if [ "${delnum}" -ge 1 ];then
rm -rf `ls -tr ${TABLE}_* | head -${delnum}`
fi




############################################################ backup zentao

PREFIX=`date +%Y%m%d`
TABLE=zentao
DATAPATH=/root/db-backups
SRCPATH=/var/www/html/csc/tmp/backup


cd $SRCPATH

tar -cvf ${TABLE}_$PREFIX.tar ${PREFIX}*
mv ${TABLE}_$PREFIX.tar $DATAPATH/


#############remove data 5 days ago
cd ${DATAPATH}
declare -i filesum=`ls ${TABLE}_* | wc -l`
echo $filesum
declare -i delnum=$filesum-5
echo $delnum
if [ "${delnum}" -ge 1 ];then
rm -rf `ls -tr ${TABLE}_* | head -${delnum}`
fi













