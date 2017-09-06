#!/usr/bin/env fish

function _itunes_list_tracks
    echo 'tell application "iTunes"
    set accumulator to ""
    repeat with t in every track
    set output to "" & (id of t) & tab & "\"" & (name of t) & "\"" & tab & "\"" & (artist of t) & "\""
    set trackInfo to do shell script "echo " & quoted form of output without altering line endings
    set accumulator to accumulator & trackInfo
end repeat
end tell' | osascript
end

function _itunes_play_track
    set -l track (_itunes_list_tracks | peco --initial-filter Fuzzy | awk 'BEGIN {FS="\t"}; {print $2}')
    osascript -e (printf 'tell application "itunes" to play track %s' $track)
end


function itunes -d "Control iTunes. Use -h or --help for a more detailed description."
    if [ (count $argv) -gt 0 ]
        set -l opt $argv[1]
        switch $opt
            case status
                set state (osascript -e 'tell application "iTunes" to player state as string')
                echo -n "iTunes is currently "
                set_color green

                if [ $state = "paused" ]
                    set_color yellow
                else if [ $state = "stopped" ]
                    set_color red
                end

                echo "$state"
                set_color normal

                if [ $state = "playing" ]
                    set artist (osascript -e 'tell application "iTunes" to artist of current track as string')
                    set track (osascript -e 'tell application "iTunes" to name of current track as string')
                    echo -n "Current track "
                    set_color yellow
                    echo -n $artist
                    set_color normal
                    echo -n " - "
                    set_color yellow
                    echo "$track"
                    set_color normal
                end

                return 0
            case launch play pause stop quit
                #case shuffle
                #    set opt "set shuffle of current playlist to 1"
                #case order
                #    set opt "set shuffle of current playlist to 0"
            case mute
                set opt "set mute to true"
            case unmute
                set opt "set mute to false"
            case next previous
                set opt "$opt track"
            case vol volume
                set vol (osascript -e 'tell application "iTunes" to sound volume as integer')
                set newvol 100

                if [ $argv[2] = "up" ]
                    set newvol (math "$vol+10")
                else if [ $argv[2] = "down" ]
                    set newvol (math "$vol-10")
                else
                    set newvol $argv[2]
                end

                set opt "set sound volume to $newvol"
            case shuffle
                set opt "set shuffle enabled to true"
            case order
                set opt "set shuffle enabled to false"
            case "" -h --help -help
                __show_help
                return 0
            case '*'
                e_error "Unknown option '$opt'. Use -h or --help for a more detailed description."
                return 1
        end
        osascript -e "tell application \"iTunes\" to $opt"
    else
        e_error "No arguments given. Use -h or --help for a more detailed description."
    end
end


function __show_help
    echo 'Usage: itunes <option>'
    echo ''
    e_tabbed 'launch' 'Launch iTunes'
    e_tabbed 'quit' 'Quit iTunes'
    e_tabbed 'status' 'Show the current status'
    e_tabbed 'play' 'Start playback'
    e_tabbed 'pause' 'Pause playback'
    e_tabbed 'stop' 'Stop playback'
    e_tabbed 'shuffle' 'Shuffle playback'
    e_tabbed 'order' 'Playback in order'
    e_tabbed 'mute' 'Mute the volume'
    e_tabbed 'unmute' 'Umute the volume'
    e_tabbed 'next' 'Play the next track'
    e_tabbed 'previous' 'Play the previous track'
    e_tabbed 'vol <volume>' 'Set the volume, takes an argument from 0 to 100'
    e_tabbed 'vol up' 'Increases the volumn'
    e_tabbed 'vol down' 'Decreases the volumn'
    e_tabbed 'help' 'Show this message and exit'

    return 0
end


complete -c itunes -f -n '__fish_use_subcommand' -a 'help' -s h -l help -d 'Print the help and exit'
complete -c itunes -f -n '__fish_use_subcommand' -a 'status' -d 'Print the current information'
complete -c itunes -f -n '__fish_use_subcommand' -a 'launch' -d 'Launch iTunes'
complete -c itunes -f -n '__fish_use_subcommand' -a 'quit' -d 'Quit iTunes'
complete -c itunes -f -n '__fish_use_subcommand' -a 'play' -d 'Starts playback'
complete -c itunes -f -n '__fish_use_subcommand' -a 'pause' -d 'Pauses playback'
complete -c itunes -f -n '__fish_use_subcommand' -a 'next' -d 'Play the next track'
complete -c itunes -f -n '__fish_use_subcommand' -a 'previous' -d 'Play the previous track'
complete -c itunes -f -n '__fish_use_subcommand' -a 'pause' -d 'Pauses playback'
complete -c itunes -f -n '__fish_use_subcommand' -a 'stop' -d 'Stop playback'
complete -c itunes -f -n '__fish_use_subcommand' -a 'shuffle' -d 'Shuffle playback'
complete -c itunes -f -n '__fish_use_subcommand' -a 'order' -d 'Playback in order'
complete -c itunes -f -n '__fish_use_subcommand' -a 'mute' -d 'Mute the volume'
complete -c itunes -f -n '__fish_use_subcommand' -a 'unmute' -d 'Umute the volume'
complete -c itunes -f -n '__fish_use_subcommand' -a 'vol volume' -d 'Sets the volume'

complete -c itunes -f -n '__fish_seen_subcommand_from vol volume' -a 'up' -d 'Increase the volume'
complete -c itunes -f -n '__fish_seen_subcommand_from vol volume' -a 'down' -d 'Decrease the volume'
