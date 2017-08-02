#!/bin/fish -eu

#######
# ROS #
#######

if test -d '/opt/ros'
    switch (uname)
        case Linux
            switch (lsb_release -sr)
                case '14.04'
                    bass source /opt/ros/indigo/setup.bash
                case '12.04'
                    bass source /opt/ros/hydro/setup.bash
            end
       source ~/.dotfiles/rosfish
    end

    function __fish_ros_topic_list
        rostopic list
    end
    function __fish_ros_msg_list
      rosmsg list
    end
    function __fish_ros_node_list
        rosnode list
    end
    function __fish_catkin_list
        catkin list -u
    end
    # rostopic completion
    complete -c rostopic -f -n '__fish_use_subcommand' -a 'echo' -d 'Print the topic msg'
    complete -c rostopic -f -n '__fish_use_subcommand' -a 'type' -d 'Print the topic type'
    complete -c rostopic -f -n '__fish_use_subcommand' -a 'list' -d 'Print the topic list'
    complete -c rostopic -f -n '__fish_use_subcommand' -a 'hz' -d 'Print the topic hz'
    complete -c rostopic -f -n '__fish_use_subcommand' -a 'bw' -d 'Print the topic bw'
    complete -c rostopic -f -n '__fish_use_subcommand' -a 'info' -d 'Print the topic info'
    complete -c rostopic -f -n '__fish_use_subcommand' -a 'pub' -d 'Publish a topic'
    complete -c rostopic -f -n '__fish_use_subcommand' -a 'find' -d 'Find a type of msgs'
    complete -f -c rostopic -n '__fish_seen_subcommand_from echo' -a '(__fish_ros_topic_list)'
    complete -f -c rostopic -n '__fish_seen_subcommand_from type' -a '(__fish_ros_topic_list)'
    complete -f -c rostopic -n '__fish_seen_subcommand_from hz' -a '(__fish_ros_topic_list)'
    complete -f -c rostopic -n '__fish_seen_subcommand_from info' -a '(__fish_ros_topic_list)'

    # echo
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -s 'b' -l 'bag' -d 'echo messages from .bag file'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -s 'p' -d 'echo in a plotting friendly format'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -s 'w' -d 'fixed width for numeric values'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -l 'filter' -d 'fixed width for numeric values'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -l 'nostr' -d 'exclude string fields'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -l 'noarr' -d 'exclude arrays'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -s 'c' -l 'clear' -d 'clear screen before printing next message'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -s 'a' -l 'all' -d 'display all message in bag, only valid with -b option'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -s 'n' -d 'number of messages to echo'
    complete -c rostopic -f -n '__fish_seen_subcommand_from echo' -l 'offset' -d 'display time as offsets from current time (in seconds)'

    # list
    complete -c rostopic -f -n '__fish_seen_subcommand_from list' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rostopic -f -n '__fish_seen_subcommand_from list' -s 'b' -l 'bag' -d 'list topics in .bag file'
    complete -c rostopic -f -n '__fish_seen_subcommand_from list' -s 'p' -d 'list only publishers'
    complete -c rostopic -f -n '__fish_seen_subcommand_from list' -s 's' -d 'list only subscribers'
    complete -c rostopic -f -n '__fish_seen_subcommand_from list' -l 'host' -d 'group by host name'
    complete -c rostopic -f -n '__fish_seen_subcommand_from list' -s 'v' -l 'verbose' -d 'list full details about each topic'

    # type
    complete -c rostopic -f -n '__fish_seen_subcommand_from type' -s 'h' -l 'help' -d 'show this help message and exit'

    # find
    complete -c rostopic -f -n '__fish_seen_subcommand_from find' -s 'h' -l 'help' -d 'show this help message and exit'

    # info
    complete -c rostopic -f -n '__fish_seen_subcommand_from info' -s 'h' -l 'help' -d 'show this help message and exit'

    # bw
    complete -c rostopic -f -n '__fish_seen_subcommand_from bw' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rostopic -f -n '__fish_seen_subcommand_from bw' -s 'w' -l 'window' -d 'window size, in # of messages, for calculating rate'

    # hz
    complete -c rostopic -f -n '__fish_seen_subcommand_from hz' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rostopic -f -n '__fish_seen_subcommand_from hz' -s 'w' -l 'window' -d 'window size, in # of messages, for calculating rate'
    complete -c rostopic -f -n '__fish_seen_subcommand_from hz' -l 'wall-time' -d 'calculates rate using wall time which can be helpful when clock isnt published during simulation'
    complete -c rostopic -f -n '__fish_seen_subcommand_from hz' -l 'filter' -d 'only measure messages matching the specified Python expression'

    # pub
    complete -c rostopic -f -n '__fish_seen_subcommand_from pub' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rostopic -f -n '__fish_seen_subcommand_from pub' -s 'v' -d 'print verbose output'
    complete -c rostopic -f -n '__fish_seen_subcommand_from pub' -s 'r' -l 'rate' -d 'publishing rate (hz).  For -f and stdin input, this'
    complete -c rostopic -f -n '__fish_seen_subcommand_from pub' -s '1' -l 'once' -d 'publish one message and exit'
    complete -c rostopic -n '__fish_seen_subcommand_from pub' -s 'f' -l 'file' -d 'read args from YAML file (Bagy)'
    complete -c rostopic -f -n '__fish_seen_subcommand_from pub' -s 'l' -l 'latch' -d 'enable latching for -f, -r and piped input.  This latches the first message.'
    complete -c rostopic -f -n '__fish_seen_subcommand_from pub' -s 's' -l 'substitute-keywords' -d 'When publishing with a rate, performs keyword ('now' or 'auto') substitution for each message'

    # rosnode completion
    complete -f -c rosnode -n '__fish_use_subcommand' -a 'cleanup'
    complete -f -c rosnode -n '__fish_use_subcommand' -a 'info'
    complete -f -c rosnode -n '__fish_use_subcommand' -a 'kill'
    complete -f -c rosnode -n '__fish_use_subcommand' -a 'machine'
    complete -f -c rosnode -n '__fish_use_subcommand' -a 'ping'

    # cleanup
    complete -c rostopic -f -n '__fish_seen_subcommand_from cleanup' -s 'h' -l 'help' -d 'show this help message and exit'

    # info
    complete -c rostopic -f -n '__fish_seen_subcommand_from info' -s 'h' -l 'help' -d 'show this help message and exit'

    # kill
    complete -c rostopic -f -n '__fish_seen_subcommand_from kill' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rostopic -f -n '__fish_seen_subcommand_from kill' -s 'a' -l 'all' -d 'kill all nodes'

    # machine
    complete -c rostopic -f -n '__fish_seen_subcommand_from machine' -s 'h' -l 'help' -d 'show this help message and exit'

    # ping
    complete -c rostopic -f -n '__fish_seen_subcommand_from ping' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rostopic -f -n '__fish_seen_subcommand_from ping' -s 'a' -l 'all' -d 'ping all nodes'
    complete -c rostopic -f -n '__fish_seen_subcommand_from ping' -s 'c' -l 'all' -d 'number of pings to send. Not available with --all'

    # catkin completion
    complete -f -c catkin -n '__fish_seen_subcommand_from b' -a '(__fish_catkin_list)'
    complete -f -c catkin -n '__fish_seen_subcommand_from build' -a '(__fish_catkin_list)'
    complete -f -c catkin -n '__fish_seen_subcommand_from clean' -a '(__fish_catkin_list)'

    abbr -a re 'rostopic echo'
    abbr -a ri 'rostopic info'
    abbr -a rt 'rostopic'

    abbr -a rc 'roscd'
    abbr -a rr 'rosrun'
    abbr -a rl 'roslaunch'
    # rostopic
    abbr -a rp 'rostopic'
    abbr -a rpb 'rostopic bw'
    abbr -a rpe 'rostopic echo'
    abbr -a rpt 'rostopic type'
    abbr -a rph 'rostopic hz'
    function rpen -d 'rostopic echo using peco'
        set --local topic (rostopic list | peco)
        rostopic echo $topic $argv
    end
    function rptn -d 'rostopic type using peco'
        set --local topic (rostopic list | peco)
        rostopic type $topic $argv
    end
    function rphn -d 'rostopic hz using peco'
        set --local topic (rostopic list | peco)
        rostopic hz $topic $argv
    end
    abbr -a rpi 'rostopic info'
    function ros_topic_info_detail
        echo '#################
# rostopic info #
#################
        '
        rostopic info $argv[1]
        echo '#################
# rostopic type #
#################
        '
        rostopic type $argv[1]
        echo '\n###############
# rosmsg show #
###############
        '
        rostopic type $argv[1] | rosmsg show
    end

    abbr -a rpid 'ros_topic_info_detail'
    abbr -a rpl 'rostopic list'
    # rosnode
    abbr -a rn 'rosnode'
    abbr -a rni 'rosnode info'
    abbr -a rnl 'rosnode list'
    abbr -a rnk 'rosnode kill'
    # rosservice
    abbr -a rs 'rosservice'
    abbr -a rsl 'rosservice list'
    # rqt_plugins
    abbr -a rqt_gui 'rosrun rqt_gui rqt_gui'
    abbr -a rqt_reconfigure 'rosrun rqt_reconfigure rqt_reconfigure'
    abbr -a rqt_image_view 'rosrun rqt_image_view rqt_image_view'
    abbr -a republish 'rosrun image_transport republish'
    function image_publisher
        rosrun jsk_perception image_publisher.py _file_name:=$argv[1]
    end

    # image_view
    function image_view
        rosrun image_view image_view image:=$argv[1]
    end

    function image_view2
        rosrun image_view2 image_view2 image:=$argv[1]
    end

    abbr -a imv 'image_view'
    abbr -a imv2 'image_view2'
    # nodelet
    abbr -a nodelet_standalone 'rosrun nodelet nodelet standalone'

    abbr -a tf 'cd /tmp and rosrun tf view_frames and evince frames.pdf'
    abbr -a tf_view 'rosrun tf view_frames'
end

# wstool
abbr -a ws wstool
abbr -a wsi 'wstool info -s'
abbr -a wscd 'wstool_cd'
abbr -a wsset 'wstool set'
abbr -a wsup 'wstool update'
abbr -a wsrm 'wstool remove'
abbr -a wslist 'wstool info --only=localname'
function wssethub
    wstool set $argv[1] https://github.com/$argv[1].git --git
end

# catkin-tools
abbr -a c 'catkin'
abbr -a cb 'catkin build'
abbr -a cbt 'catkin bt'
abbr -a cbts 'catkin bt --start-with-this'
abbr -a cbtsf 'catkin bt --start-with-this --force-cmake'
abbr -a cbtv 'catkin bt --verbose'
abbr -a crt 'catkin run_tests'
abbr -a crtt 'catkin run_tests --this --no-deps -iv'
abbr -a crl 'catkin roslint'
abbr -a crlt 'catkin roslint --this --no-deps -iv'
abbr -a cli 'catkin lint'

function imv
    rosrun image_view image_view image:=$argv[1]
end

if test -n '$EMACS'
else
    abbr -a roseus 'rlwrap -c -b "(){}.,;|" -a -pGREEN roseus'
    abbr -a irteus 'rlwrap -c irteus'
    abbr -a irteusgl 'rlwrap -c irteusgl'
end
