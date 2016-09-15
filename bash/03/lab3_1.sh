#!/bin/bash

# Find links to files which were accessed between 5 hours and 2 minutes ago.

if [ $# -ne 1 ] || [ ! -d $1 ]; then
	echo Provide a valid directory as an argument
	exit 1
fi

find $1 -type l -xtype f -amin +1 -amin -301 -print
