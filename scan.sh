#!/bin/bash

sudo touch /var/webserver_log/unauthorized.log
sudo chmod 666 /var/webserver_log/unauthorized.log

sudo cat /var/log/auth.log \
        | grep "sshd" \
        | grep -v "sudo" \
        | grep -E "^$(date -d '-1 minute' +'%b %d %H:%M')|^$(date -d '-2 minute' +'%b %d %H:%M')|^$(date -d '-3 minute' +'%b %d %H:%M')|^$(date -d '-4 minute' +'%b %d %H:%M')|^$(date -d '-5 minute' +'%b %d %H:%M')" \
        | grep -E "Disconnected from authenticating user|Connection closed by invalid user|Failed password" | while read line
do
        date=`echo $line | grep -oE "[a-zA-Z]* [0-9]{1,2} [0-9][0-9]:[0-9][0-9]:[0-9][0-9]"`
        ip=`echo $line | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}"`
        country=`geoiplookup $ip | sed 's/^.*, //'`
        echo $ip $country $date >> /var/webserver_log/unauthorized.log
done
