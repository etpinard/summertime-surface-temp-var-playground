% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_corr_T.m
%
% --> plot_comp_datasets.m <--
%
% Summertime correlations involving T.
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
%opt_overlay = 2;
units = '[-]';

%cvec = [-1:0.2:-0.4,0,0.4:0.2:1]; 
cvec = [-1:0.2:1];
opt_x_cvec = [];
color_handle = @color_corr;
bins = [-1,1];
yval = 4;

var_dep = 'T';
vars_ind = {'F','P','F0','m','Hs','xiU'};   % (E,T) done in comp_E.m
vars_req = {'lon','lat', ...
            'Cor_TF','Cor_TP','Cor_TF0', ...
            'Cor_Tm','Cor_THs','Cor_TxiU'};
opt_corlag = 0;
comp_cmd = 'corr_depind';
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
