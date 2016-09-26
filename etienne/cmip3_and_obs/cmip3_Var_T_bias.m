% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables 
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% cmip3_Var_T_bias.m
%
% Summertime Var(T) bias in an ensemble of CMIP3 models w.r.t. U.
% Delaware observations (data from David).
%
% ** Only the summer average results.
%
% ======================================================================

% change 'model_name' to 'cmip3'
model_name = 'cmip3';
save 'global.mat' 'model_name' -append

cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
opt_x_cvec = 'above';
color_handle = @color_relerror;
units = '[-]';
opt_overlay = 0;
%bins = [-1:0.1:5];
%yval = 1;

% miller map of the summer average
name = 'Var_T_bias';
plot_map_miller2( ...
  lon_cmip3,lat_cmip3,cmip3_var_bias, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');

name = 'Var_T_bias.eps';
plot_map_miller2( ...
  lon_cmip3,lat_cmip3,cmip3_var_bias, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');
% ----------------------------------------------------------------------
