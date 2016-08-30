#!/bin/bash

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
sudo apt-get update -qq -y
sudo apt-get install ros-indigo-desktop-full -y
sudo rosdep init
rosdep update
sudo apt-get install -y python-rosinstall
sudo apt-get install -y python-catkin-tools

mkdir -p ~/ros/indigo/src ~/ros/indigo_parent/src
cp ~/.dotfiles/rosinstall/indigo_parent.rosinstall ~/ros/indigo_parent/src/.rosinstall
cp ~/.dotfiles/rosinstall/indigo.rosinstall ~/ros/indigo/src/.rosinstall
cd ~/ros/indigo_parent/src
wstool up
cd ~/ros/indigo/src
wstool up
