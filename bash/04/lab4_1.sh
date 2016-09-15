#!/bin/bash

# Using find and while: for each directory print canonical path, link - acceess
# date and value of link, file - inode number and size in kB

if [ $# -ne 1 ] || [ ! -d $1 ]; then
  echo Provide a valid directory as an argument
  exit 1
fi

find $1 -printf "%y %i %s %TD %p %l\n" | sort | while read t inode size d f l; do
  if [ $t = "d" ]; then
    echo `readlink -f $f`
  elif [ $t = "f" ]; then
    size=`expr $size / 1024`
    echo $inode $size
  elif [ $t = "l" ]; then
    echo $d $l
  fi;
done;
