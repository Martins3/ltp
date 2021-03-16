#!/bin/bash

set -e
function add_dune_enter() {
  dir=/home/loongson/ltp/testcases/kernel/syscalls/$1
  for cfile in $dir/*.c; do
    if [[ ! -f $cfile ]];then
      echo $cfile
    fi
  done
}

for i in ./*;do
  if [[ -d $i ]];then
    add_dune_enter $i
  fi
done
