% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables 
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% cmip5_Var_T_bias.m
%
% 
% Summertime Var(T) bias in an ensemble of CMIP5 models w.r.t. U.
% Delaware observations.
%
% ======================================================================

% change 'model_name' to 'cmip5'
model_name = 'cmip5';
save 'global.mat' 'model_name' -append

cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
opt_x_cvec = 'above';
color_handle = @color_relerror;
units = '[-]';
opt_overlay = 0;
%bins = [-1:0.1:5];
%yval = 1;

bias_Var_T = cmip5_Var_T./obs_Var_T;
bias_Var_T1 = sqz(bias_Var_T(1,:,:));
bias_Var_T2 = sqz(bias_Var_T(2,:,:));
bias_Var_T3 = sqz(bias_Var_T(3,:,:));
bias_Var_T = sqmean(cmip5_Var_T./obs_Var_T);

vars_plot = {'bias_Var_T1','bias_Var_T2','bias_Var_T3'};
models_plot = [];
annotate_text = {'June/Dec','July/Jan','Aug/Feb'};
opt_frame_col = 0;

name = 'Var_T_bias_monthly';
out_format = 'png';
out_format = 'eps';
%plot_3panels
% ----------------------------------------------------------------------

% miller map of the summer average
name = 'Var_T_bias';
plot_map_miller2( ...
  cmip5_lon,cmip5_lat,bias_Var_T, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');
name = 'Var_T_bias.eps';
plot_map_miller2( ...
  cmip5_lon,cmip5_lat,bias_Var_T, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');
% ----------------------------------------------------------------------

% plot_4panels
name = 'Var_T_bias_4panel';
out_format = 'png';
out_format = 'eps';
vars_plot = {'bias_Var_T','bias_Var_T1','bias_Var_T2','bias_Var_T3'};
models_plot = [];
annotate_text = {'Summer avg','June/Dec','July/Jan','Aug/Feb'};
%plot_4panels;
% ----------------------------------------------------------------------
