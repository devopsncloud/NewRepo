#!/bin/bash

SOURCE_DIR="/tmp/shellscript-logs"


if [ ! -d $SOURCE_DIR ]
then
	echo "Source Dir doesn't exists"
fi


FILES_TO_DELETE=$(find $SOURCE_DIR -type f -mtime +14 -name "*.logs")



while IFS= read -r line 
do 
	echo "deleting file: $line"
	rm -rf $line

done <<< $FILES_TO_DELETE
