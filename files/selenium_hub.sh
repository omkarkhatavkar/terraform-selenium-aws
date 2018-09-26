#!/bin/bash



yum -y update 
yum -y install java-1.8.0-openjdk-devel
yum -y install wget 

wget http://selenium-release.storage.googleapis.com/3.14/selenium-server-standalone-3.14.0.jar
nohup java -jar selenium-server-standalone-3.14.0.jar -role hub &
sleep 10
