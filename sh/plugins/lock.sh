function lock () {
    case ${OSTYPE} in
        linux*)
            gnome-screensaver-command -l
            ;;
        darwin*)
            m lock
            ;;
    esac
}
