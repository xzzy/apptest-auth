#!/bin/bash
  
# Start the first process
env > /etc/.cronenv

# service cron start &
# status=$?
# if [ $status -ne 0 ]; then
#   echo "Failed to start cron: $status"
#   exit $status
# fi

# Start the second process
nginx -c /app/nginx/conf/nginx.conf -p /app/nginx
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi
bash
