#!/bin/bash
BACKUP_DIR="/home/backup"
ROTATE_DIR="/home/backup/rotate"
TIMESTAMP="timestamp.dat"
SOURCE="/"
DATE=$(date +%Y-%m-%d-%H%M%S)

EXCLUDE="--exclude=/mnt/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/*"

cd /

mkdir -p ${BACKUP_DIR}

set -- ${BACKUP_DIR}/backup-??.tar.gz
lastname=${!#}
backupnumber=${lastname##*backup-}
backupnumber=${backupnumber%%.*}
backupnumber=${backupnumber//\?/0}
backupnumber=$[10#${backupnumber}]

if [ "$[backupnumber++]" -ge 30 ]; then
mkdir -p ${ROTATE_DIR}/${DATE}
mv ${BACKUP_DIR}/b* ${ROTATE_DIR}/${DATE}
mv ${BACKUP_DIR}/t* ${ROTATE_DIR}/${DATE}
backupnumber=1
fi

backupnumber=0${backupnumber}
backupnumber=${backupnumber: -2}
filename=backup-${backupnumber}.tar.gz

tar -cpzf ${BACKUP_DIR}/${filename} -g ${BACKUP_DIR}/${TIMESTAMP} $EXCLUDE ${SOURCE}
