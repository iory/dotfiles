#!/bin/fish

function pdf2png -d "Convert pdf to png function"
    set --local filename $argv[1]
    set --local extension (echo $argv[1] | awk -F. '{print $NF}')
    set --local filename (basename $argv[1] .$extension)
    echo (tput setaf 2)"[convert]:"(tput setaf 9) "$filename.$extension" "->" "$filename.png"
    convert -density 150 "$filename.$extension" -quality 90 "$filename.png"
end
