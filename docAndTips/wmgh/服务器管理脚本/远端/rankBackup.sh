#!/bin/bash


DATE=`date +%Y%m%d_%H%M`

echo $0 begin time: ${DATE} >> /alidata/log/rankBackup.log

/bin/echo '<?php' > /alidata/www/iwmgh.com/tmp_backup_rankdata.php
/bin/echo "require_once dirname(__FILE__).'/db_trans_h.php';" >> /alidata/www/iwmgh.com/tmp_backup_rankdata.php
/bin/echo "CallDbTrans("RankingDb",'RankingDataBackup');" >> /alidata/www/iwmgh.com/tmp_backup_rankdata.php
/bin/echo "?>" >> /alidata/www/iwmgh.com/tmp_backup_rankdata.php

/alidata/server/php/bin/php -q /alidata/www/iwmgh.com/tmp_backup_rankdata.php

/bin/rm /alidata/www/iwmgh.com/tmp_backup_rankdata.php

DATE=`date +%Y%m%d_%H%M`

echo $0 end time: ${DATE} >> /alidata/log/rankBackup.log

