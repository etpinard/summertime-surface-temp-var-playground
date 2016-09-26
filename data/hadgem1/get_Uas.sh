#! /bin/bash
#
# Script that the horizontal wind speed 
# from the zonal and meriodinal components of the surface wind.
#
# This script also interpolate the result from the vector grid 
# to the scalar grid.
#
# This script uses the 'cdo' tools available at :
# https://code.zmaw.de/projects/cdo/
#
# as well as the 'ncatted' tool.
#
# ======================================================================

# a few definitions
folder="$HOME/nobackup/data/hadgem1/"
ext=".cdf"
zonal="uas$ext"
merid="vas$ext"
tmp='/tmp/get_Uas'
scalar="tas$ext"
grid="/tmp/grid"
out="Uas$ext"

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
  tmp_O='/tmp/cdo_O'
  cdo -b 32 $1 $2 $tmp_O
  mv  $tmp_O $2
}
# ----------------------------------------------------------------------


## i) Change direcorty to data folder

echo -ne "In $folder : \n"
cd $folder
echo ""
# ----------------------------------------------------------------------

## 1) Merge $zonal and $merid into one temporary file

rm $tmp
echo_eval "cdo merge $zonal $merid $tmp"
# ----------------------------------------------------------------------

## 2) Compute the surface wind speed and set attributes

# very simpy using `expr' which outputs in different file
echo_eval "cdo_O expr,'Uas=sqrt(uas^2+vas^2);' $tmp"

# use 'ncatted' to set attributes (maybe add 'missing_value')
echo_eval "ncatted -O -a long_name,Uas,o,c,'surface wind speed' $tmp"
echo_eval "ncatted -O -a units,Uas,o,c,'m s-1' $tmp"
# ----------------------------------------------------------------------

## 3) Interpolate from vector grid to scaler grid

# print the scalar grid description into $grid 
echo_eval "cdo griddes $scalar > $grid"

# interpolate to scalar grid to $output
echo_eval "cdo -v interpolate,$grid $tmp $out"
# ----------------------------------------------------------------------

# done!
# (maybe) rm uas.cdf vas.cdf ???
