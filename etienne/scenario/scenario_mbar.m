% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% scenario_mbar.m
%
% --> plot_4panels.m & plot_2panels <--
%
% Comparison of summer mean soil-moisture in 2 GCMs for climate of the
% 20th century simulations and SRES A1B.
%
% output 1: 4 panels absolute mbar, 2 GCMs x 2 simulations
% output 2: 2 panels relative difference (a1b-20c3m)/20c3m, 2 GCMs
% 
% output 3: single model verison(s) of output 2 ***to do***
%
% ======================================================================

% required fields for both outputs

out_format = 'both';
opt_frame_col = 0;
opt_overlay = 1;      % use the mbar=20cm contour line
% ----------------------------------------------------------------------

%% output 1

name = 'scenario_mbar';
cvec = [0:5:40];          % as in 'comp_mbar'
units = '[mm]';
opt_x_cvec = 'above';
color_handle = @color_mydusk;
%bins = [0:0.5:50]; 
%yval = 0.1;

models_plot = {'ccsm3','ccsm3_a1b', ...
               'hadgem1','hadgem1_a1b'};
annotate_text = {'CCSM3.0-20c3m','CCSM3.0-A1b', ...
                 'HadGEM1-20c3m','HadGEM1-A1b'};
vars_plot = {'mbar'};

ccsm3_a1b_mbar = anomaly(ccsm3_a1b_m);
hadgem1_a1b_mbar = anomaly(hadgem1_a1b_m);

%plot_4panels;
%plot_hist_arr = ...
%  catsheet(sqmean(ccsm3_mbar), ...
%           sqmean(ccsm3_a1b_mbar), ...
%           sqmean(hadgem1_mbar), ...
%           sqmean(hadgem1_a1b_mbar));
%plot_hist2(plot_hist_arr,bins,[],name,[]);
% ----------------------------------------------------------------------

%% output 2

name = 'scenario_rel_diff_mbar';
%cvec = [-25:5:25];          
cvec = [-50:10:50];          
units = '[%]';
opt_x_cvec = 'both';
color_handle = @color_corr;

models_plot = {'ccsm3','hadgem1'};  % overlay with 20c3m mbar
annotate_text = {'CCSM3.0','HadGEM1'};
vars_plot = {'rel_diff_mbar'};

ccsm3_rel_diff_mbar = (ccsm3_a1b_mbar-ccsm3_mbar)./ccsm3_mbar;
hadgem1_rel_diff_mbar = (hadgem1_a1b_mbar-hadgem1_mbar)./hadgem1_mbar;
ccsm3_rel_diff_mbar = ccsm3_rel_diff_mbar*100;  
hadgem1_rel_diff_mbar = hadgem1_rel_diff_mbar*100; 

plot_2panels;
% ----------------------------------------------------------------------
