#! /bin/bash
#
# Program that downloads all fields needed for the toy model form the
# NCEP-DOE archives:
#
# http://www.esrl.noaa.gov/psd/data/gridded/data.ncep.reanalysis2.html
#
# Rearrangement to match GCM output terminology and time selectiong
# is done in ./ncep_doe_rearrange.sh
#
# ======================================================================

# The part of the URL before the variable name
PRE1="ftp://ftp.cdc.noaa.gov/Datasets/"
PRE2="ncep.reanalysis2.derived/gaussian_grid/"

# The part of the URL after the variable name (for monthly mean
# quantities)
POST=".mon.mean.nc"

# NetCDF Extension that I use
EXT=".cdf"

# Variables to be downloaded, same `names' as in the archives
NAMES=("air.2m" "soilw.0-10cm" "runof.sfc" "dlwrf.sfc" "dswrf.sfc" \
       "lhtfl.sfc" "prate.sfc" "shtfl.sfc" "ulwrf.sfc" "uswrf.sfc" \
       "skt.sfc")
# ----------------------------------------------------------------------


# Looping through the variables
for ((i=0;i<${#NAMES[@]};i++)); do

	echo -e "\n" downloading ... ${NAMES[i]} "\n"

  # downloading 
	wget $PRE1$PRE2${NAMES[i]}$POST

  # renaming, removing the {.2m,.sfc} suffixes
  out="${NAMES[i]%.*}$EXT"
	mv ${NAMES[i]}$POST $out
		
  # move to nobackup/
	mv $out ~/nobackup/data/ncep_doe/
	
done

# ======================================================================
