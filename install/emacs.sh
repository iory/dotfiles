#!/bin/bash -eu

# install elpy layer
ELPY_LAYER=~/.emacs.d/private/elpy
if [ ! -d $ELPY_LAYER ]; then
    git clone https://github.com/TheBB/elpy-layer $ELPY_LAYER
else
    cd $ELPY_LAYER
    git pull origin master
fi
