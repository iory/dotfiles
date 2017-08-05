function lock
    switch (uname)
        case Darwin
            command m lock
        case Linux
            gnome-screensaver-command -l
    end
end
