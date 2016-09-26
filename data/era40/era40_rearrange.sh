#! /bin/bash
#
# Script that
#
#  split `output.nc' (from download) into multiple files,
#  convert and rename variables to match the GCMs' 
#  nomenclature, units and South-to-North latitudes
#
# This script uses the 'cdo' tools available at :
# https://code.zmaw.de/projects/cdo/
#
# as well as the 'ncatted' tool.
#
# Note that 'cumulated flux' quantities are converted to 'per s' 
# using the 'forecast step' of 6 hours.
# See ./info_from_ecmwf_website/era_get_fluxes.png for more info.
#
# ======================================================================

# a few definitions
folder="$HOME/nobackup/data/era40/"
original="output.nc"
data="tmp.output"
ext=".cdf"
tmp_pre="tmp."
tmp_vars="/tmp/vars"
tmp_grid="/tmp/grid"

# a 'echo&eval command' function
echo_eval()
{
  echo -e "\$ $1"
  eval $1
  echo ""
}

# a 'cdo overwrite' function (with 32 bit precession)
cdo_O()
{
  tmp='/tmp/cdo_O'
  cdo -b 32 $1 $2 $tmp
  mv  $tmp $2
}

# a 'ncatted' function for name and units
my_ncatted()
{
  # $1: var name, $2: "'long_name'", $3: "'units'"
  echo_eval "ncatted -O -a long_name,$1,o,c,$2 $1$ext"
  echo_eval "ncatted -O -a units,$1,o,c,$3 $1$ext"
}
# ----------------------------------------------------------------------

## Change directory to data folder, make a copy of the original data
echo -ne "In $folder : \n"
cd $folder
cp $original $data
echo ""
# ----------------------------------------------------------------------


## Rename `longitude',`latitude' to `lon',`lat' and invert latitudes
# using griddes, sed and setgrid then invertlat

cdo griddes $data | \
sed 's/longitude/lon/' | sed 's/latitude/lat/' > $tmp_grid 

cmd="cdo_O setgrid,$tmp_grid $data"
echo_eval "$cmd"

cmd="cdo_O invertlat $data"
echo_eval "$cmd"
# ----------------------------------------------------------------------

## Convert and rename varaible in $data
## *** I couldn't get the cdo `setunit' to work ...

# 2m air temperature: change name to `tas'
cmd="cdo_O chname,t2m,tas $data"
echo_eval "$cmd"

# Precip: add `convective' and `large-scale' precipitation
# convert to flux (mm/s)
# Note that `expr' put the results in the separate file,
# delete `cp' and `lsp' in $data
# set description
cmd="cdo expr,'pr=1000*(cp+lsp)/(6*60*60);' $data pr.cdf"
echo_eval "$cmd"
cmd="cdo_O delname,cp,lsp $data"
echo_eval "$cmd"
my_ncatted pr "'precip. flux'" "'mm s-1'"

# volumetric soil moisture, in `./era40_convert_soil_mois.sh'

# runoff, in `./era40_convert_runoff.sh'

# bnd-layer depth, leave unchanged (for now)
# evaporation, leave unchanged  (for now)

# Surface latent heat flux; change name to 'hfls',  Wm-2 
# and downward
cmd="cdo expr,'hfls=-slhf/(6*60*60);' $data hfls.cdf"
echo_eval "$cmd"
cmd="cdo_O delname,slhf $data"
echo_eval "$cmd"
my_ncatted hfls "'surface upward latent heat flux'" "'W m-2'"

# Surface sensible heat flux; change name to 'hfss' Wm-2
# and downward
cmd="cdo expr,'hfss=-sshf/(6*60*60);' $data hfss.cdf"
echo_eval "$cmd"
cmd="cdo_O delname,sshf $data"
echo_eval "$cmd"
my_ncatted hfss "'surface upward sensible heat flux'" "'W m-2'"

# Surface shortwave upward radiation from net shortwave and Wn-2
cmd="cdo expr,'rsus=(ssrd-ssr)/(6*60*60);' $data rsus.cdf"
echo_eval "$cmd"
cmd="cdo expr,'rsds=ssrd/(6*60*60);' $data rsds.cdf"
echo_eval "$cmd"
cmd="cdo_O delname,ssr,ssrd $data"
echo_eval "$cmd"
my_ncatted rsus "'surface upwelling shortwave radiation'" "'W m-2'"
my_ncatted rsds "'surface downwelling shortwave radiation'" "'W m-2'"

# Surface longwave upward radiation from net longwave and Wn-2
cmd="cdo expr,'rlus=(strd-str)/(6*60*60);' $data rlus.cdf"
echo_eval "$cmd"
cmd="cdo expr,'rlds=strd/(6*60*60);' $data rlds.cdf"
echo_eval "$cmd"
cmd="cdo_O delname,str,strd $data"
echo_eval "$cmd"
my_ncatted rlus "'surface upwelling longwave radiation'" "'W m-2'"
my_ncatted rlds "'surface downwelling longwave radiation'" "'W m-2'"
# ----------------------------------------------------------------------


## Split every variable (exlcuding coordinates) of $data into
## separate files (long to execute).

cmd="cdo splitname $data $tmp_pre"
echo_eval "$cmd"
# ----------------------------------------------------------------------

## Convert, rename $tmp_pre files:
for i in tmp*.nc; do

  cdo showvar $i | sed 's/^ *//g' > $tmp_vars
  var=$(cat $tmp_vars)
  
  cmd="mv $i $var$ext"
  echo_eval "$cmd"
  
done

# ======================================================================

## delete $data
rm $data

## make a dump information file
touch dump_info.txt 
for i in *.cdf; do
  
   ncdump -h $i >> dump_info.txt
   echo '' >> dump_info.txt
  
done

mv dump_info.txt $HOME/proj/data/era40/

exit 0
# ======================================================================

## Get list of variable in $data (I don't actually need this)

## print variables in $data, w/o leading whitespace, as csv 
#cdo showvar $data | sed 's/^ *//g' | tr ' ' ',' > $tmp_vars
#
## get number of variables
#Nvar=$(cdo nvar $data)
#
## loop through csv file to fill array
#for ((i=1;i<$Nvar+1;i++)); do
#  vars[$i-1]=$(cat $tmp_vars | cut -d, -f$i)
#done
# ----------------------------------------------------------------------
