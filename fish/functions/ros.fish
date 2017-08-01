#!/bin/fish -eu

#######
# ROS #
#######

if test -d '/opt/ros'
    source ~/.dotfiles/rosfish
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

switch (uname)
    case Linux
        if test -d '/opt/ros'
            # ros setting
            switch (lsb_release -sr)
                case '14.04'
                    bash /opt/ros/indigo/setup.bash
                case '12.04'
                    bash /opt/ros/hydro/setup.bash
            end
        end
    case Darwin
end
