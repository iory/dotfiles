#!/bin/sh -e

black-echo() { echo "$(tput setaf 0)$*$(tput setaf 9)"; }
red-echo() { echo "$(tput setaf 1)$*$(tput setaf 9)"; }
green-echo() { echo "$(tput setaf 2)$*$(tput setaf 9)"; }
yellow-echo() { echo "$(tput setaf 3)$*$(tput setaf 9)"; }
blue-echo() { echo "$(tput setaf 4)$*$(tput setaf 9)"; }
magenta-echo() { echo "$(tput setaf 5)$*$(tput setaf 9)"; }
cyan-echo() { echo "$(tput setaf 6)$*$(tput setaf 9)"; }
white-echo() { echo "$(tput setaf 7)$*$(tput setaf 9)"; }

green-echo "[Test/emacs] emacs settings"
emacs-snapshot --version
emacs-snapshot -nw -batch -u "${UNAME}" --eval '(let ((debug-on-error t)) (dotspacemacs/user-config))' 2>/dev/null
if [ $? -gt 0 ]; then
    red-echo "[Test/emacs] Failed"
    exit 1
fi
green-echo "[Test/emacs] Passed successful"
