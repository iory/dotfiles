#!/bin/bash -eu

# http://qiita.com/kawaz/items/1b61ee2dd4d1acc7cc94
# We use type check

current_working_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if type jupyter >/dev/null 2>&1; then
    mkdir -p $(jupyter --data-dir)/nbextensions
    if [ ! -d $(jupyter --data-dir)/nbextensions/vim_binding ]; then
        git clone https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding
    fi
    jupyter nbextension enable vim_binding/vim_binding

    echo "creating symbolic link to $HOME/.jupyter/custom..."
    mkdir -p $HOME/.jupyter
    ln -sf $current_working_directory/jupyter/custom $HOME/.jupyter/custom
    echo "created."
else
    echo 'jupyter not found\!';
    echo 'try to install jupyter.';
    echo 'pip install jupyter';
    exit
fi
