#!/bin/bash -eu

set -x

if [ ! -d ${HOME}/local ]; then
    mkdir ${HOME}/local
fi

sudo apt-get -qq -y update

# pyenv install
case ${OSTYPE} in
    linux*)
        if [ ! -d ${HOME}/.pyenv ]; then
            git clone https://github.com/yyuu/pyenv ~/.pyenv
        fi
        sudo apt-get install -qq -y make build-essential libssl-dev zlib1g-dev libbz2-dev
        sudo apt-get install -qq -y libreadline-dev libsqlite3-dev wget curl llvm
        sudo apt-get install -qq -y libfreetype6-dev libblas-dev liblapack-dev gfortran

        # required for scipy
        sudo apt-get -qq -y install gfortran libopenblas-dev liblapack-dev g++

        # required for matplotlib
        sudo apt-get install -qq -y build-essential python3-tk tk-dev libpng12-dev

        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"

        pyenv install 3.4.0
        pyenv global 3.4.0

        # opencv
        sudo apt-get build-dep -y -qq python-opencv
        if [ ! -d ${HOME}/local/opencv ]; then
            git clone https://github.com/Itseez/opencv.git ${HOME}/local/opencv
        fi
        if [ ! -d ${HOME}/local/opencv_contrib ]; then
            git clone https://github.com/Itseez/opencv_contrib.git ${HOME}/local/opencv_contrib
        fi
        cd ~/local/opencv
        if [ ! -d build ]; then
            mkdir build
        fi
        (cd build \
                && cmake -D CMAKE_BUILD_TYPE=Release \
                         -D CMAKE_INSTALL_PREFIX=$HOME/local/opencv/ \
                         -D OPENCV_EXTRA_MODULES_PATH=$HOME/local/opencv_contrib/modules .. \
                && make -j \
                && sudo make install \
                && sudo ldconfig;)
    ;;
    darwin*)
        brew install pyenv

        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"

        pyenv install 3.4.0
        pyenv global 3.4.0
    ;;
esac

pip install -U -q --upgrade pip
pip install -U ipython
#
# pip install -U pyopencv
# easy_install -U guppy
# easy_install -U nose
pip install -U dpkt
pip install -U grip
pip install -U mahotas
pip install -U matplotlib
pip install -U numpy
pip install -U pandas
pip install -U percol
pip install -U pyflakes
pip install -U pygeoip
pip install -U requests
pip install -U scikit-learn
pip install -U scipy
pip install -U see
pip install -U virtualenv

# if you have an error
# echo "/usr/lib/atlas-base" | sudo tee /etc/ld.so.conf.d/atlas-lib.conf
# sudo ldconfig
