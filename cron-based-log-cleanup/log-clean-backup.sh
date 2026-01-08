#!/bin/bash

# --------------------
# CONFIGURATION
# --------------------
LOG_DIR="/var/log/myapp"
BACKUP_BASE="/backup/logs"
RETENTION_DAYS=7
DATE=$(date +%F)

BACKUP_DIR="$BACKUP_BASE/$DATE"

# --------------------
# CREATE BACKUP DIRECTORY
# --------------------
mkdir -p "$BACKUP_DIR"

# --------------------
# BACKUP CURRENT LOG FILES
# --------------------
cp "$LOG_DIR"/*.log "$BACKUP_DIR"/ 2>/dev/null

# --------------------
# DELETE OLD LOG FILES
# --------------------
find "$LOG_DIR" -type f -name "*.log" -mtime +$RETENTION_DAYS -exec rm -f {} \;

# --------------------
# LOG SCRIPT ACTIVITY
# --------------------
echo "$(date '+%F %T') Logs backed up and old logs deleted" >> /var/log/log_cleanup.log
