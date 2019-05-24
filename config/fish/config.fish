if test -e ~/.fishrc.local
    . ~/.fishrc.local
end

set -x PATH $HOME/.local/bin $PATH

# automatically install fisher
. ~/.config/fish/functions/fisher-extend.fish

# source config
. ~/.config/fish/functions/anaconda-extend.fish
. ~/.config/fish/functions/emacs-extend.fish
. ~/.config/fish/functions/cq.fish
. ~/.config/fish/functions/git.fish
. ~/.config/fish/functions/util.fish
. ~/.config/fish/functions/cuda.fish
. ~/.config/fish/functions/ghs.fish
. ~/.config/fish/functions/vim.fish
. ~/.config/fish/functions/tmux.fish
. ~/.config/fish/functions/update.fish
. ~/.config/fish/functions/ranger.fish
. ~/.config/fish/functions/ps.fish
. ~/.config/fish/functions/lock.fish
. ~/.config/fish/functions/video.fish
. ~/.config/fish/functions/gdrive.fish
. ~/.config/fish/functions/gdb.fish
. ~/.config/fish/functions/ping.fish
. ~/.config/fish/functions/pwd-extend.fish
. ~/.config/fish/functions/cd-extend.fish
. ~/.config/fish/functions/kill.fish
. ~/.config/fish/functions/ifconfig.fish
. ~/.config/fish/functions/ip.fish
. ~/.config/fish/functions/bass_completion.fish
. ~/.config/fish/functions/python.fish
. ~/.config/fish/functions/gym.fish
. ~/.config/fish/functions/less_extend.fish
. ~/.config/fish/functions/du_extend.fish
switch (uname)
    case Darwin
        . ~/.config/fish/functions/itunes.fish
        . ~/.config/fish/functions/osx.fish
    case Linux
        . ~/.config/fish/functions/ros.fish
end

if test -n "$SSH_CONNECTION"
    set -x EDITOR vim
end

#peco
function recentd
    set -l query $argv

    if test -n "$query"
        set flags --query "$query"
    end

    switch (uname)
        case Darwin
            z -l | tail -r | fzf $flags| awk '{ print $2 }' | read recent
        case Linux
            z -l | tac | fzf $flags | awk '{ print $2 }' | read recent
    end
    if [ $recent ]
        cd $recent
        commandline -r ''
        commandline -f repaint
    end
end

function peco_select_ps
  ps ax -o pid,time,command | peco --query "$LBUFFER" | awk '{print $1}'
end

function fish_user_key_bindings
    bind \cr 'peco_select_history (commandline -b)'
    bind \cxk peco_kill
    bind \cxb recentd
    bind \c] peco_select_ghq_repository
    bind \cxc peco_select_catkin_workspace
    switch (uname)
        case Darwin
            bind \cc\ci _itunes_play_track
            bind \cci _itunes_play_track
    end
end

abbr -a j 'recentd'

# suppress fish_greeting message
function fish_greeting
end

# see full path of directory names
set -U fish_prompt_pwd_dir_length 0
