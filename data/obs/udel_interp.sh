#! /bin/bash
#
# Script that interpolate U. of Delaware surface temperature (or
# monthly total precip) data available in a NetCDF file at :
#
# http://www.esrl.noaa.gov/psd/data/gridded/data.UDel_AirT_Precip.html
#
# to the resolution of the CCSM 3.0 (in ../ccsm3/) and HadGEM1 (in
# ../hadgem1/) in both space and timae. 
#
# Note that the input (U.Del) file must be placed in ./datafiles/
#
# This script uses the 'cdo' tools available at :
#
# https://code.zmaw.de/projects/cdo/
#
# OUTPUT: $outfile in ./datafiles/
#
# *** I should try to convert in Kelvin and change field names etc...
# *** with nco set of tools this time 
# *** and change p to mm/s as in the GCM outputs. 
#     maybe in a `rearrange.sh' file
#     
# --> use 'ncatted' as ~/proj/data/hadgem1/get_Uas.sh
#
# ======================================================================


### Choose GCM/Reanalysis to match to :

#model="ccsm3"
#model="hadgem1"
model="ncep_doe"
#model="era40"

# ======================================================================

## Some paths

# path to $model data
modelpath="/home/disk/p/etienne/nobackup/data/$model/"

# path to $model sample file (take `tas.cdf' or `air.cdf')
#if [ "$model" = "ncep_doe" ]; then
#  model_in="${modelpath}air.cdf"
#else
#  model_in="${modelpath}tas.cdf"
#fi
model_in="${modelpath}tas.cdf"

# path to U. Delaware obs.
obspath='/home/disk/p/etienne/nobackup/data/obs/'

# path to high resolution U. Delaware obs. , the 'in' files
tas_in="${obspath}air.mon.mean.v301.nc"
p_in="${obspath}precip.mon.total.v301.nc"
vars=("tas" "p")

## 'out' files names are derived next using data in $model files

# some temporary files
tmp="/tmp/udel_interp"
grid="/tmp/grid"
# ----------------------------------------------------------------------


## Get time interval ($year_start to $year_end) for $model_in

# print years , w/o leading whitespace , as csv into $tmp
cdo showyear $model_in | sed 's/^ *//g' | tr ' ' ',' > $tmp

# get number of years 
Nyear=$(cdo nyear $model_in)

# $year_start is the first column
year_start=$(cat $tmp | cut -d, -f1)

# $year_end is the last column
year_end=$(cat $tmp | cut -d, -f$Nyear)
# ----------------------------------------------------------------------

## Get grid ID and grid size for $model_in

# print grid description into $grid (crucial for interpolation!)
cdo griddes $model_in > $grid

# locate `xsize' row , keep only value after '=' sign , 
# w/o leading whitespace , store in $Nlon
Nlon=$(grep xsize $grid | cut -d '=' -f2 | sed 's/^ *//g')

# similarly for `ysize row and $Nlat
Nlat=$(grep ysize $grid | cut -d '=' -f2 | sed 's/^ *//g')
# ----------------------------------------------------------------------

## Name output file(s)

tas_out="\
      ${obspath}udel_tas_${year_start}-${year_end}_${Nlon}x$Nlat.cdf"

p_out="\
      ${obspath}udel_p_${year_start}-${year_end}_${Nlon}x$Nlat.cdf"

#echo $tas_out $tas_in
#exit 0
echo ""
# ----------------------------------------------------------------------


## Trim in time and interpolate for variables(s) first for tas

## Trim ${vars}_in in time, from $year_start to $year_end 
cmd="cdo selyear,$year_start/$year_end $tas_in $tmp"
echo -e "\$  $cmd"
eval $cmd
echo ""

## Interpolate from 0.5x0.5 down to $grid (it is that easy!)
cmd="cdo -v interpolate,$grid $tmp $tas_out"
echo -e "\$  $cmd"
eval $cmd
echo ""


## Then for p (looping was tricky ... w/ assigning string blablabla)

cmd="cdo selyear,$year_start/$year_end $p_in $tmp"
echo -e "\$  $cmd"
eval $cmd
echo ""

cmd="cdo -v interpolate,$grid $tmp $p_out"
echo -e "\$  $cmd"
eval $cmd
echo ""

# ======================================================================
