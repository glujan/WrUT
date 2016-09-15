#!/bin/bash

# For both directories create realtive symbolic links to files which aren't
# present in current directory but are in another one AND are present on files
# list. Do not browse subdirectories.
# Files names in list are in one line, ie: file1 file2 file4

function create_link {
  DIR1=$1
  DIR2=$2
  file=$3
  if [ -e "${DIR1}/${file}" ] && [ ! -h "${DIR1}/${file}" ]
  then
    cd "${DIR2}"
    if [ -e "${DIR2}/${file}" ]
    then
      ln -sf "${DIR1}/${file}" "${file}_link"
    else
      ln -s "${DIR1}/${file}" "${file}"
    fi
  fi
}

if [ $# -ne 3 ] || [ ! -d $1 ] || [ ! -d $2 ] || [ ! -e $3 ]
then
  echo Provide 2 valid directories and a file with a list as an arguments
  exit 1
fi

DIR1=`readlink -f ${1}`
DIR2=`readlink -f ${2}`
FILE_LIST=`cat ${3}`

for file in ${FILE_LIST}
do
  create_link "${DIR1}" "${DIR2}" "${file}"
  create_link "${DIR2}" "${DIR1}" "${file}"
done
