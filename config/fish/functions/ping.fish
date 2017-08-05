function ping -d "Ping with colorized output"
    _colorize ping $argv
end

function ifconfig -d "ifconfig with colorized output"
  _colorize ifconfig $argv
end

function ip -d "ip with colorized output"
  _colorize ip $argv
end
