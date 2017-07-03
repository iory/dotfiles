. ~/.config/fish/functions/emacs.fish
. ~/.config/fish/functions/git.fish
. ~/.config/fish/functions/util.fish

if test -e ~/.fishrc.local
    . ~/.fishrc.local
end

#peco
function peco_recentd
    z -l | peco | awk '{ print $2 }' | read recentd
    cd $recentd
end

function fish_user_key_bindings
    bind \cr 'peco_select_history (commandline -b)'
    bind \cxk peco_kill
    bind \cx\cr peco_recentd
end



# suppress fish_greeting message
function fish_greeting
end

# see full path of directory names
set -U fish_prompt_pwd_dir_length 0
set -g fish_user_paths "/usr/local/opt/llvm/bin" $fish_user_paths
