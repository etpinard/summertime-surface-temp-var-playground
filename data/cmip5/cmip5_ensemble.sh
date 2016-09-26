#! /bin/bash
#
# Script that computes the ensemble mean of all model found in
#
# /home/disk/pynchon/dargan/cmip5/historical/tas/2d/ 
#
# see https://catalyst.uw.edu/gopost/conversation/dargan/571698 .
#
#
# The time interval and resolution can be specify in the preamble.
#
# Step-by-step :
#
# 1) Select time interval in all "*nc" files
# 2) Interpolate all "*.nc" to common resolution
# 3) Compute the ensemble mean
#
#
# This script makes use of the 'cdo' tools available at :
#   
#   https://code.zmaw.de/projects/cdo/
#
# as well as the 'nco' tools to change NetCDF attributes.
#
# ======================================================================


## (i) Select time interval 

year_start='1969'
year_end='1999'

# earliest=1850, latest=2005 for cmip5 historical runs
# however, some models start in 1859 or 1950.
# ----------------------------------------------------------------------

## (ii) Select resolution (with cdo terminalogy) and save in file

griddes="$(pwd)/cmip5_ensemble_griddes"

( echo 'gridtype  = lonlat'
  echo 'gridsize  = 10512'
  echo 'xname     = lon'
  echo 'xlongname = lon'
  echo 'xunits    = degrees_east'
  echo 'yname     = lat'
  echo 'ylongname = lat'
  echo 'yunits    = degrees_north'
  echo 'xsize     = 144'
  echo 'ysize     = 73'
  echo 'xfirst    = 0'
  echo 'xinc      = 2.5'
  echo 'yfirst    = -90'
  echo 'yinc      = 2.5' ) > $griddes

# 2.5 deg x 2.5 deg (as in the ERA-40)
# ----------------------------------------------------------------------

## (iii) Define paths, file extension, temporary file prefix

#folder_in="/home/disk/pynchon/dargan/cmip5/historical/tas/2d/"
folder_in="/home/disk/eos10/dargan/cmip5/historical/tas/2d"
folder_out="/home/disk/p/etienne/nobackup/data/cmip5/"
#ext=".nc"
ext=".cdf"
folder_tmp="/tmp/tmp_"
tmp="/tmp/cmip5_ensemble"
file_out="tas$ext"
# ----------------------------------------------------------------------

## (*) Define a few functions

# echo command (as a string) and evaluate it
echo_eval()
{
  echo -e "\$ $1"
  eval $1
  echo ""
}

# call cdo and overwrite output (with 32 bit precession) 
cdo_O()
{
  tmp_cdo_O='/tmp/cdo_O'
  cdo -b 32 -v $1 $2 $tmp_cdo_O
  mv $tmp_cdo_O $2
}
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
# ----------------------------------------------------------------------


## 0) Change directory to data folder 

echo_eval "cd $folder_in"
# ----------------------------------------------------------------------

## Loop through all ".nc" in $folder_in

# initialize counter to keep track of variables
cnt=0;

for i in *.nc; do 

  # temporary files
  file_in="$i"
  file="$folder_tmp$i"

  ## *) Check if [$year_start,$year_end] is in $file_in's sample

  # print years , w/o leading whitespace , as csv into $tmp
  cdo showyear $file_in | sed 's/^ *//g' | tr ' ' ',' > $tmp

  # get number of years, start and end year in $file_in
  file_in_nyear=$(cdo nyear $file_in)
  file_in_start=$(cat $tmp | cut -d, -f1)
  file_in_end=$(cat $tmp | cut -d, -f$file_in_nyear)

  if [ $file_in_start -gt $year_start -o $file_in_end -lt $year_end ];
    then
      continue
    else

    ## 1) Select years in wanted time interval
    cmd="cdo selyear,$year_start/$year_end $file_in $file"
    echo_eval "$cmd"
#    cdo showyear $file

    ## **) if $file_in has more than 1 variable, select 'tas'
    file_in_nvar=$(cdo nvar $file_in)

    if [ $file_in_nvar -eq 2 ]; then
      cmd="cdo_O selname,tas $file"
      echo_eval "$cmd"
    fi

    ## 2) Interpolate all data set to a common resolution
    cmd="cdo_O interpolate,$griddes $file"
    echo_eval "$cmd"
#    cdo griddes $file | grep 'xsize\|ysize'
    
    # keep track of files with `file_names' that went through 1) and 2)
    file_names[$cnt]=$file
    let cnt=cnt+1;

  fi

done
# ----------------------------------------------------------------------

## 3) Ensemble of all members

file_out_cdo='tas.cdo.cdf'

cmd="cdo ensmean ${file_names[@]} $folder_out$file_out_cdo"
echo_eval "$cmd"

file_out_ncea='tas.ncea.cdf'

cmd="ncea ${file_names[@]} $folder_out$file_out_ncea"
echo_eval "$cmd"
# ----------------------------------------------------------------------

## !) Output statistic, clean up $file_out ...


# ----------------------------------------------------------------------
