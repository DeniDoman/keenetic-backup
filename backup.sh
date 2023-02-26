#!/bin/sh

# Set internal vars
FULL_DATE=$(date +'%d-%m-%Y-T-%H-%M-%S')
OUTPUT_PATH='/opt'

# Do backup
sshpass -p "${PASSWORD}" ssh "${USER_NAME}@${ROUTER_HOST}" 'show running-config' > "${OUTPUT_PATH}/temp"

if [ $? -eq 0 ]
then
  mv "${OUTPUT_PATH}/temp" "${OUTPUT_PATH}/keenetic-backup-${FULL_DATE}.txt"
fi

count=$(ls -latc ${OUTPUT_PATH}/*.txt | wc -l)

# Check backup count
if [ ${count} -gt ${NUMBER_OF_BACKUPS} ]
then
  file_to_del=$(find ${OUTPUT_PATH}/*.txt -type f -print0 | xargs -0 ls -ltr | head -n 1 | awk '{ print $9}')
  # remove oldest file
  rm -rf "${file_to_del}"
fi
