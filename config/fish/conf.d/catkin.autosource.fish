function catkinSource --on-variable PWD
    status --is-command-substitution; and return
    if test -e ".catkin_tools"; and test -e "devel/setup.bash"
        bass source devel/setup.bash
        echo "[ROS] Configured the folder as a catkin workspace"
    end
end
