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
