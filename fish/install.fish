#!/usr/bin/env fish

set -l DIR (functions -e cd (dirname (status -f)); and pwd)
cd $DIR

function options
    echo $argv | sed 's|--*|\\'\n'|g' | grep -v '^$'
end

function function_with_options
    for i in (options $argv)
        echo $i | read -l option value

        switch $option
            case login l
                echo $DIR/.profile "->" $HOME/.profile
                ln -sf $DIR/.profile $HOME/.profile
        end
    end
end

echo "installing fish files ..."
function_with_options $argv

for file in (git ls-files)
    switch $file
        case "*.fish"
            echo $DIR/$file "->" $HOME/.config/fish/$file
            mkdir -p (dirname $HOME/.config/fish/$file)
            ln -sf $DIR/$file $HOME/.config/fish/$file
    end
end
