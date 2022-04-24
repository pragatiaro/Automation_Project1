#!/bin/bash

#Task 2
sudo apt update -y
echo "----------package update done---------------------"
timestamp=$(date '+%d%m%Y-%H%M%S')
myname="Pragati"
s3_bucket="upgrad-pragati"


# Below code to check whether apache2 installed or not, if not then install it.
pkgs='apache2'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install $pkgs -y
fi
echo "-----------apache2 check done--------------------"

#Below code will check apache2 service is enabled or not, if not then enable it.
apache2_check="$(systemctl status apache2.service | grep Active | awk {'print $3'})"
if [ "${apache2_check}" = "(dead)" ]; then
        systemctl enable apache2.service
        echo "service enabled"
fi

#Below code will check whether apache2 is running or not, if not then start the service.
ServiceStatus="$(systemctl is-active apache2.service)"
if [ "${ServiceStatus}" = "active" ]; then
        echo "Already apache2 running" 
else
    sudo systemctl start apache2
    echo "Service started"
fi
echo "-----------apache2 service status check done, started if its in stoped--------------------"
sudo systemctl status apache2
echo "--------------status as after started---------------------------"


# Compressing the access.log and error.log to a tar file

cd /var/log/apache2/
tar -cvf /tmp/${myname}-httpd-logs-${timestamp}.tar *.log
size=$(sudo du -sh /tmp/${myname}-httpd-logs-${timestamp}.tar | awk '{print $1}')#!/bin/bash
#End of Task 2
