if test -e ~/.fishrc.local
    . ~/.fishrc.local
end

set -x PATH $HOME/.local/bin $PATH
. ~/.config/fish/functions/linuxbrew.fish

# automatically install fisher
. ~/.config/fish/functions/fisher-extend.fish
