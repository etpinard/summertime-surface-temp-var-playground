% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_obs_Tbar.m
%
% Summertime mean T in observations.
%
% ======================================================================


name = 'obs_Tbar';
%name = 'obs_Tbar.eps';

units = '[deg C]';
cvec = [0,10,15:5:30]; 
opt_x_cvec = 'add_both';
color_handle = @color_myhot;

get_obs_T;
obs_Tbar = sqmean(Tobbar)-273.15;

plot_map_miller2( ...
  lon,lat,obs_Tbar, ...
  cvec,opt_x_cvec,name,color_handle,units);
% ----------------------------------------------------------------------
