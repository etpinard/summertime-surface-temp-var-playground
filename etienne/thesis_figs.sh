#! /bin/bash
# 
# "Standalone" script that remakes all figures included in thesis.
#
# After completion, all figures are placed in ./thesis_figs-$date/ .
#
# (10/03) '.png' figures do not have the right resolution when 
#         executed with 'thesis_figs.sh' (Why???) 
#         Only '.eps' figure are copied to ./thesis_figs-$date/
#
# (11/05) '.eps' the legends in 
#                'line_forc_coeffs.m' and 'line_mbar_Var_T.m' 
#                are not properly generated!
# 
# ======================================================================


## a few shortcuts

# parent directory
parent=$(pwd)/

# matlab run shortcut (1= .m script name)
mat_run()
{
 matlab --version 2007b -nojvm -nosplash -nodisplay -r "run $1; exit"
}

# copy new shortcut (1=number , 2=sub folder after $folder/eps)
cp_new_eps()
{ 
  cd figs/eps
  echo -e "  Copying :\n"
  ls -t | head -n $1
  echo -e "\n  to :  $parent$folder/eps/$2"
  cp $( ls -t | head -n $1 ) $parent$folder/eps/$2
  cd ../../
}

# ----------------------------------------------------------------------

## (0) make folder (referred to as $folder herein)

suffix=$(date +"%m-%d")
folder="thesis_figs-"$suffix
mkdir -p $folder/eps/{chap1,chap2,chap3,chap4,chap5,chap6,chapA}

# ----------------------------------------------------------------------

## (1) figures in correlations/
#
# $ for chap2 :
# - plot_corr_land_atm (1 out) :
#     set opt_plot_all_datasets=0
# - comp_corr_E (4 outs) :
#     use the 2nd 'vars_ind' & 'vars_req'
# - comp_corr_m (1 out) :
#     use the 2nd 'vars_ind' & 'vars_req'
# - plot_m_plot (1 out)
#
# $ for chap3 :
# - gcms_Cor_Em_Cor_Emb (1 out) :
#     use the 'plot_6panels' version
# - gcms_Corlag_m_Corlag_mb (1 out) :
#     use the 'plot_4panels' version
# - comp_corr_auto_m (1 out)
# - comp_corr_bud_res (2 outs)
# 
# $ for chap4 :
# - comp_corr_auto (2 outs) :
#     use the 3rd 'vars_req' & 'comp_cmd'
# - gcms_Corlag_mbm (1 out)
# 
# ----------------------------------------------------------------------

cd $parent/correlations

# chap2 (7 outs)
arg1="comp_corr_E; comp_corr_m; clear Cor_*; plot_corr_land_atm;"
arg2="plot_m_crit"
#mat_run "$arg1$arg2"
#cp_new_eps 7 chap2/

# chap3 (5 outs)
arg1="gcms_Cor_Em_Cor_Emb; gcms_Corlag_m_Corlag_mb;"
arg2="comp_corr_auto_m; comp_corr_bud_res"
#mat_run "$arg1$arg2"
#cp_new_eps 5 chap3/

# chap4 (3 outs)
arg1="comp_corr_auto; gcms_Corlag_mbm;"
#mat_run "$arg1"
#cp_new_eps 3 chap4/

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------

## (2) figures in regressions/
#
# $ for chap3 :
# - plot_Flu_regrs (1 out) : set opt_plot_all_datasets=0
# - plot_E_regrs (1 out) : set opt_plot_all_datasets=0
# - plot_E_regrs2 (1 out) : set opt_plot_all_datasets=0
# - plot_Hs_regrs (1 out) : set opt_plot_all_datasets=0
# - comp_regrs_Hs_m (1 out)
# - plot_Hs_regrs2 (1 out) : set opt_plot_all_datasets=0 
# - plot_Hs_tmbld (1 out) :
#     set opt_plot_all_datasets=0 , name='Hs_tmbld_rms' 
# - comp_Hs_gain (1 out)
# - plot_xiU_regrs (1 out) : set opt_plot_all_datasets=0 
# - plot_xiU_tmbld (1 out) 
#     set opt_plot_all_datasets=0 , name='xiU_tmbld_rms' 
# - plot_xim_regrs (1 out) : set opt_plot_all_datasets=0 
# - plot_xim_regrs2 (1 out) : set opt_plot_all_datasets=0 
# - plot_xim_tmbld (1 out) 
#     set opt_plot_all_datasets=0 , name='xim_tmbld_rms' 
# - plot_R_regrs (1 out) : set opt_plot_all_datasets=0 
# - plot_R_tmbld (1 out) 
#     set opt_plot_all_datasets=0 , name='R_tmbld_rms' 
# - comp_tm_param (6 outs) 
#
# $ for chap4 :
# - plot_gcms_Hs_regrs_gain_E_DeltaT (2 outs)
# - plot_gcms_aero_regrs (1 out)
# 
# ----------------------------------------------------------------------

cd $parent/regressions

# chap3 (21 outs)
arg1="plot_Flu_regrs; plot_E_regrs; plot_E_regrs2; plot_Hs_regrs;"
arg2="comp_regrs_Hs_m; plot_Hs_regrs2; plot_Hs_tmbld; comp_Hs_gain;"
arg3="plot_xiU_regrs; plot_xiU_tmbld; plot_xim_regrs; plot_xim_regrs2;"
arg4="plot_xim_tmbld; plot_R_regrs; plot_R_tmbld; comp_tm_param"
#mat_run "$arg1$arg2$arg3$arg4"
#cp_new_eps 21 chap3/

# chap4 (3 outs)
arg1="plot_gcms_Hs_regrs_gain_E_DeltaT; plot_gcms_aero_regrs;"
#mat_run "$arg1"
#cp_new_eps 3 chap4/

#exit 0

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------

## (3) figures in toy_model/
#
# $ for chap3 :
# - comp_tm_Var_T_bias (2 outs) : 
#    (the 2nd 'comp_cmd' w/o  monthly plots)
# - comp_tm_Var_m_bias (2 outs) : 
#    (the 2nd 'comp_cmd' w/o  monthly plots)
# - ...
#
# $ for chap4 :
# - ...
#
# $ for chap5 :
# - line_forc_coeffs (1 out) : set 'name' to 'forc_coeffs_all'
#     *** legend is bad !!!
# 
# ----------------------------------------------------------------------

cd $parent/toy_model

# chap3 (4 outs ...)
arg1="comp_tm_Var_T_bias; comp_tm_Var_m_bias;"
mat_run "$arg1"
cp_new_eps 4 chap3/

# chap4 

# chap5 (1 out)
arg1="line_forc_coeffs"
mat_run "$arg1"
cp_new_eps 1 chap5/

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------

## (4) figures in scales
#
# $ for chap3 :
#
# ...
#
# $ for chap4 :
# - comp_scale_gammaT (3 outs)
# - comp_scale_Var_E_Hs (1 out)
# - plot_scale_engy (1 out) : set opt_plot_all_datasets=0 
#
# ...
# 
# ----------------------------------------------------------------------

cd $parent/scales

# chap3 
#mat_run "$arg1$arg2$arg3$arg4"
#cp_new_eps 21 chap3/

# chap4 (5 outs)
arg1="comp_scale_gammaT; comp_scale_Var_E_Hs; plot_scale_engy;"
#mat_run "$arg1"
#cp_new_eps 5 chap4/

#exit 0

# 20 seconds to cool off
#sleep 20 

# ----------------------------------------------------------------------

## (6) figures in valid_obs/
#
# $ for chap3 :
#
# $ for chap4 :
#
# $ for chap5 : 
# - line_mbar_Var_T (1 out) : set 'model_startup' to the 4 datasets
#     *** legend is bad !!!
# 
# ----------------------------------------------------------------------

# don't forget new plot (10-18) !!!
# compobs_corr_T (2-3 plots now)
# compobs_trends_T

cd $parent/valid_to_obs

# chap3 
#mat_run "$arg1$arg2$arg3$arg4"
#cp_new_eps 21 chap3/

# chap4
#mat_run "plot_gcms_Hs_regrs_gain_E_DeltaT; plot_gcms_aero_regrs"
#cp_new_eps 2 chap4/

# chap5
arg1="line_mbar_Var_T;"
mat_run "$arg1"
cp_new_eps 1 chap5/

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------

## (7) figures in distributions/
#
# $ for chap3 :
#
# $ for chap4 :
#
# $ for chapA :
# 
# ----------------------------------------------------------------------

# comp_trends_m (1 plot)

cd $parent/distributions

# chap3 
#mat_run "$arg1$arg2$arg3$arg4"
#cp_new_eps 21 chap3/

# chap4
#mat_run "plot_gcms_Hs_regrs_gain_E_DeltaT; plot_gcms_aero_regrs"
#cp_new_eps 2 chap4/

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------

## (8) figures in cmip5_and_obs/
#
# $ for chap1 :
#
# $ for chap6 :
# 
# ----------------------------------------------------------------------

cd $parent/cmip5_and_obs/

# chap3 
#mat_run "$arg1$arg2$arg3$arg4"
#cp_new_eps 21 chap3/

# chap4
#mat_run "plot_gcms_Hs_regrs_gain_E_DeltaT; plot_gcms_aero_regrs"
#cp_new_eps 2 chap4/

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------

## (9) figures in scenario/
#
# $ for chap5 :
# - scenario_mbar (2 outs)
# 
# ----------------------------------------------------------------------

cd $parent/scenario/

# chap5
arg1="scenario_mbar;"
#mat_run "$arg1"
#cp_new_eps 2 chap5/

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------

## () figures in balances/
#
# $ for chap3 :
#
# $ for chap4 :
# 
# ----------------------------------------------------------------------

cd $parent/balances

# chap3 
#mat_run "$arg1$arg2$arg3$arg4"
#cp_new_eps 21 chap3/

# chap4
#mat_run "plot_gcms_Hs_regrs_gain_E_DeltaT; plot_gcms_aero_regrs"
#cp_new_eps 2 chap4/

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------

## () figures in seasonal_cycle/
#
# $ for chap3 :
#
# $ for chap4 :
# 
# ----------------------------------------------------------------------

cd $parent/balances

# chap3 
#mat_run "$arg1$arg2$arg3$arg4"
#cp_new_eps 21 chap3/

# chap4
#mat_run "plot_gcms_Hs_regrs_gain_E_DeltaT; plot_gcms_aero_regrs"
#cp_new_eps 2 chap4/

# 20 seconds to cool off
#sleep 20

# ----------------------------------------------------------------------
