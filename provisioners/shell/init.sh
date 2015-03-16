#!/bin/bash

# Update the system once every month

#@BEGIN: SYSTEM UPDATE SCRIPT
HOSTNAME=`hostname`
DATE_FILE=/vagrant/provisioners/shell/.last-system-update-$HOSTNAME.date
NOW=`date +"%Y%m"`

# Check if the $DATE_FILE exists
# This file stores the date of the last update
if [ ! -f $DATE_FILE ]; then
  # $DATE_FILE file was not found

  # Write the current date into a temporary file
  echo $NOW > $DATE_FILE

  # Update system
  apt-get update --fix-missing
else
  # Get the date of the last update
  LAST_UPDATE=`head -n 1 $DATE_FILE`

  # Check if update was done in the last month
  # Used only for testing purposes
  # LAST_UPDATE=$(( $LAST_UPDATE - 1 ))

  # If update was done at least two months ago do it again
  if [ $LAST_UPDATE -lt $NOW ]; then
    # Write the current date into a temporary file
    echo $NOW > $DATE_FILE

    # Update system
    apt-get update --fix-missing
  else
    echo "The system updates only once a month"
  fi
fi
#@END: SYSTEM UPDATE SCRIPT

# Fix locales
# Resource: http://askubuntu.com/questions/536875/error-in-installing-mongo-in-virtual-machine
echo 'LANG="en_US.UTF-8"' > /etc/default/locale
echo 'LANGUAGE="en_US:en"' >> /etc/default/locale
echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale
echo 'LC_ALL="C"' >> /etc/default/locale

# Install basic packages
apt-get install -y build-essential
apt-get install -y vim htop git