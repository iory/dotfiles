# http://piyopiyoducky.net/blog/2013/08/17/cdr-with-percol/
### search a destination from cdr list
function percol-get-destination-from-cdr() {
    cdr -l | \
        sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
        percol --match-method migemo --query "$LBUFFER"
}

### search a destination from cdr list and cd the destination
function percol-cdr() {
    local destination="$(percol-get-destination-from-cdr)"
    if [ -n "$destination" ]; then
        BUFFER="cd $destination"
        zle accept-line
    else
        zle reset-prompt
    fi
}
zle -N percol-cdr
bindkey '^X^F' percol-cdr
