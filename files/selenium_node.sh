#!/bin/bash

#installing Java 
sudo yum -y install java-1.8.0-openjdk-devel
yum -y install wget
sudo wget http://selenium-release.storage.googleapis.com/3.14/selenium-server-standalone-3.14.0.jar
hub=$1
echo "**************** HUB URL IS *************"
echo "*****************http://$hub:4444/wd/hub/********************"


#Installing Firefox
wget https://github.com/mozilla/geckodriver/releases/download/v0.21.0/geckodriver-v0.21.0-linux64.tar.gz
tar -xvzf geckodriver-v0.21.0-linux64.tar.gz
chmod +x geckodriver
cp geckodriver /usr/local/bin/

yum -y install xorg-x11-xauth
yum -y install xorg-x11-apps
xclock
export DISPLAY=:0.0
echo "DISPLAY ==>"
echo $DISPLAY
yum -y install firefox Xvfb libXfont Xorg
Xvfb :99 -ac -screen 0 1280x1024x24 &

nohup xvfb-run -a -s "-screen 0 1280x1600x24" java -Dwebdriver.gecko.driver="/usr/local/bin/geckodriver" -jar selenium-server-standalone-3.14.0.jar -role node -hub http://$hub:4444/grid/register &

sleep 10


