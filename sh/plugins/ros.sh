#!/bin/bash -eu

#######
# ROS #
#######

if [ -d "/opt/ros" ]; then
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
    ros_topic_info_detail() {
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
    }
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
    image_publisher () {
        rosrun jsk_perception image_publisher.py _file_name:=$1
    }
    # image_view
    image_view () {
        rosrun image_view image_view image:=$@
    }
    image_view2 () {
        rosrun image_view2 image_view2 image:=$@
    }
    _image_topics () {
        local -a reply
        if [[ ${CURRENT} = 2 ]]; then
            reply=($(rostopic find sensor_msgs/Image))
        fi
        _describe 'values' reply
    }
    if which compdef &>/dev/null; then
        compdef _image_topics image_view
        compdef _image_topics image_view2
    fi
    alias imv='image_view'
    alias imv2='image_view2'
    # nodelet
    alias nodelet_standalone='rosrun nodelet nodelet standalone'

    alias tf='cd /tmp && rosrun tf view_frames && evince frames.pdf &'
    alias tf_view='rosrun tf view_frames'
fi

# wstool
alias ws=wstool
alias wsi='wstool info -s'
alias wscd='wstool_cd'
alias wsset='wstool set'
alias wsup='wstool update'
alias wsrm='wstool remove'
alias wslist='wstool info --only=localname'
wssethub () {
    wstool set $1 https://github.com/$1.git --git
}
wsg () {
    if [ "$1" = "" ]; then
        exit 1
    fi
    USER_REPO=$(echo "$1" | sed -e 's/https:\/\/github.com\///g' | sed -e 's/git@github.com\///g')
    USER=$(echo $USER_REPO | sed -e "s/\// /g" | awk '{print $1}')
    REPOSITORY=$(echo $USER_REPO | sed -e "s/\// /g" | awk '{print $2}')
    if [ "$REPOSITORY" = "" ]; then
        REPOSITORY="$USER"
        wstool set $REPOSITORY https://github.com/$REPOSITORY --git -y -u
    else
        wstool set $REPOSITORY https://github.com/$USER/$REPOSITORY --git -y -u
    fi
    if [ $TMP -eq 1 ]; then
        echo "Removing"
        wstool remove $REPOSITORY
    elif [ $TMP -eq 2 ]; then
        echo "Update"
        wstool up $REPOSITORY
    fi
}

# bag file
function bag2csv() {
    if [ "$3" = "" ]; then
        CSV_FILENAME=$(echo $1 | sed 's/\.[^\.]*$//')".csv"
    else
        CSV_FILENAME=$3
    fi
    rostopic echo -b $1 -p $2 > $CSV_FILENAME
}

# catkin-tools
alias c='catkin'
alias cb='catkin build'
alias cbt='catkin bt'
alias cbts='catkin bt --start-with-this'
alias cbtv='catkin bt --verbose'
alias crt='catkin run_tests'
alias crtt='catkin run_tests --this --no-deps -iv'
alias crl='catkin roslint'
alias crlt='catkin roslint --this --no-deps -iv'
alias cli='catkin lint'

function imv() {
    rosrun image_view image_view image:=$1
}

function rosshell() {
    emacs-snapshot -nw --eval '(progn (shell) (rename-buffer "*roseus*") (auto-complete-mode) (spacemacs/toggle-smartparens-on) (delete-other-windows) (insert "\\roseus") (comint-send-input) (comint-send-input))'
}
if [ "$INSIDE_EMACS" ]; then
    :
else
    alias roseus="rlwrap -c -b '(){}.,;|' -a -pGREEN roseus"
    alias irteus='rlwrap -c irteus'
    alias irteusgl='rlwrap -c irteusgl'
fi

# source /opt/ros
case ${OSTYPE} in
    linux*)
        if [ -n "$ZSH_VERSION" ]; then
            CURRENT_SHELL='zsh'
        elif [ -n "$BASH_VERSION" ]; then
            CURRENT_SHELL='bash'
        fi

        if [ -e /opt/ros ]; then # if ros exists ...
            # ros setting
            VER=$(lsb_release -sr)
            case ${VER} in
                14.04)
                    if [ -e /opt/ros/indigo/setup.${CURRENT_SHELL} ]; then
                        source /opt/ros/indigo/setup.${CURRENT_SHELL}
                    fi
                    ;;
                12.04)
                    if [ -e /opt/ros/indigo/setup.${CURRENT_SHELL} ]; then
                        source /opt/ros/indigo/setup.${CURRENT_SHELL}
                    fi
                    ;;
            esac
            source `catkin locate --shell-verbs`
            source `rospack find jsk_tools`/src/${CURRENT_SHELL}rc.ros
            rossetip

            alias cs='catkin source'
            alias cso='source /opt/ros/indigo/setup.$CURRENT_SHELL'
        fi
        ;;
    darwin*)
        ;;
esac
