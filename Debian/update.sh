#!/bin/sh
LOGFILE="/var/log/updates.log"
echo "\n[ $(date) ]" >>$LOGFILE
sudo apt-get -y update 1>>$LOGFILE 2>>$LOGFILE
echo "\n[ $(date) ]" >>$LOGFILE
sudo apt-get -y upgrade 1>>$LOGFILE 2>>$LOGFILE
echo "\n[ $(date) ]" >>$LOGFILE
sudo apt-get -y autoremove 1>>$LOGFILE 2>>$LOGFILE
sudo apt-get -y autoclean 1>>$LOGFILE 2>>$LOGFILE
