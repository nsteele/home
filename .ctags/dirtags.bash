#!/bin/bash

# Nick Steele, 11-10-16
# Script to be used in following command:
# find * -type d -exec ~/.dirtags.bash {} \;
# which will create a tags file at each sub-directory for that directory's files
# intended for c/c++ dev

if [ ! -z $1 ];then
	cd $1
fi
ctags --languages=c,c++ --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -o .tags *
