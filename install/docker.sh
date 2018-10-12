#!/bin/bash -eu

which docker > /dev/null 2>&1 \
    && sudo apt -y remove docker docker-engine docker.io
sudo apt update

sudo apt -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt -y update
sudo apt -y install docker-ce

set -x
sudo groupadd docker
sudo gpasswd -a $USER docker

VERSION=$(lsb_release -sr)
case ${VERSION} in
    14.04)
        sudo initctl restart docker
        ;;
    16.04)
        sudo systemctl restart docker
        ;;
esac
