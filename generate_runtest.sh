#!/bin/bash
INPUT_FILE=/home/maritns3/core/4000/ltp/runtest/syscalls
OUTPUT=/home/maritns3/core/4000/ltp/runtest/syscalls-dune

rm -f $OUTPUT
var=1

while read -r line; do
  if [[ -z $line ]];then
    echo "" >> $OUTPUT
    continue
  fi
  words=( $line )
  echo "${words[0]} dune-${words[1]} ${words[@]:2}" >> $OUTPUT
  var=$((var + 1))
done < $INPUT_FILE
echo $var


