# extend ghs

function options
    echo $argv | sed 's|--*|\\'\n'|g' | grep -v '^$'
end

function gpr
    switch (count $argv)
        case 0
            echo "Usage : gpi QUERY"
            return 1
        case '*'
            ghs $argv | peco | awk '{print $1}' | ghq import
    end
end

function gpd
    ghq list --full-path | peco | xargs rm -r
end


function gho
    set OPNE ""
    switch (uname)
        case Darwin
            set OPEN open
        case Linux
            set OPEN gnome-open
    end

    switch (count $argv)
        case 0
            echo "Usage : gho QUERY"
            return 1
        case '*'
            ghs $argv | peco | awk '{print "https://github.com/"$1}' | xargs $OPEN
    end
end

# TODO REFACTOR
function ghoi
    set OPNE ""
    switch (uname)
        case Darwin
            set OPEN open
        case Linux
            set OPEN gnome-open
    end

    switch (count $argv)
        case 0
            echo "Usage : gho QUERY"
            return 1
        case '*'
            ghs $argv | peco | awk '{print "https://github.com/"$1"/issues"}' | xargs $OPEN
    end
end

function ghop
    set OPNE ""
    switch (uname)
        case Darwin
            set OPEN open
        case Linux
            set OPEN gnome-open
    end

    switch (count $argv)
        case 0
            echo "Usage : gho QUERY"
            return 1
        case '*'
            ghs $argv | peco | awk '{print "https://github.com/"$1"/pulls"}' | xargs $OPEN
    end
end
