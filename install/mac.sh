#!/bin/sh

defaults write com.apple.dock mru-spaces -bool false

# Disable .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
