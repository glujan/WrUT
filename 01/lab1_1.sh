#!/bin/bash

# Remove all *.old files in given directory and then append ".old" to all
# writeable files in given directory

if [ $# -ne 1 ] || [ ! -d $1 ]
then
  echo Provide a valid directory as an argument
  exit 1
fi

cd $1
rm -rf *.old

for file in *
do
  if [ -w "$file" ]
  then
    mv "$file" "${file}.old"
  fi
done

