% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_obs_Pbar.m
%
% Summertime mean P in observations.
%
% ======================================================================


name = 'obs_Pbar';
name = 'obs_Pbar.eps';

units = '[mm day-1]';
cvec = [0,1,2,3,4,5,10]; 
opt_x_cvec = 'above';
color_handle = @color_myearth;

get_obs_P;
obs_Pbar = sqmean(Pobbar)*secinday;

plot_map_miller2( ...
  lon,lat,obs_Pbar, ...
  cvec,opt_x_cvec,name,color_handle,units);
% ----------------------------------------------------------------------
