function rgl -d "Pipe ripgrep output to less"
    command rg --color always --heading --line-number --smart-case $argv | less --raw-control-chars
end
