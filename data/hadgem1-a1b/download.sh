#! /bin/bash
#
# Program that downloads from the IRIDL LDEO CMIP3 data bank
# all the variables needed for computations
#
# It makes use of the URL generated by the website (in non-expert mode)
# with the wanted data set and time range and subsitutes the for the
# the other variables needed.
#
#	--- This is version is for the HadGEM1 SRES A1B
#
# ======================================================================


# The part of the URL before the variable name
PRE1="http://iridl.ldeo.columbia.edu/SOURCES/.WCRP/.CMIP3/%28ipcc4/"
PRE2="sresa1b%29%40%40/%28ipcc4/sresa1b/ukmo_hadgem1%29%40%40/"
PRE3=".pcmdi.ipcc4.ukmo_hadgem1.sresa1b.run1.atm.mo.xml/."

# The part of the URL after the variable name
#POST="/time/39255.0/50385.0/RANGE/data.cdf"
#POST1="/time/%28Jan%202070%29%280028%201%20Nov%202100%20"
#POST2="-%200016%201%20Dec%202100%29RANGEEDGES/data.cdf"

# Select years
year_start='2069'
year_end='2099' 

# NetCDF Extension 
EXT=".cdf"

# The variables to be downloaded
VARS=("tas" "mrsos")
#VARS=("mrsos")

# Looping through the variables
for ((i=0;i<${#VARS[@]};i++)); do

	echo -e "\n" downloading ... ${VARS[i]} "\n"

	# downloading 
#	wget $PRE1$PRE2$PRE3${VARS[i]}$POST1$POST2
	wget $PRE1$PRE2$PRE3${VARS[i]}/data.cdf

  # use cdo to trim year (and rename)
  cdo selyear,$year_start/$year_end data$EXT ${VARS[i]}$EXT
  rm data$EXT

	# move to nobackup/
	mv ${VARS[i]}$EXT ~/nobackup/data/hadgem1-a1b/

done