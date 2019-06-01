function ping -d "Ping with colorized output"
    _colorize ping $argv
end


function ping-with-timestamp -d "Timestamped ping"
    switch (count $argv)
        case 0
            bash -c 'ping $0 | while read pi; do echo "$(date \'+[%Y/%m/%d %H:%M:%S]\') $pi"; done' 8.8.8.8
        case '*'
            bash -c 'ping $0 | while read pi; do echo "$(date \'+[%Y/%m/%d %H:%M:%S]\') $pi"; done' $argv
    end
end


function !ping -d 'function of ping 8.8.8.8'
    ping 8.8.8.8 $argv
end
