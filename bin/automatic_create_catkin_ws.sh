#!/bin/sh

if [ "$1" = "" ]
then
    echo "no argument"
    exit 1
fi

mkdir -p ~/catkin_ws/$1/src
cd ~/catkin_ws/$1
catkin init
cd ~/catkin_ws/$1/src
wstool init
