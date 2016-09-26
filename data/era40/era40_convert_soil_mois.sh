#! /bin/bash
#
# Convert the ERA-40's `swvl1' and `swvl2' to `mrsos' as in the CCSM
# 3.0 and the HadGEM1 archives.
#
# This script uses the 'cdo' tools available at :
# https://code.zmaw.de/projects/cdo/
#
# as well as the 'ncatted' tool.
#
# *** I used the following formula (ref. Li & Robock 2005) 
#
# mrsos = 70*swvl1 + 30*swvl2
#   with [mrsos] = mm of water.
#
# ======================================================================

# a few definitions
folder="$HOME/nobackup/data/era40/"
ext=".cdf"
layer1="swvl1$ext"
layer2="swvl2$ext"
tmp="/tmp/convert_sm"
out="mrsos$ext"

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

# a 'ncatted' function for name and units (maybe add more?)
my_ncatted()
{
  # $1: var name, $2: "'long_name'", $3: "'units'"
  echo_eval "ncatted -O -a long_name,$1,o,c,$2 $1$ext"
  echo_eval "ncatted -O -a units,$1,o,c,$3 $1$ext"
}
# ----------------------------------------------------------------------


## i) Change direcorty to data folder

echo -ne "In $folder : \n"
cd $folder
echo ""
# ----------------------------------------------------------------------

## 1) Merge $layer1 and $layer2 into one temporary file

rm $tmp
echo_eval "cdo merge $layer1 $layer2 $tmp"
# ----------------------------------------------------------------------

## 2) Compute the `mrsos' variable

# very simpy using `expr' which outputs in 'mrsos.cdf'
echo_eval "cdo expr,'mrsos=70*swvl1+30*swvl2;' $tmp $out"
my_ncatted mrsos "'soil moisture content of the top 10 cm'" "'mm'"
# ----------------------------------------------------------------------

# done!
