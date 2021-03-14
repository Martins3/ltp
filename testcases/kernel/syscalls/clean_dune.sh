#!/bin/bash

for i in ./*;do
  if [[ -d $i ]];then
    rm -rf dune-*
  fi
done
