#!/bin/bash -eu

if [ ! -d $HOME/.linuxbrew ]; then
    git clone https://github.com/Linuxbrew/brew.git $HOME/.linuxbrew
else
    (cd $HOME/.linuxbrew && git pull)
fi

echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> ~/.zshrc.local
echo 'export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"' >> ~/.zshrc.local

echo 'set -gx PATH $HOME/.linuxbrew/bin $PATH' >> ~/.fishrc.local
echo 'set -gx LD_LIBRARY_PATH $HOME/.linuxbrew/lib $LD_LIBRARY_PATH' >> ~/.fishrc.local
echo 'set -x MANPATH $HOME/.linuxbrew/share/man $MANPATH' >> ~/.fishrc.local
echo 'set -x INFOPATH $HOME/.linuxbrew/share/info $INFOPATH' >> ~/.fishrc.local


PATH="$HOME/.linuxbrew/bin:$PATH"
LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"

brew update

brew install git
brew install fish
brew install tmux
brew install hub
brew install peco
brew install ripgrep
