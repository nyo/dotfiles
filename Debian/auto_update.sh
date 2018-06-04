#!/bin/sh
LOGFILE="/var/log/update_script.log"
echo "\n[ $(date) ]" >> $LOGFILE
sudo apt-get -y update >> $LOGFILE
echo "\n[ $(date) ]" >> $LOGFILE
sudo apt-get -y upgrade >> $LOGFILE
echo "\n[ $(date) ]" >> $LOGFILE
sudo npm update >> $LOGFILE
sudo npm update -g >> $LOGFILE
