#!/bin/sh
while :
do
    echo "Checking for inactive hosts every $INTERVAL seconds..."
    rancher hosts -a | grep -E 'disconnected' | while read LINE1
    do
        HOST=$(echo $LINE1 | cut -d ' ' -f 1)
        echo "stop $LINE1"
        rancher stop --type host $HOST
    done
    sleep $INTERVAL
    rancher hosts -a | grep -E 'inactive' | while read LINE
    do
        HOST=$(echo $LINE | cut -d ' ' -f 1)
        echo "Delete $LINE"
        rancher rm --type host $HOST
    done
    sleep $INTERVAL
done

