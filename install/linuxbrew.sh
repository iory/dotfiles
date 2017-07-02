#!/bin/bash -eu

git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew

echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> ~/.zshrc.local
echo 'export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"' >> ~/.zshrc.local

echo 'set -gx PATH $HOME/.linuxbrew/bin $PATH' >> ~/.fishrc.local
echo 'set -gx LD_LIBRARY_PATH $HOME/.linuxbrew/lib $LD_LIBRARY_PATH' >> ~/.fishrc.local
