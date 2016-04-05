set history save on
set history size 10000
set history filename ~/.gdb_history
set print pretty on
set print static-members off
set charset ASCII
set prompt \001\033[;31mgdb$ \001\033[0m\002
set disassembly-flavor intel

define print_and_go
  printf $arg0, $arg1
  continue
end

# source ~/bin/peda/peda.py
