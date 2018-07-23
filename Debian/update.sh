#!/bin/sh
LOGFILE="/var/log/updates.log"
echo "\n[ $(date) ]" >> $LOGFILE
sudo apt-get -y update 2>&1 >> $LOGFILE
echo "\n[ $(date) ]" >> $LOGFILE
sudo apt-get -y upgrade 2>&1 >> $LOGFILE
echo "\n[ $(date) ]" >> $LOGFILE
sudo apt-get -y autoremove 2>&1 >> $LOGFILE
sudo apt-get -y autoclean 2>&1 >> $LOGFILE
