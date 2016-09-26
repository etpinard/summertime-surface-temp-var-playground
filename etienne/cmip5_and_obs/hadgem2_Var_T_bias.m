% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% hadgem2_Var_T_bias.m
% 
% Summertime Var(T) bias in the HadGEM2-es w.r.t to U. of Delaware
% observations.
%
% ======================================================================


%% Load HadGEM2-es data

% get NetCDF (at 144x73 resolution, same as ERA40)
hadgem2_path = [datapath,'cmip5/hadgem2-es_tas_144x73.cdf'];
hadgem2_T = nc_varget(hadgem2_path,'tas');        
hadgem2_lat = nc_varget(hadgem2_path,'lat');
hadgem2_lon = nc_varget(hadgem2_path,'lon');

% Compute Var_T: summer only, land only
hadgem2_T = summer_only(hadgem2_T,6,8,Nyear);
hadgem2_T = hadgem2_T.*x2d(era40_Iland,Nmonth*Nyear);
[hadgem2_Tbar,hadgem2_TT,hadgem2_Var_T] = anomaly(hadgem2_T);

% Output stats
mystats(hadgem2_Var_T,'HadGEM2-es Var(T) in summer')

% change 'model_name' to 'hadgem2'
model_name = 'hadgem2';
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

bias_Var_T = hadgem2_Var_T./obs_Var_T;
bias_Var_T1 = sqz(bias_Var_T(1,:,:));
bias_Var_T2 = sqz(bias_Var_T(2,:,:));
bias_Var_T3 = sqz(bias_Var_T(3,:,:));
bias_Var_T = sqmean(hadgem2_Var_T./obs_Var_T);

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
  hadgem2_lon,hadgem2_lat,bias_Var_T, ...
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
