#!/bin/bash

LOAD_AVG=$(awk '{print $1}' /proc/loadavg)
CPU_CORES=$(nproc)

STATUS="OK"

awk -v load_avg="$LOAD_AVG" -v cores="$CPU_CORES" '
BEGIN {
    if (load_avg > cores)
        exit 1
    else
        exit 0
}
'

if [ $? -eq 1 ]; then
    STATUS="BUSY"
fi

echo "CPU STATUS"
echo "----------"
echo "Load Average (1m): $LOAD_AVG"
echo "CPU Cores        : $CPU_CORES"
echo "Status           : $STATUS"


echo " "
echo " "

TOTAL_MEM=$(free -m | awk '/Mem:/ {print $2}')
AVAILABLE_MEM=$(free -m | awk '/Mem:/ {print $7}')

USED_MEM=$((TOTAL_MEM - AVAILABLE_MEM))
USED_PERCENT=$((USED_MEM * 100 / TOTAL_MEM))

STATUS="OK"

if [ "$USED_PERCENT" -ge 80 ]; then
    STATUS="LOW"
fi

echo "MEMORY STATUS"
echo "-------------"
echo "Total Memory     : ${TOTAL_MEM} MB"
echo "Available Memory : ${AVAILABLE_MEM} MB"
echo "Used Memory      : ${USED_PERCENT}%"
echo "Status           : $STATUS"


# --------------------
# DISK CHECK
# --------------------
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

DISK_STATUS="OK"
if [ "$DISK_USAGE" -ge 80 ]; then
    DISK_STATUS="LOW SPACE"
fi

echo
echo "DISK STATUS"
echo "-----------"
echo "Disk Used : ${DISK_USAGE}%"
echo "Status    : $DISK_STATUS"

