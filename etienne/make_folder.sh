#! /bin/bash
#
# Programme that makes a MATLAB script folder
# in ~/proj/etienne/ together with generating the
# startup.m file, the figs directories and the README file
# ======================================================================

folder="$1"
parent="$HOME/proj/etienne/"

	# make sure program starts form ~/proj/etienne/
cd $parent

	# first make the MATLAB script folder in question
mkdir $folder

	# creates README file
touch "$folder/README"
echo -e "\nLast Updated : \n\nin ~/proj/etienne/"$folder "\n\n\n\
=====================================================================" \
> "$folder/README"

	# creates figs directories
mkdir -p $folder/figs/{eps,png}
mkdir $folder/figs/png/archives/

	# find the latest verison of script_folder/startup.m 
tmp='tmp.txt'
touch $tmp
ls -t $parent/*/startup.m | head -1 > $tmp
cp $(cat $tmp) $folder
rm $tmp

## I could also make a softlink to the most recent startup.m
## make a procedure that syncs it to all script folders.
