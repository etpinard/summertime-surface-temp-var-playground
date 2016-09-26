%%% Procedure which facilitates the plotting of monthly fields.
  % 
  % executes plot_monthly.m and plot_summeravg.m in succesion.
% ======================================================================
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%%
%% Requires: 
%%  Z (Nmonth x Nlat x Nlon).
%%  cvec (contour vector for plot_map_miller2.m).
%%  opt_x_cvec (optional, for plot_map_miller2.m) 
%%  color_handle (color map handle for plot_map_miller2.m)
%%  bins (bin vector for plot_hist.m)
%%  yval (height the yaxis for plot_hist.m)
%%  name (string for output file)
%%  opt_mean (=1 for sqrt of the mean of the squares in plot_summeravg)
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Calls plot_monthly.m
plot_monthly
% ======================================================================

%% Calls plot_summeravg.m
plot_summeravg
% ======================================================================

clear Z 
clear name

%% Maybe clear cvec color_handle bins .... 
  % to avoid confusion 
