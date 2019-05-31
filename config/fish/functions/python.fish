# python settings
abbr -a p 'ipython --no-confirm-exit'
abbr -a py 'ipython --no-confirm-exit'
abbr -a ipy 'ipython --no-confirm-exit'
abbr -a ipyt 'ipython --no-confirm-exit'
abbr -a ipyth 'ipython --no-confirm-exit'
abbr -a ipytho 'ipython --no-confirm-exit'
abbr -a ipython 'ipython --no-confirm-exit'

# for opencv
abbr -a fcv=h 'python -c "import cv2; print(\"\n\".join([item for item in dir(cv2)]))" | grep'

function jupyte2python -d "Convert jupyer nodebook file to python text file"
    jupyter nbconvert --to python $argv[1]
end
