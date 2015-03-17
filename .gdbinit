set history save on
set history size 10000
set history filename ~/.gdb_history
set print pretty on
set print static-members off
set charset ASCII

define print_and_go
  printf $arg0, $arg1
  continue
end
