% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_corr_m.m
%
% --> plot_comp_datasets.m <--
%
% Summertime correlations involving m.
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

%cvec = [-1:0.2:-0.4,0,0.4:0.2:1]; 
cvec = [-1:0.2:1];
opt_x_cvec = [];
color_handle = @color_corr;
%bins = [-1,1];
%yval = 4;

var_dep = 'm';

%vars_ind = {'F','P','F0','Hs','xiU','xim','R'};   % (E,m) & (T,m) done 
%vars_req = {'lon','lat', ...                %  in comp_E.m and comp_T.m
%            'Cor_mF','Cor_mP','Cor_mF0', ...
%            'Cor_mHs','Cor_mxiU','Cor_mxim','Cor_mR'};

vars_ind = {'Hs'};   % (E,m) & (T,m) done 
vars_req = {'lon','lat', ...                %  in comp_E.m and comp_T.m
            'Cor_mHs'};

opt_corlag = 0;
comp_cmd = 'corr_depind';
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
