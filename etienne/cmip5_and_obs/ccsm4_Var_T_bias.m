% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% ccsm4_Var_T_bias.m
% 
% Summertime Var(T) bias in the CCSM4 w.r.t to U. of Delaware
% observations.
%
% ======================================================================


%% Load CCSM4 data

% get NetCDF (at 144x73 resolution, same as ERA40)
ccsm4_path = [datapath,'cmip5/ccsm4_tas_144x73.cdf'];
ccsm4_T = nc_varget(ccsm4_path,'tas');        
ccsm4_lat = nc_varget(ccsm4_path,'lat');
ccsm4_lon = nc_varget(ccsm4_path,'lon');

% Compute Var_T: summer only, land only
ccsm4_T = summer_only(ccsm4_T,6,8,Nyear);
ccsm4_T = ccsm4_T.*x2d(era40_Iland,Nmonth*Nyear);
[ccsm4_Tbar,ccsm4_TT,ccsm4_Var_T] = anomaly(ccsm4_T);

% Output stats
mystats(ccsm4_Var_T,'CCSM4 Var(T) in summer')

% change 'model_name' to 'ccsm44'
model_name = 'ccsm4';
save 'global.mat' 'model_name' -append
% ----------------------------------------------------------------------

%% Plot options and plot
cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
opt_x_cvec = 'above';
color_handle = @color_relerror;
units = '[-]';
opt_overlay = 0;
%bins = [0:0.25:5];
%yval = 2.5;

bias_Var_T = ccsm4_Var_T./obs_Var_T;
bias_Var_T1 = sqz(bias_Var_T(1,:,:));
bias_Var_T2 = sqz(bias_Var_T(2,:,:));
bias_Var_T3 = sqz(bias_Var_T(3,:,:));
bias_Var_T = sqmean(ccsm4_Var_T./obs_Var_T);

vars_plot = {'bias_Var_T1','bias_Var_T2','bias_Var_T3'};
models_plot = [];
annotate_text = {'June/Dec','July/Jan','Aug/Feb'};
opt_frame_col = 0;

name = 'Var_T_bias_monthly';
out_format = 'png';
out_format = 'eps';
plot_3panels
% ----------------------------------------------------------------------

% miller map of the summer average
name = 'Var_T_bias';
name = 'Var_T_bias.eps';
plot_map_miller2( ...
  ccsm4_lon,ccsm4_lat,bias_Var_T, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');
% ----------------------------------------------------------------------

% plot_4panels
name = 'Var_T_bias_4panel';
out_format = 'png';
out_format = 'eps';
vars_plot = {'bias_Var_T','bias_Var_T1','bias_Var_T2','bias_Var_T3'};
models_plot = [];
annotate_text = {'Summer avg','June/Dec','July/Jan','Aug/Feb'};
plot_4panels;
% ----------------------------------------------------------------------
