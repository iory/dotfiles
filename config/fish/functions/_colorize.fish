function _colorize -d "Colorize command output via grc"
    # See: /usr/local/etc/grc.bashrc
    if type -q grc
        grc -es --colour=auto $argv
    else
        command $argv
    end
end
