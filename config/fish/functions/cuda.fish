#!/bin/fish

set -x CUDA_PATH /usr/local/cuda
set -x PATH $CUDA_PATH/bin $PATH
set -x LD_LIBRARY_PATH $CUDA_PATH/lib64:$LD_LIBRARY_PATH
set -x CPATH $CUDA_PATH/include:$CPATH
set -x LIBRARY_PATH $CUDA_PATH/lib64:$LD_LIBRARY_PATH
