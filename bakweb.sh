#!/bin/bash

WEBPATH=/www/test/
FILTER=,bbbb,

DATE=`date +%Y%m%d`
AGO_DATE=`date -d '15 day ago' "+%Y%m%d"`

BACKUP_PATH="/www/bak/website/$DATE/"
AGO_BACKUP_PATH="/www/bak/website/$AGO_DATE/"

if [ ! -f "$BACKUP_PATH" ];then
    mkdir -p $BACKUP_PATH
else
    echo error >> /dev/null
fi

cd $WEBPATH
for dir in $(ls);
do
	if [[ -f $dir || "$FILTER" == *,$dir,* ]]; then
		continue
	fi
	$(tar czPf "${BACKUP_PATH}/${DATE}_${dir}.tar.gz" "$dir")
done

#find /www/bak/website/ -type f -name "${AGO_DATE}_*.tar.gz" -exec rm -rf {} \;

if [ -d "$AGO_BACKUP_PATH" ];then
    /bin/rm -rf $AGO_BACKUP_PATH
fi

cd /root
