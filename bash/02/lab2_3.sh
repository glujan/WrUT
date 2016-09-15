#!/bin/bash

# Move links from one directory to another. Keep eye on relative links and
# fix them if needed.

if [ $# -ne 2 ] || [ ! -d $1 ] || [ ! -d $2 ]
then
	echo Provide 2 valid directories as an arguments
	exit 1
fi

DIR0=`pwd`
DIR1=`readlink -f $1`
DIR2=`readlink -f $2`

function get_path() {
	common_part=$1
	dest=$2
	back=
	while [ "${dest#$common_part}" = "${dest}" ]; do
		common_part=$(dirname $common_part)
		back="../${back}"
	done

	echo "${back}${dest#$common_part/}"
}

cd $DIR1
for file in `ls .`
do
	if [ -h $file ]; then
		location=`readlink $file`
		if [ ${location:0:1} == "/" ]; then
			mv "${file}" "${DIR2}"
		else
			location=`readlink -m $file`
			result=$(get_path "$DIR2" "$location")
			cd $DIR2
			ln -sf "$result" "$file"
			cd - > /dev/null
		fi
	fi
done
