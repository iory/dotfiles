if test -e ~/.fishrc.local
    . ~/.fishrc.local
end

set -x PATH $HOME/.local/bin $PATH

. ~/.config/fish/functions/emacs.fish
. ~/.config/fish/functions/git.fish
. ~/.config/fish/functions/util.fish
. ~/.config/fish/functions/cuda.fish

#peco
function peco_recentd
    z -l | peco | awk '{ print $2 }' | read recentd
    cd $recentd
end

function fish_user_key_bindings
    bind \cr 'peco_select_history (commandline -b)'
    bind \cxk peco_kill
    bind \cc\cr peco_recentd
end



# suppress fish_greeting message
function fish_greeting
end

# see full path of directory names
set -U fish_prompt_pwd_dir_length 0
