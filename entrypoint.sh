#!/bin/sh

# Assert env variable
if [ -z "$ROUTER_HOST" ]; then
  echo "ERROR: 'ROUTER_HOST' env variable is not defined"
  exit 1
fi

# Assert env variable
if [ -z "$USER_NAME" ]; then
  echo "ERROR: 'USER_NAME' env variable is not defined"
  exit 1
fi

# Assert env variable
if [ -z "$PASSWORD" ]; then
  echo "ERROR: 'PASSWORD' env variable is not defined"
  exit 1
fi

# Set default backup numbers if the env variable is not set
NUMBER_OF_BACKUPS="${NUMBER_OF_BACKUPS:-30}"

# Set default backup frequency if the env variable is not set
CRON="${CRON:-@daily}"

# Provide env variables to the cron
env >> /etc/environment

# Add cron task
echo "$CRON /etc/backup.sh" >> /etc/crontabs/root

# Run cron
exec "crond -l 2 -f"
