#! /bin/bash
# 
# Script that makes an NetCDF 
#
# with the 1969-1999 error ratio of Var(T) 
#  ( i.e. Var(T)_cmip5 / Var(T_obs) ),
#  with a land mask and summer only.
# 
# ======================================================================

## a few definitions and shortcuts

# parent directory
parent=$(pwd)/

# destination directory
folder_out='/home/disk/p/etienne/nobackup/data/cmip5/'

# variable/file names 
varname='cmip5_summer_error_ratio_Var_T'
file_matlab="make_netcdf.m"
file_out="${varname}.cdf"

# variable description
descrip_long=$( echo "Ratio of CMIP5 ensemble of \n"
                echo "monthly surface air temperature variance in summer \n"
                echo "to the observed (University of Delaware) value \n"
                echo "for the 1969-1999 time period." )
descrip_var=$( echo $descrip_long )

# summer decription
descrip_long=$( echo "Summer is defined as JJA in NH and DJF in SH \n"  
                echo "month 1 is June/December, \n"
                echo "month 2 is July/January, \n"
                echo "month 3 is August/February" )
descrip_summer=$( echo $descrip_long )

# matlab (must be the new version) run shortcut (1= .m script name)
mat_run()
{
 matlab -nojvm -nosplash -nodisplay -r "run $1; exit"
}

# echo command (as a string) and evaluate it
echo_eval()
{
  echo -e "\$ $1"
  eval $1
  echo ""
}
# ----------------------------------------------------------------------

## (1) make matlab file

touch $file_matlab
echo '' >> $file_matlab

# (i) definitions
( echo "addpath('my_shortcuts/');"
  echo "datapath='/home/disk/p/etienne/nobackup/data/';" 
  echo "era40_path=[datapath,'era40/mrsos.cdf'];"
  echo "cmip5_path=[datapath,'cmip5/tas_ymonvar_1member.cdf'];"
  echo "obs_path=[datapath,'obs/udel_tas_1969-1999_144x73.cdf'];"
  echo "Nyear=30;"
  echo '' ) >> $file_matlab

# (ii) get era40 data (for land mask) and dimensions
( echo "m=ncread(era40_path,'mrsos');"
  echo "m=permute(m,[3,2,1]);"
  echo "lat=ncread(era40_path,'lat');"
  echo "Nlat=length(lat);"
  echo "lon=ncread(era40_path,'lon');"
  echo "Nlon=length(lon);"
  echo "m=summer_only(m,6,8,Nyear);"
  echo "m_trim=m;"
  echo "m_range=[0,50];"
  echo "lat_range=[-90,90];";
  echo "[j1,era40_Iland,j2]=land_only(m,m_trim,m_range,lat,lat_range);"
  echo '' ) >> $file_matlab

# (iii) get cmip5 data and compute Var(T)_cmip5
( echo "cmip5_Var_T=ncread(cmip5_path,'tas_ymonvar');"
  echo "cmip5_Var_T=permute(cmip5_Var_T,[3,2,1]);"
  echo "cmip5_Var_T=summer_only(cmip5_Var_T,6,8,1);"
  echo ' ' ) >> $file_matlab

# (iv) get obs data and compute Var(T_obs)
( echo "obs_T=ncread(obs_path,'air');"
  echo "obs_T=permute(obs_T,[3,2,1]);"
  echo "obs_T=summer_only(obs_T,6,8,Nyear);"
  echo "[j1,j2,obs_Var_T] = anomaly(obs_T,'Var');"
  echo ' ' ) >> $file_matlab

# (v) compute ratio and add land mask / output stats
( echo "$varname=(cmip5_Var_T./obs_Var_T).*x2d(era40_Iland);"
  echo "whos"
  echo "mystats(cmip5_Var_T);"
  echo "disp('')"
  echo "mystats(obs_Var_T);"
  echo "disp('')"
  echo "mystats(${varname});"
  echo "time=[1,2,3];"
  echo "Ntime=3;"
  echo '' ) >> $file_matlab

## (vi) make file commands 
( echo "nc_id=netcdf.create('$file_out','NC_WRITE');"
  echo "dim_id_lon=netcdf.defDim(nc_id,'lon',Nlon);"
  echo "dim_id_lat=netcdf.defDim(nc_id,'lat',Nlat);"
  echo "dim_id_t=netcdf.defDim(nc_id,'time',Ntime);"
  echo "lon_id=netcdf.defVar(nc_id,'lon','double',[dim_id_lon]);"
  echo "lat_id=netcdf.defVar(nc_id,'lat','double',[dim_id_lat]);"
  echo "time_id=netcdf.defVar(nc_id,'time','double',[dim_id_t]);"
  echo "var_id=netcdf.defVar(nc_id,'$varname', ..."
  echo "'double',[dim_id_t dim_id_lat dim_id_lon]);"    # order!
  echo "netcdf.endDef(nc_id);"
  echo "netcdf.putVar(nc_id,lon_id,lon);"
  echo "netcdf.putVar(nc_id,lat_id,lat);"
  echo "netcdf.putVar(nc_id,time_id,time);"
  echo "netcdf.putVar(nc_id,var_id,$varname);"
  echo "netcdf.close(nc_id);" 
  echo "disp('')"
  echo "z=ncread('$file_out','$varname');"
  echo "whos z"
  echo '' ) >> $file_matlab

## (*) test (must be ran with java interface)
#( echo "addpath('my_plots/');"
#  echo "addpath('/home/disk/p/etienne/proj/file_exchange/');"
#  echo "addpath('/home/disk/p/etienne/proj/m_map/');"
#  echo "z=ncread('$file_out','$varname');"
#  echo "whos z"
#  echo "z=sqmean(z);"
#  echo "x=ncread('$file_out','lon');"
#  echo "y=ncread('$file_out','lat');"
#  echo "cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];"
#  echo "opt_x_cvec = 'above';"
#  echo "color_h = @color_relerror;"
#  echo "units = '[-]';"
#  echo "name = 'test_$varname';"
#  echo "plot_map_miller2(x,y,z,cvec,opt_x_cvec,name,color_h,'[-]');"
#  echo '' ) >> $file_matlab

cmd="cat $file_matlab"
echo_eval "$cmd"

# ----------------------------------------------------------------------

## (2) run matlab file

# delete existing NetCDF
#rm $file_out

# run matlab
cmd="mat_run $file_matlab"
echo_eval "$cmd"

# delete matlab file
rm $file_matlab

# ----------------------------------------------------------------------

## (3) move output file and change attributes

# move to datafile folder and change directory
mv -f $file_out $folder_out
cd $folder_out

# add attributes for 'lon'
cmd="ncatted -O -a standard_name,lon,c,c,'longitude' $file_out"
echo_eval "$cmd"
cmd="ncatted -O -a units,lon,c,c,'degrees_east' $file_out"
echo_eval "$cmd"

# add attributes for 'lat'
cmd="ncatted -O -a standard_name,lat,c,c,'latitude' $file_out"
echo_eval "$cmd"
cmd="ncatted -O -a units,lat,c,c,'degrees_north' $file_out"
echo_eval "$cmd"

# add attributes for 'time'
cmd="ncatted -O -a units,time,c,c,'month_number' $file_out"
echo_eval "$cmd"

# add attributes for $varname
cmd="ncatted -O -a standard_name,$varname,c,c,'$descrip_var' $file_out"
echo_eval "$cmd"
cmd="ncatted -O -a units,$varname,c,c,'unitless' $file_out"
echo_eval "$cmd"

# add global attribute
cmd="ncatted -O -a comments,global,c,c,'$descrip_summer' $file_out"
echo_eval "$cmd"

# delete history
cmd="ncatted -O -a history,global,d,, $file_out"
echo_eval "$cmd"


# dump results to screen
ncdump -h $file_out

# ----------------------------------------------------------------------

