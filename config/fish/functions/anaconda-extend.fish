set -q ANACONDA_VERSION; or set ANACONDA_VERSION anaconda3-5.3.1


function check_and_update_anaconda_env
    if test -d $HOME/.pyenv/versions/$ANACONDA_VERSION
    else
        set -gx PATH $PATH $HOME/.pyenv/bin
        cd $HOME/.pyenv
        git pull
        pyenv install $ANACONDA_VERSION
    end
end


function activate_conda_env -d 'activate function for anaconda'
    set -gx PATH $PATH $HOME/.pyenv/bin $HOME/.pyenv/versions/$ANACONDA_VERSION/bin
    if not functions -q conda
        source (conda info --root)/etc/fish/conf.d/conda.fish
    end
    set length (count $argv)
    if test $length -gt 0
        conda activate $argv[1]
    end
end


function source_activate_conda_env -d 'activate and source function for anaconda'
    set -gx PATH $PATH $HOME/.pyenv/bin $HOME/.pyenv/versions/$ANACONDA_VERSION/bin
    if not functions -q conda
        source (conda info --root)/etc/fish/conf.d/conda.fish
    end
    set length (count $argv)
    if test $length -gt 0
        if ! test -d ~/.pyenv/versions/anaconda3-5.3.1/envs/$argv[1]
            echo "Automatically create conda env"
            conda create -n $argv[1] python=3.7 -y
        end
        conda activate $argv[1]
    end
end

check_and_update_anaconda_env
alias activate 'set -gx PATH $PATH $HOME/.pyenv/versions/$ANACONDA_VERSION/bin; source (conda info --root)/etc/fish/conf.d/conda.fish'
alias ac 'activate_conda_env'
alias acd 'source_activate_conda_env dl'
