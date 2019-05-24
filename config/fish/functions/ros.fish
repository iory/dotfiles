#!/bin/fish -eu

#######
# ROS #
#######

if test -d '/opt/ros'
    switch (uname)
        case Linux
            switch (lsb_release -sr)
                case '16.04'
                    bass source /opt/ros/kinetic/setup.bash
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
    function __fish_ros_msg_package_list
      rosmsg packages
    end
    function __fish_ros_node_list
        rosnode list
    end
    function __fish_ros_node_machine_list
      rosnode machine
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

    complete -f -c rosnode -n '__fish_seen_subcommand_from ping' -a '(__fish_ros_node_list)'
    complete -f -c rosnode -n '__fish_seen_subcommand_from info' -a '(__fish_ros_node_list)'
    complete -f -c rosnode -n '__fish_seen_subcommand_from kill' -a '(__fish_ros_node_list)'
    complete -f -c rosnode -n '__fish_seen_subcommand_from machine' -a '(__fish_ros_node_machine_list)'

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

    # rosmsg completion
    complete -c rosmsg -f -n '__fish_use_subcommand' -a 'show' -d 'Show message description'
    complete -c rosmsg -f -n '__fish_use_subcommand' -a 'list' -d 'List all messages'
    complete -c rosmsg -f -n '__fish_use_subcommand' -a 'md5' -d 'Display message md5sum'
    complete -c rosmsg -f -n '__fish_use_subcommand' -a 'package' -d 'List messages in a package'
    complete -c rosmsg -f -n '__fish_use_subcommand' -a 'packages' -d 'List packages that contain messages'

    complete -f -c rosmsg -n '__fish_seen_subcommand_from show' -a '(__fish_ros_msg_list)'
    complete -f -c rosmsg -n '__fish_seen_subcommand_from md5' -a '(__fish_ros_msg_list)'
    complete -f -c rosmsg -n '__fish_seen_subcommand_from package' -a '(__fish_ros_msg_package_list)'

    # list
    complete -c rosmsg -f -n '__fish_seen_subcommand_from list' -s 'h' -l 'help' -d 'show this help message and exit'

    # show
    complete -c rosmsg -f -n '__fish_seen_subcommand_from show' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rosmsg -f -n '__fish_seen_subcommand_from show' -s 'r' -l 'raw' -d 'show raw message text, including comments'
    complete -c rosmsg -f -n '__fish_seen_subcommand_from show' -s 'b' -l 'bag' -d 'show message from .bag file'

    # md5
    complete -c rosmsg -f -n '__fish_seen_subcommand_from md5' -s 'h' -l 'help' -d 'show this help message and exit'

    # package
    complete -c rosmsg -f -n '__fish_seen_subcommand_from package' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rosmsg -f -n '__fish_seen_subcommand_from package' -s 's' -d 'list all msgs on a single line'

    # packages
    complete -c rosmsg -f -n '__fish_seen_subcommand_from packages' -s 'h' -l 'help' -d 'show this help message and exit'
    complete -c rosmsg -f -n '__fish_seen_subcommand_from packages' -s 's' -d 'list all msgs on a single line'


    # rosbag completion
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'check' -d 'Determine whether a bag is playable in the current system, or if it can be migrated.'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'compress' -d 'Compress one or more bag files.'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'decompress' -d 'Decompress one or more bag files.'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'filter' -d 'Filter the contents of the bag.'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'fix' -d 'Repair the messages in a bag file so that it can be played in the current system.'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'help' -d 'show this help message and exit'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'info' -d 'Summarize the contents of one or more bag files.'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'play' -d 'Play back the contents of one or more bag files in a time-synchronized fashion.'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'record' -d 'Record a bag file with the contents of specified topics.'
    complete -c rosbag -f -n '__fish_use_subcommand' -a 'reindex' -d 'Reindexes one or more bag files.'

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
    function tf_list -d 'list up tf in plain text'
        switch (count $argv)
            case 1
                set n $argv[1]
            case '*'
                set n 100
        end
        rostopic echo /tf -n $n | grep -e "child_frame_id" -e "frame_id" | cut -d ':' -f2 | cut -d ' ' -f2 | sort | uniq
    end


    function peco_select_chq_workspace
        set -l query (commandline)

        if test -n $query
            set peco_flags --query "$query"
        end

        chq list | peco $peco_flags | read line

        if [ $line ]
            cd $line
            commandline -f repaint
            catkin list -u | peco $peco_flags | read line
            if [ $line ]
                cd (catkin locate $line)
                commandline -f repaint
            end
        end
    end

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
abbr -a ca 'catkin'
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
abbr -a cs 'bass source (catkin locate)/devel/setup.bash'
abbr -a cso 'bass source /opt/ros/kinetic/setup.bash'
abbr -a cr 'cd (catkin locate)'


function imv
    rosrun image_view image_view image:=$argv[1]
end

if test -n '$EMACS'
    abbr -a roseus 'rlwrap -c -b "(){}.,;|" -a -pGREEN roseus'
    abbr -a irteus 'rlwrap -c irteus'
    abbr -a irteusgl 'rlwrap -c irteusgl'
end


function catkin --wraps=catkin
    for path in $PATH
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_PATH $NEW_PATH $path
        end
    end

    for path in (string split : $LD_LIBRARY_PATH)
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_LD_PATH "$NEW_LD_PATH":"$path"
        end
    end

    for path in (string split : $LIBRARY_PATH)
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_LIBRARY_PATH "$NEW_LIBRARY_PATH":"$path"
        end
    end

    # echo $NEW_LD_PATH
    if [ $argv[1] = "source" ]
        set -gx PATH $NEW_PATH; set -gx LD_LIBRARY_PATH $NEW_LD_PATH; set -x LIBRARY_PATH $NEW_LIBRARY_PATH; set -gx  SHELL /bin/bash; command catkin $argv
    else
        set -lx PATH $NEW_PATH; set -lx LD_LIBRARY_PATH $NEW_LD_PATH; set -x LIBRARY_PATH $NEW_LIBRARY_PATH; set -lx  SHELL /bin/bash; command catkin $argv
    end
end


function rosdep --wraps=rosdep
    for path in $PATH
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_PATH $NEW_PATH $path
        end
    end

    for path in (string split : $LD_LIBRARY_PATH)
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_LD_PATH "$NEW_LD_PATH":"$path"
        end
    end

    set -gx PATH $NEW_PATH; set -gx LD_LIBRARY_PATH $NEW_LD_PATH; set -gx  SHELL /bin/bash; command rosdep $argv
end


function roslaunch --wraps=roslaunch
    for path in $PATH
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_PATH $NEW_PATH $path
        end
    end

    for path in (string split : $LD_LIBRARY_PATH)
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_LD_PATH "$NEW_LD_PATH":"$path"
        end
    end
    set -lx PATH $NEW_PATH; set -lx LD_LIBRARY_PATH $NEW_LD_PATH; set -lx  SHELL /bin/bash; command roslaunch $argv
end


function rosrun --wraps=rosrun
    for path in $PATH
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_PATH $NEW_PATH $path
        end
    end

    for path in (string split : $LD_LIBRARY_PATH)
        string match -rq 'linuxbrew|pyenv' $path
        if test $status -eq 0
        else
            set -x NEW_LD_PATH "$NEW_LD_PATH":"$path"
        end
    end

    set -lx PATH $NEW_PATH; set -lx LD_LIBRARY_PATH $NEW_LD_PATH; set -lx  SHELL /bin/bash; command rosrun $argv
end
