#! /bin/bash
#
# Program that downloads all tas and precip from U. of Delawere
# observations data set
#
# ======================================================================

# The part of the URL before the variable name
PRE1="ftp://ftp.cdc.noaa.gov/Datasets/"
PRE2="ncep.reanalysis2.derived/gaussian_grid/"

PRE1="ftp://ftp.cdc.noaa.gov/Datasets/"
PRE2="udel.airt.precip/"

# Variables to be downloaded, same `names' as in archives
NAMES=("air.mon.mean.v301.nc" "precip.mon.total.v301.nc")

## keep full name here

# ----------------------------------------------------------------------


# Looping through the variables
for ((i=0;i<${#NAMES[@]};i++)); do

	echo -e "\n" downloading ... ${NAMES[i]} "\n"

		# downloading 
	wget $PRE1$PRE2${NAMES[i]}$POST

		# renaming
	mv ${NAMES[i]}$POST ${NAMES[i]}
		
		# move to nobackup/
	mv ${NAMES[i]}$EXT ~/nobackup/data/obs/
	
done

# ======================================================================
