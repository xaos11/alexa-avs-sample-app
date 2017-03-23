#!/bin/bash

# Assume we are running on a Jessie distribution (IE DietPI)

    UBUNTU_VERSION="trusty"

# Remove any existing Java
sudo apt-get -y autoremove
sudo apt-get -y remove --purge oracle-java8-jdk oracle-java7-jdk openjdk-7-jre openjdk-8-jre

# Install Java from Ubuntu's PPA
# http://linuxg.net/how-to-install-the-oracle-java-8-on-debian-wheezy-and-debian-jessie-via-repository/
sudo sh -c "echo \"deb http://ppa.launchpad.net/webupd8team/java/ubuntu $UBUNTU_VERSION main\" >> /etc/apt/sources.list"
sudo sh -c "echo \"deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu $UBUNTU_VERSION main\" >> /etc/apt/sources.list"

KEYSERVER=(pgp.mit.edu keyserver.ubuntu.com)

GPG_SUCCESS="false"
for server in ${KEYSERVER[@]}; do
  COMMAND="sudo apt-key adv --keyserver ${server} --recv-keys EEA14886"
  echo $COMMAND
  $COMMAND
  if [ "$?" -eq "0" ]; then
    GPG_SUCCESS="true"
    break
  fi
done

if [ "$GPG_SUCCESS" == "false" ]; then
  echo "ERROR: FAILED TO FETCH GPG KEY. UNABLE TO UPDATE JAVA"
fi

sudo apt-get update
sudo apt-get -y install oracle-java8-installer
sudo apt-get -y install oracle-java8-set-default
