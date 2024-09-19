#!/bin/bash


DISK_USAGE=$(df -hT | grep -vE 'tmp|file')
DISK_THRESHOLD=1
message=""

while IFS= read -r line
do 
  usage=$(echo $line | awk '{print $6}' | cut -d % -f1)
  partition=$(echo $line | awk '{print $1}')
  echo
  #if [ $usage -ge $DISK_THRESHOLD ]


  if  [[ "$usage" =~ ^[0-9]+$ ]] && [ "$usage" -ge "$DISK_THRESHOLD" ]
  then
	  message+="High Disk usage on $partition: $usage \n"
  fi

done <<< $DISK_USAGE

echo -e "Message:\n$message"


