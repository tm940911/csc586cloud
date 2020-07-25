#!/bin/bash

new_access=`sudo cat /var/webserver_monitor/unauthorized.log | grep -E "$(date -d '-1 hour' +'%b %d %H')"`

if [ -z "$new_access" ]; then
        message="No unauthorized access."
else
        message=$new_access
fi

echo $message | mail -s "Access Update" tandmmail2@gmail.com
