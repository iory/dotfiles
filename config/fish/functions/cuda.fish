#!/bin/fish

if test -d "/usr/local/cuda"
    set -q CUDA_VERSION; or set CUDA_VERSION ""
    if test (string length $CUDA_VERSION) -gt 0
        set -x CUDA_VERSION "-$CUDA_VERSION"
    end
    set -x CUDA_PATH /usr/local/cuda"$CUDA_VERSION"
    set -x PATH $CUDA_PATH/bin $PATH
    set -x LD_LIBRARY_PATH "$CUDA_PATH/lib64":"$LD_LIBRARY_PATH"
    set -x CPATH "$CUDA_PATH/include":"$CPATH"
    set -x LIBRARY_PATH "$CUDA_PATH/lib64":"$LD_LIBRARY_PATH"
end
