function brewup -d 'Updates homebrew'
    command brew update
    command brew upgrade
    command brew bundle --file="$HOME/.dotfiles/brewfiles/all"
    switch (uname)
        case Darwin
            command brew bundle --file="$HOME/.dotfiles/brewfiles/Darwin"
    end
    command brew cleanup
end
