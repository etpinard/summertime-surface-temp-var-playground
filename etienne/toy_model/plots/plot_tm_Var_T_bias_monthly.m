% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_3panels.m 
%
% of Toy model bias(Var_T) w.r.t GCM's Var_T, one data set at a time.
%
% ======================================================================

% plot_3panels and plot_hist2.m required fields, for all plots!

name = 'plot_tm_Var_T_bias';

out_format = 'png';
%out_format = 'eps';
cvec = [-1:0.25:3];
opt_x_cvec = 'above';
color_handle = @color_posbias2;
opt_overlay = 0;
annotate_text = {'old','Hs-m','Hs-T&m'};
opt_frame_col = 1;
bins = [-1:0.1:5];
yval = 3;

vars_plot = {'bias_1','bias_2','bias_3'};
% ----------------------------------------------------------------------

%% Call tm_$date with `opt_plot=0'
opt_plot = 0;

tm_mar15;
bias_1 = sqmean(bias(tm_Var_T,Var_T));

tm_may14;
bias_2 = sqmean(bias(tm_Var_T,Var_T));

tm_may16;
bias_3 = sqmean(bias(tm_Var_T,Var_T));
% ----------------------------------------------------------------------

%% Call plot_4panels.m and plot_hist2.m

plot_3panels;
plot_hist2(addsheet(bias_1,bias_2,bias_3),bins,[],...
  [model_name,'_',name],yval,out_format);
% ----------------------------------------------------------------------

% ======================================================================
