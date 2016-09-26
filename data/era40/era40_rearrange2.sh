#! /bin/bash
#
# Script that
#
#  split `output2.nc' (from download) into multiple files,
#  convert and rename variables to match the GCMs' 
#  nomenclature, units and South-to-North latitudes
#
# This script uses the 'cdo' tools available at :
# https://code.zmaw.de/projects/cdo/
#
# as well as the 'ncatted' tool.
#
# Should I do something for the wind speed ?
# ======================================================================

# a few definitions
folder="$HOME/nobackup/data/era40/"
original="output2.nc"
data="tmp.output2"
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

# soil layer1 temperature: change name to `ts'
cmd="cdo_O chname,stl1,ts $data"
echo_eval "$cmd"

# Should I do something for the wind speed ?
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

## make another dump information file
touch dump_info2.txt 
for i in *.cdf; do
  
   ncdump -h $i >> dump_info2.txt
   echo '' >> dump_info2.txt
  
done

mv dump_info2.txt $HOME/proj/data/era40/

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
