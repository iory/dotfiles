#!/bin/fish -eu

#######
# ROS #
#######

if test -d "/opt/ros"
    alias re="rostopic echo"
    alias ri="rostopic info"
    alias rt="rostopic"

    alias rc='roscd'
    alias rr='rosrun'
    alias rl='roslaunch'
    # rostopic
    alias rp='rostopic'
    alias rpb='rostopic bw'
    alias rpe='rostopic echo'
    alias rpt='rostopic type'
    alias rph='rostopic hz'
    alias rpi='rostopic info'
    function ros_topic_info_detail
        echo '#################
# rostopic info #
#################
        '
        rostopic info $1
        echo '#################
# rostopic type #
#################
        '
        rostopic type $1
        echo '\n###############
# rosmsg show #
###############
        '
        rostopic type $1 | rosmsg show
    end

    alias rpid='ros_topic_info_detail'
    alias rpl='rostopic list'
    # rosnode
    alias rn='rosnode'
    alias rni='rosnode info'
    alias rnl='rosnode list'
    alias rnk='rosnode kill'
    # rosservice
    alias rs='rosservice'
    alias rsl='rosservice list'
    # rqt_plugins
    alias rqt_gui='rosrun rqt_gui rqt_gui'
    alias rqt_reconfigure='rosrun rqt_reconfigure rqt_reconfigure'
    alias rqt_image_view='rosrun rqt_image_view rqt_image_view'
    alias republish='rosrun image_transport republish'
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

    # _image_topics () {
    # local -a reply
    # if [[ ${CURRENT} = 2 ]]; then
    #     reply=($(rostopic find sensor_msgs/Image))
    #     fi
    #     _describe 'values' reply
    #     }
#     if which compdef &>/dev/null; then
#         compdef _image_topics image_view
#         compdef _image_topics image_view2
#         fi
    alias imv='image_view'
    alias imv2='image_view2'
    # nodelet
    alias nodelet_standalone='rosrun nodelet nodelet standalone'

    alias tf='cd /tmp and rosrun tf view_frames and evince frames.pdf'
    alias tf_view='rosrun tf view_frames'
end

# wstool
alias ws=wstool
alias wsi='wstool info -s'
alias wscd='wstool_cd'
alias wsset='wstool set'
alias wsup='wstool update'
alias wsrm='wstool remove'
alias wslist='wstool info --only=localname'
function wssethub
    wstool set $argv[1] https://github.com/$argv[1].git --git
end
#         wsg () {
#         if [ "$1" = "" ]; then
#             exit 1
#             fi
#             USER_REPO=$(echo "$1" | sed -e 's/https:\/\/github.com\///g' | sed -e 's/git@github.com\///g')
#             USER=$(echo $USER_REPO | sed -e "s/\// /g" | awk '{print $1}')
#             REPOSITORY=$(echo $USER_REPO | sed -e "s/\// /g" | awk '{print $2}')
#             if [ "$REPOSITORY" = "" ]; then
#                 REPOSITORY="$USER"
#                 wstool set $REPOSITORY https://github.com/$REPOSITORY --git -y -u
#             else
#                 wstool set $REPOSITORY https://github.com/$USER/$REPOSITORY --git -y -u
#                 fi
#                 if [ $TMP -eq 1 ]; then
#                     echo "Removing"
#                     wstool remove $REPOSITORY
#                     elif [ $TMP -eq 2 ]; then
#                     echo "Update"
#                     wstool up $REPOSITORY
#                     fi
#                     }

# catkin-tools
alias c='catkin'
alias cb='catkin build'
alias cbt='catkin bt'
alias cbts='catkin bt --start-with-this'
alias cbtsf='catkin bt --start-with-this --force-cmake'
alias cbtv='catkin bt --verbose'
alias crt='catkin run_tests'
alias crtt='catkin run_tests --this --no-deps -iv'
alias crl='catkin roslint'
alias crlt='catkin roslint --this --no-deps -iv'
alias cli='catkin lint'

function imv
    rosrun image_view image_view image:=$argv[1]
end

if [ "$EMACS" ]; then
    :
else
    alias roseus="rlwrap -c -b '(){}.,;|' -a -pGREEN roseus"
    alias irteus='rlwrap -c irteus'
    alias irteusgl='rlwrap -c irteusgl'
end

switch (uname)
    case Linux
        if test -e "/opt/ros"
            # ros setting
            switch (lsb_release -sr)
                case "14.04"
                    bash /opt/ros/indigo/setup.bash
                case "12.04"
                    bash /opt/ros/hydro/setup.bash
            end
        end
    case Darwin
        :
end
