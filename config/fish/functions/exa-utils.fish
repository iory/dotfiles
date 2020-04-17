abbr ls 'exa --group-directories-first'
abbr l 'exa -lh --group-directories-first --time-style=long-iso --icons'
abbr ll 'exa -alh --group-directories-first --time-style=long-iso --icons'
abbr l1 'exa -lh --group-directories-first --time-style=long-iso -T -L2 --icons'
abbr l2 'exa -lh --group-directories-first --time-style=long-iso -T -L3 --icons'
abbr l3 'exa -lh --group-directories-first --time-style=long-iso -T -L4 --icons'

abbr lll 'exa -alh --group-directories-first --time-style=long-iso --icons --color always | less --raw-control-chars'
abbr l1l 'exa -alh --group-directories-first --time-style=long-iso --icons -T -L1 --color always | less --raw-control-chars'
abbr l2l 'exa -alh --group-directories-first --time-style=long-iso --icons -T -L2 --color always | less --raw-control-chars'
abbr l3l 'exa -alh --group-directories-first --time-style=long-iso --icons -T -L3 --color always | less --raw-control-chars '

function tree -d "Pipe exa --tree output to less"
    command exa --color always ---time-style=long-iso --group-directories-first  --icons -I '.git|.cache|__pycache__' --tree $argv
end

function treel -d "Pipe exa --tree output to less"
    command exa --color always ---time-style=long-iso --group-directories-first  --icons -I '.git|.cache|__pycache__' --tree $argv | less --raw-control-chars
end

abbr tl 'treel'
