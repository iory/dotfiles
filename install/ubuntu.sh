#!/bin/bash -eu

# fonts install
(cd /tmp \
     && git clone https://github.com/powerline/fonts.git \
     && cd fonts \
     && ./install.sh \
     && rm -rf /tmp/fonts)
