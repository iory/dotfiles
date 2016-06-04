#!/bin/bash -x

# workspace like a Mac
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 4

# disable pop up of dash by super key
dconf write /org/compiz/profiles/unity/plugins/unityshell/show-launcher '""'
