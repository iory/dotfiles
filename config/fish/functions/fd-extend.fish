function fdd -d "cd to selected directory"
    set --local dir (fd --type d 2> /dev/null | fzf +m)
    cd $dir
end
