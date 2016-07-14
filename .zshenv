if [ "$ZSH_VERSION" != "" ];then
    export ZDOTDIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"
else
    export ZDOTDIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
fi
