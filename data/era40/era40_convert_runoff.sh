#! /bin/bash
#
# Convert the ERA-40's accumulated runoff variable `ro' to the GCMs'
# `mrros' variable.
#
# This script uses the 'cdo' tools available at :
# https://code.zmaw.de/projects/cdo/
#
# as well as the 'ncatted' tool.
#
# I used the following formula (see ./info_from_ecmwf_website/)
#
# mrros = 
#
# ======================================================================

# a few definitions
folder="$HOME/nobackup/data/era40/"
ext=".cdf"
data="ro$ext"
tmp="/tmp/convert_sm"
out="mrros$ext"

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

# 1) Compute the `mrros' variable

# very simpy using `expr' which outputs in 'mrsos.cdf'
echo_eval "cdo expr,'mrros=1000*ro/(24*60*60);' $data $out"
my_ncatted mrros "'surface runoff flux'" "'mm s-1'"
# ----------------------------------------------------------------------

# done!
