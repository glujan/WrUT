#!/bin/bash

# Count number of files which have the same number of hard links.
# Get information only by `find`!

if [ $# -ne 1 ] || [ ! -d $1 ]; then
  echo Provide a valid directory as an argument
  exit 1
fi

echo "Using uniq:"
find $1 -printf "%n\n" | sort | uniq -c | while read z1 z2
do
  echo $z2 $z1
done

echo "Witout uniq:"
val=1
counter=0
find $1 -printf "%n\n" | sort | ( while read next_val
do
  if [ $val -eq $next_val ]; then
    let counter=counter+1
  else
    echo $val $counter
    val=$next_val
    counter=1
  fi
done
echo $val $counter
)
