#!/bin/sh

defaults write com.apple.dock mru-spaces -bool false

# Disable .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Disable crash report
defaults write com.apple.CrashReporter DialogType -string "none"
