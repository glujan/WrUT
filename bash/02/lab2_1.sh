#!/bin/bash

# Change relative links to absolute

if [ $# -ne 1 ] || [ ! -d $1 ]
then
  echo Provide a valid directory as an argument
  exit 1
fi
DIRPATH=$1
FILELIST=`ls -A ${DIRPATH}`

cd $DIRPATH
for file in ${FILELIST}
do
  file_path=`readlink "${file}"`
  if [ -h $file ] && [ ${file_path:0:1} != "/" ]
  then
    file_path=`readlink -f "${file}"`
    ln -s -f "${file_path}" "${file}"
  fi
done
