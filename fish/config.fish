if test -e ~/.fishrc.local
    . ~/.fishrc.local
end

set -x PATH $HOME/.local/bin $PATH
set -x XDG_CONFIG_HOME $HOME/.config

. ~/.config/fish/functions/emacs.fish
. ~/.config/fish/functions/git.fish
. ~/.config/fish/functions/util.fish
. ~/.config/fish/functions/cuda.fish
. ~/.config/fish/functions/ghs.fish
. ~/.config/fish/functions/vim.fish
. ~/.config/fish/functions/update.fish
. ~/.config/fish/functions/ps.fish
. ~/.config/fish/functions/lock.fish
switch (uname)
    case Darwin
        . ~/.config/fish/functions/itunes.fish
end

#peco
function peco_recentd
    z -l | peco | awk '{ print $2 }' | read recentd
    cd $recentd
end

function fish_user_key_bindings
    bind \cr 'peco_select_history (commandline -b)'
    bind \cxk peco_kill
    bind \cc\cr peco_recentd
    bind \c] peco_select_ghq_repository
end



# suppress fish_greeting message
function fish_greeting
end

# see full path of directory names
set -U fish_prompt_pwd_dir_length 0
