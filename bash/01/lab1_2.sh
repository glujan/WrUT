#!/bin/bash

# Append file's permissions and type to the end of it's name
# ie: file -> file.rw.f, dir -> dir.rwx.d, link -> link.w.l

if [ $# -ne 1 ] || [ ! -d $1 ]
then
  echo Provide a valid directory as an argument
  exit 1
fi

cd $1

for file in `ls -A`
do
  ext=''

  # chech for permissions
  if [ -r $file  ]
  then
    ext="${ext}r"
  fi

  if [ -w $file  ]
  then
    ext="${ext}w"
  fi

  if [ -x $file  ]
  then
    ext="${ext}x"
  fi

  if [ -z $ext ]
  then
    ext="."
  else
    ext=".${ext}."
  fi

  # First check if file is link. Dirs are also links!
  if [ -h $file ]
  then
    ext="${ext}l"
  elif [ -d $file ]
  then
    ext="${ext}d"
  else
    ext="${ext}f"
  fi

  #Finally, change file's name
  mv "${file}" "${file}${ext}"
done
