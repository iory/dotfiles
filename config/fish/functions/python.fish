set -x PYTHONSTARTUP ~/.pythonstartup

# python settings
alias p='ipython --no-confirm-exit'
alias py='ipython --no-confirm-exit'
alias ipy='ipython --no-confirm-exit'
alias ipyt='ipython --no-confirm-exit'
alias ipyth='ipython --no-confirm-exit'
alias ipytho='ipython --no-confirm-exit'
alias ipython='ipython --no-confirm-exit'

# for opencv
alias fcv='python -c "import cv2; print(\"\n\".join([item for item in dir(cv2)]))" | grep'

function jupyte2python -d "Convert jupyer nodebook file to python text file"
    jupyter nbconvert --to python $argv[1]
end
