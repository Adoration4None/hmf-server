BACKUP_DIR=/home/backup
cd /
for archivo in ${BACKUP_DIR}/backup-*.tar.gz; do
tar -xpzf $archivo -C /
done
