#!/usr/bin/env fish

set -l DIR (functions -e cd (dirname (status -f)); and pwd)
cd $DIR

echo "installing fish files ..."
for file in (git ls-files)
    switch $file
        case "*.fish"
            echo $DIR/$file "->" $HOME/.config/fish/$file
            mkdir -p (dirname $HOME/.config/fish/$file)
            ln -sf $DIR/$file $HOME/.config/fish/$file
    end
end
