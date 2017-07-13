#/bin/bash


lock_file="${0}.lock"
if [[ -e "$lock_file" ]] || [[ -e '/alidata/tools/databaseBackup.sh.lock' ]]
then
    echo "$0 OR databaseBackup.sh is already running."
    exit 1
fi

touch "$lock_file"
trap "rm -f ${lock_file}" EXIT


/usr/bin/curl iwmgh.com/inactive_data_migrating.php?id=adfadgqADGGHHADFAGDf2357351adgqADGGHHAD 









