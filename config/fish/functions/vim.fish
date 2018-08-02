function vim --wraps=nvim
    if type -q nvim
        command nvim $argv
    else
        command vim $argv
    end
end

abbr -a v 'vim'
