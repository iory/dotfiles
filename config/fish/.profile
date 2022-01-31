FISH_BIN="/usr/bin/fish"

# The replacement is only done in non-fish login interactive shell in
# SSH connection and fish executable exists.
if [ "$SHELL" != "$FISH_BIN" -a -n "$SSH_TTY" -a -x "$FISH_BIN" ] ; then
    # we first check whether fish can be executed, otherwise the
    # replacement will cause immediate crash at login (not fun)
    if "$FISH_BIN" -c 'echo "Test fish running" >/dev/null' ; then
        export SHELL="$FISH_BIN"
        # echo "One can launch the fish shell by 'exec -l \$SHELL -l'"
        exec -l $SHELL -l   # launch the fish login shell
    else
        echo "Failed to launch fish shell. Go check its installation!"
        echo "Fall back to default shell $SHELL ..."
    fi
fi
