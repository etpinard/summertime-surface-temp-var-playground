#! /bin/bash
#
# Trim U. of Delaware monthly data:
#
# http://www.esrl.noaa.gov/psd/data/gridded/data.UDel_AirT_Precip.html
#
# to the 1969-1999 time interval.
#
# Note that the input file must be placed in ./datafiles/
#
# This script will use the 'cdo' tools available at :
#
# https://code.zmaw.de/projects/cdo/
#
# OUTPUT: $outfile in ./datafiles/
#
# *** I should try to convert in Kelvin and change field names etc...
# *** with nco set of tools this time 
# *** and change p to mm/s as in the GCM outputs.
#
# ======================================================================


## For both tas and p
year_start='1969'
year_end='1999'
Nlon='720'
Nlat='360'

# for tas
infile="/home/disk/p/etienne/nobackup/data/obs/air.mon.mean.v301.nc"
outfile="/home/disk/p/etienne/nobackup/data/obs/udel_tas_\
${year_start}-${year_end}_${Nlon}x$Nlat.cdf"

# for p
#infile="/home/disk/p/etienne/nobackup/data/obs/precip.mon.total.v301.nc"
#outfile="/home/disk/p/etienne/nobackup/data/obs/udel_p_\
#${year_start}-${year_end}_${Nlon}x$Nlat.cdf"
# ----------------------------------------------------------------------


## Trim $infile in time, from $year_start to $year_end

cmd="cdo selyear,$year_start/$year_end $infile $outfile"
echo $cmd
eval $cmd
echo -e \n

#ncdump -h $tmp
#ncdump -v time $tmp
# ----------------------------------------------------------------------

# done!
