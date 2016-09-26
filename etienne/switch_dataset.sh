#! /bin/bash
#
# Script that changes the `model_name' variable in a given 
# `~/proj/etienne/$folder/startup.m' file.
#
# INPUT: $1 , folder name from `~/proj/etienne'
#        $2 , model_name to be uncommented
#
# ===================================================================

# Input arguments
folder="$1"
name="$2"

# startup file and tmp file
startup="startup.m"
tmp="$startup.tmp"

# string definition
str_comm="\%"				
str_ccsm3="model_name = 'ccsm3';"	
str_hadgem1="model_name = 'hadgem1';"
str_ncep_doe="model_name = 'ncep_doe';"
str_era40="model_name = 'era40';"

# string substitution from input
case "$name" in
  ccsm3) str_name="$str_ccsm3"
         ;;
  hadgem1) str_name="$str_hadgem1"
         ;;
  ncep_doe) str_name="$str_ncep_doe"
         ;;
  era40) str_name="$str_era40"
         ;;
  *) echo '*** Invalid model name'
     exit 1
     ;;
esac

# sed -e with overwrite command
sed_O()
{ 
  tmptmp='/tmp/sed_O'
  mv $2 $tmptmp
  sed -e "$1" $tmptmp > $2
}
# -------------------------------------------------------------------


# i) change directory to the script folder
cd $folder

# ii) make temporary file out of $tmp
cp $startup $tmp
# ----------------------------------------------------------------------

# 1) comment every `model_name' definition in $startup
cmd_1()
{
  flag=$(grep -c "%$1" $tmp)
  if [ $flag -eq 0 ]; then
    sed_O "s/$1/$str_comm$1/" $tmp
  fi
}

cmd_1 "$str_ccsm3"
cmd_1 "$str_hadgem1"
cmd_1 "$str_ncep_doe"
cmd_1 "$str_era40"
# ----------------------------------------------------------------------

# 2) substitute for $str_name
echo -e "\n Switching model_name for --> $str_name\n"
sed_O "s/$str_comm$str_name/$str_name/" $tmp
# ----------------------------------------------------------------------

# 3) overwrite $startup
mv $tmp $startup
# ----------------------------------------------------------------------
