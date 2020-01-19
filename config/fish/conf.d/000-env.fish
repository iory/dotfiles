if test -e ~/.fishrc.local
    . ~/.fishrc.local
end

set -x PATH $HOME/.local/bin $PATH

# automatically install fisher
. ~/.config/fish/functions/fisher-extend.fish
