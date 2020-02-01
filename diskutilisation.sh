#!/bin/bash
CURRENT=$(df -h | grep /dev/mapper/myvol-usr | awk '{ print $5}' | sed 's/%//g')
d=$(df -h | grep /dev/mapper/myvol-usr | awk '{ print $2,$3,$4,$5,$6 }')
THRESHOLD=80

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    nail -s 'Disk Space Alert' himanshu.pandey@payu.in << EOF
Your Disk utilisation is critical . Current status is: $d on the server 10.50.12.165 $(hostname) at $(date)
EOF
fi
