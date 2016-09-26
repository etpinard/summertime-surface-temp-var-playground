#! /bin/bash
#
# Script that
#
# 1) inverts latitude vectors
# 2a) trims vertical level for `air.2m.cdf', `soilw.0-10cm.cdf' 
# 2b) trims `bnds' field for all variables (maybe not)
# 3a) convert `soilw' to moisture content
#     by simply multiplying by 100 mm.
# 3b) convert `runof' to runoff rate    
# 4) renames all variables to GCM names
# 5) selects time period of interest 
#
# This script uses the 'cdo' tools available at :
#
# https://code.zmaw.de/projects/cdo/
#
# as well as the 'ncatted' tool and the NCO tools.
#
# ======================================================================

### Select time interval! (earliest=1979,latest=2012)
year_start='1979'
year_end='1999'
# ======================================================================

# a few definitions
folder="$HOME/nobackup/data/ncep_doe/"
ext=".cdf"
grid='/tmp/ncep_doe_grid'
tmp_grid='/tmp/ncep_doe_tmp_grid'

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

# a 'rename' function for file name and variable name
my_rename()
{
  # $1: old var name (same as file name), $2: new var name
  echo_eval "cdo -b 32 chname,$1,$2 $1$ext $2$ext"
  echo_eval "rm $1$ext"
}

# a 'delete' command via 'nc kitchen sink'
my_ks_delete()
{
  # $1: file name (w/o ext), $2 field(s) ('field1,field2') to delete
  # copy infile to outfile, except (-x) variablie (-v) $todelete,
  # do not list in alphebatical order (-a)
  echo_eval "ncks -O -a -x -v $2 $1$ext $1$ext"
}

# a 'squeeze&delete command' to remove vertical levels from array
my_squeeze()
{
  # $1: file name (w/o ext) $2: field to squeeze out,
  # squeeze (average) slab of data (-O) for overwrite
  echo_eval "ncwa -O -a $2 $1$ext $1$ext"
  my_ks_delete $1 $2
}
# ----------------------------------------------------------------------


## i) Change directory to data folder

echo -ne "In $folder : \n"
cd $folder
echo ""
# ----------------------------------------------------------------------

## 1) Invert latitudes using `cdo invertlat' if lat(first) > 0

for file in *.cdf; do
  
  # send grid info to $grid, get first `yvals', remove decimals.
  cdo griddes $file > $grid
  grep yvals $grid | cut -d '=' -f2 | sed 's/^ *//g' > $tmp_grid
  latfirst=$(cat $tmp_grid | cut -d ' ' -f1)
  latfirst=${latfirst/.*}
  #echo $latfirst
  
  if [ $latfirst -gt 0 ]; then
    echo_eval "cdo_O invertlat $file"
  fi

done
# ----------------------------------------------------------------------

## 2a) Trim vertical levels in `air.cdf' and `soilw.cdf'

varstotrim=("air" "soilw")
totrim="level"
todelete="level_bnds"

for ((i=0;i<${#varstotrim[@]};i++)); do
  
  my_squeeze ${varstotrim[i]} $totrim
  my_ks_delete ${varstotrim[i]} $todelete
	
done

### 2b) Trim `time_bnds' in all variables (do I need this?)
#
#todelete='time_bnds'
#
#for file in *.cdf; do
#
#  # must remove the extension
#  my_ks_delete ${file%.*} $todelete
#	
#done
# ----------------------------------------------------------------------

## 3a) convert `soilw' to soil moisture content 
#      mrsos = soilw*100, [mrsos] = mm.

echo_eval "cdo expr,'mrsos=100*soilw;' soilw$ext mrsos$ext"
my_ncatted mrsos "'soil moisture content of the top 10 cm'" "'mm'"
# rm soilw$ext 

## 3a) convert `runof' to runoff flux 
#      mrros = runof/($sec_in_1_month), [mrros] = mm s-1.

echo_eval "cdo expr,'mrros=runof/(30*24*60*60);' runof$ext mrros$ext"
my_ncatted mrros "'surface runoff flux'" "'mm s-1'"
# rm runof$ext 
# ----------------------------------------------------------------------

## 4) Rename date files to match GCMs'

# air -> tas
my_rename air tas

# skt -> ts
my_rename skt ts

# soilw -> mrsos (done in 3a)

# runof -> mrros (done in 3b)

# prate -> pr
my_rename prate pr

# shtfl -> hfss
my_rename shtfl hfss

# lhtfl -> hfls
my_rename lhtfl hfls

# dlwrf -> rlds
my_rename dlwrf rlds

# ulwrf -> rlus
my_rename ulwrf rlus

# dswrf -> rsds
my_rename dswrf rsds

# uswrf -> rsus
my_rename uswrf rsus
# ----------------------------------------------------------------------

## 5) Select time interval of interest with $year_start and $year_end

for file in *.cdf; do

  # select years from $year_start to $year_end
  echo_eval "cdo_O selyear,$year_start/$year_end $file"

done
# ----------------------------------------------------------------------


## -) make a dump information file
touch dump_info.txt 
for file in *.cdf; do
  
   ncdump -h $file >> dump_info.txt
   echo '' >> dump_info.txt
  
done

mv dump_info.txt $HOME/proj/data/ncep_doe/

exit 0
# ======================================================================
