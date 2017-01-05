#!/bin/bash -eu

# install elpy layer
ELPY_LAYER=~/.emacs.d/private/elpy
if [ ! -d $ELPY_LAYER ]; then
    git clone https://github.com/TheBB/elpy-layer $ELPY_LAYER
else
    cd $ELPY_LAYER
    git pull origin master
fi

AUTO_INSERT_LAYER=~/.emacs.d/private/auto-insert
if [ ! -d $AUTO_INSERT_LAYER ]; then
    git clone https://github.com/iory/auto-insert $AUTO_INSERT_LAYER
else
    cd $AUTO_INSERT_LAYER
    git pull origin master
fi
