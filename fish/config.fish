. ~/.dotfiles/rosfish

if test -e ~/.fishrc.local
    . ~/.fishrc.local
end

#peco
function fish_user_key_bindings
    bind \cr peco_select_history
end

# suppress fish_greeting message
function fish_greeting
end

# see full path of directory names
set -U fish_prompt_pwd_dir_length 0
