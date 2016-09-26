#! /bin/bash
#
# Program that plots a world map using gnuplot and ./worldmap.dat
# 
#	Gnuplot allows to indentify longitude/latitude points using the
#	cursor in the 'wxt' terminal.
# 
# ======================================================================


	# data location (subject to change)
datafile="worldmap.dat"

	# echo gnuplot command into a temporary file
( echo 'set terminal wxt size 1000,600'
	echo "plot \"$datafile\"" 
	echo 'pause -1' ) > .tmp.gp

	# run gnuplot --- Press <enter> to exit figure.
gnuplot .tmp.gp

	# remove temporary file
rm .tmp.gp
