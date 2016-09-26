% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_sfc_engy_budget_res.m
%
% --> plot_comp_datasets.m <--
%
% Surface energy budget residual, both (bar) and (anomaly).
%
% ======================================================================

% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[Wm-2]';

% 1) 'xiUbar'
cvec = [0:5:25]; 
opt_x_cvec = 'add_both';
color_handle = @color_myhot;
%bins = [-5:1:50];
%yval = 0.15;

vars_req = {'lon','lat','xiUbar'};
comp_cmd = ['xiUbar = ' ...
            'sqmean(Fbar - L*Ebar - Hsbar - Flubar);'];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

break

% 2) 'sig_xiU' (must change cvec, bins, etc.)
cvec = [0:0.5:8]; 
opt_x_cvec = 'above';
color_handle = [];
bins = [-0.1:0.1:10]; 
yval = 1;

vars_req = {'lon','lat','sig_xiU'};
comp_cmd = ['sig_xiU = sqrt(sqmean(Var_xiU));'];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

%%% *** Maybe plot sig_xiU / sig_F ??




