#!/bin/bash

set -e
function add_dune_enter() {
  dir=/home/loongson/ltp/testcases/kernel/syscalls/$1
  for cfile in $dir/*.c; do
    if [[ -f $cfile ]];then
      echo $cfile
      line=$(grep -n 'int main' $cfile | cut -d: -f 1)
      if [[ -z $line ]];then
        echo $cfile
        echo "old trandition ?"
      else
        echo $cfile
        echo $line
        for line_num in $line;do
          let "next_line= $line_num + 2"
          echo $next_line
          # sed -n -e $line,"$next_line"p $cfile
          sed -i "$next_line i #ifdef DUNE\n if(dune_enter()){\n return 1;\n }\n#endif" $cfile
        done
      fi
    else
      echo "TODO : need special attension"
    fi
  done
}

for i in ./*;do
  if [[ -d $i ]];then
    add_dune_enter $i
  fi
done

