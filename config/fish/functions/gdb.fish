function gdb --wraps=gdb -d "suppress gdb init messages"
    command gdb -q $argv
end
