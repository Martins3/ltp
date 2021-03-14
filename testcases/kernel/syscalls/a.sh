#!/bin/bash

function add_dune_enter() {
  dir=/home/loongson/ltp/testcases/kernel/syscalls/$1
  for cfile in dir/*.c; do

    
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

