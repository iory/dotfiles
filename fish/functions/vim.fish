function vim --wraps=nvim
    if type -q nvim
        command nvim $argv
    end
end
