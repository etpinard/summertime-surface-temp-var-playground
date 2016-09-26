% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% scenario_sig_T.m
%
% --> plot_4panels.m & plot_2panels <--
%
% Comparison of summer-mean multi-year monthly standard deviations of
% T in 2 GCMs for climate of the 20th century simulations and SRES
% A1B.
%
% output 1: 4 panels absolute sig_T, 2 GCMs x 2 simulations
% output 2: 2 panels ratio of Var(T) a1b/20c3m, 2 GCMs
% 
% output 3: single model verison(s) of output 2 ***to do***
%
% ======================================================================

% required fields for both outputs

out_format = 'both';
opt_frame_col = 0;
opt_overlay = 1;      % use the mbar=20cm contour line

ccsm3_a1b_mbar = anomaly(ccsm3_a1b_m);      % for overlays
hadgem1_a1b_mbar = anomaly(hadgem1_a1b_m);
% ----------------------------------------------------------------------

%% output 1

name = 'scenario_sig_T';
cvec = [0:0.5:3]; 
units = '[K]';
opt_x_cvec = 'above';
color_handle = @color_Var;
%bins = [-0.1:0.1:5];
%yval = 1;

models_plot = {'ccsm3','ccsm3_a1b', ...
               'hadgem1','hadgem1_a1b'};
annotate_text = {'CCSM3.0-20c3m','CCSM3.0-A1b', ...
                 'HadGEM1-20c3m','HadGEM1-A1b'};
vars_plot = {'sig_T'};

[j1,j2,ccsm3_sig_T] = anomaly(ccsm3_T);
[j1,j2,ccsm3_a1b_sig_T] = anomaly(ccsm3_a1b_T);
[j1,j2,hadgem1_sig_T] = anomaly(hadgem1_T);
[j1,j2,hadgem1_a1b_sig_T] = anomaly(hadgem1_a1b_T);

%plot_4panels
%plot_hist_arr = ...
%  catsheet(ccsm3_sig_T, ...
%           ccsm3_a1b_sig_T, ...
%           hadgem1_sig_T, ...
%           hadgem1_a1b_sig_T);
%plot_hist2(plot_hist_arr,bins,[],name,[]);
% ----------------------------------------------------------------------

%% output 2

name = 'scenario_ratio_Var_T';
cvec = [0.0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
units = '[-]';
opt_x_cvec = 'above';
color_handle = @color_relerror;

models_plot = {'ccsm3','hadgem1'};  % overlay with 20c3m mbar
annotate_text = {'CCSM3.0','HadGEM1'};
vars_plot = {'ratio_Var_T'};

ccsm3_ratio_Var_T = ccsm3_a1b_sig_T.^2./ccsm3_sig_T.^2;
hadgem1_ratio_Var_T = hadgem1_a1b_sig_T.^2./hadgem1_sig_T.^2;

plot_2panels
% ----------------------------------------------------------------------
