#! /bin/bash
#
# Program that downloads from the IRIDL LDEO CMIP2 data bank
# all the variables needed for computations
#
# It makes use of the URL generated by the website (in non-expert mode)
# with the wanted data set and time range and subsitutes the for the
# the other variables needed.
# ======================================================================

# The part of the URL before the variable name
PRE1="http://iridl.ldeo.columbia.edu/SOURCES/.WCRP/.CMIP3/%28ipcc4/"
PRE2="20c3m%29%40%40/%28ipcc4/20c3m/ncar_ccsm3_0%29%40%40/"
PRE3=".pcmdi.ipcc4.ncar_ccsm3_0.20c3m.run1.atm.mo.xml/."

# The part of the URL after the variable name
POST="/time/718700.5/729984.5/RANGE/data.cdf"

# NetCDF Extension 
EXT=".cdf"

# The variables to be downloaded
#VARS=("tas" "rlds" "rlus" "rsds" "rsus" "mrro" "mrros" \
#"mrso" "mrsos" "pr" "hfss" "hfls")

#VARS=("prc")
#VARS=("mrfso" "snw")
#VARS=("ua" "va")
#VARS=("ts")
VARS=("huss")

# Looping through the variables
for ((i=0;i<${#VARS[@]};i++)); do

	echo -e "\n" downloading ... ${VARS[i]} "\n"

		# downloading 
	wget $PRE1$PRE2$PRE3${VARS[i]}$POST

		# renaming
	mv data$EXT ${VARS[i]}$EXT
		
		# move to nobackup/
	mv ${VARS[i]}$EXT ~/nobackup/data/ccsm3/
	
done
