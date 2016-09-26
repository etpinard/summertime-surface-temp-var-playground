% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_corr_E.m
%
% --> plot_comp_datasets.m <--
%
% Summertime correlations involving E.
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
%opt_overlay = 0;
opt_overlay = 2;
units = '[-]';

%cvec = [-1:0.2:-0.4,0,0.4:0.2:1]; 
cvec = [-1:0.2:1];
opt_x_cvec = [];
color_handle = @color_corr;
%bins = [-1,1];
%yval = 4;

var_dep = 'E';

%vars_ind = {'F','P','F0','T','m','Hs','xiU'};
%vars_req = {'lon','lat', ...
%            'Cor_EF','Cor_EP','Cor_EF0', ...
%            'Cor_ET','Cor_Em','Cor_EHs','Cor_ExiU'};

vars_ind = {'F','F0','m','T'};
vars_req = {'lon','lat', ...
            'Cor_EF','Cor_EF0','Cor_Em','Cor_ET'};

opt_corlag = 0;
comp_cmd = 'corr_depind';
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
