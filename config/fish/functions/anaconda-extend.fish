set -q ANACONDA_VERSION; or set ANACONDA_VERSION anaconda3-5.3.1


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


alias activate 'set -gx PATH $PATH $HOME/.pyenv/versions/$ANACONDA_VERSION/bin; source (conda info --root)/etc/fish/conf.d/conda.fish'
alias ac 'activate_conda_env'
