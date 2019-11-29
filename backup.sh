#!/bin/bash

# vars
BACKUP_DIR="."
ODOO_DATABASE="odoo"
ADMIN_PASSWORD='Ramps101*'

# create a backup directory
mkdir -p ${BACKUP_DIR}
_now=$(date +"%m:%d:%Y")
_time=$(date +"%T")
# create a backup
curl -X POST \
    -F "master_pwd=${ADMIN_PASSWORD}" \
    -F "name=${ODOO_DATABASE}" \
    -F "backup_format=zip" \
    -o ${BACKUP_DIR}/${ODOO_DATABASE}$_now$_time.zip \
    http://localhost:8069/web/database/backup



sudo curl -F 'master_pwd=Ramps101*' -F backup_file=@${BACKUP_DIR}/${ODOO_DATABASE}$_now$_time.zip -F 'copy=true' -F 'name=odoo' http://52.177.15.56:8069/web/database/restore


# # delete old backups
# find ${BACKUP_DIR} -type f -mtime +7 -name "${ODOO_DATABASE}.*.zip" -delete
