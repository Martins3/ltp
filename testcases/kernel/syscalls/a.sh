#!/bin/bash

function add_dune_enter() {
  dir=/home/loongson/ltp/testcases/kernel/syscalls/$1
  for cfile in $dir/*.c; do
    if [[ -f $cfile ]];then
      line=$(grep -n 'int main' $cfile | cut -d: -f 1)
      if [[ -z $line ]];then
        echo $cfile
        echo "old trandition ?"
      else
        echo $cfile
        echo $line
        let "next_line= $line + 1"
        echo $next_line

        sed -n -e $line,"$next_line"p $cfile
        exit
      fi
    else
      echo "TODO : need special attension"
    fi
  done
}

for i in ./*;do
  if [[ -d $i ]];then
    is=true
    for j in $i/*; do
      if [[ $j == *"dune-"* ]];then
        is=false
        break
      fi
    done

    if [[ "$is" = true ]]; then
      add_dune_enter $i
    fi
  fi
done

