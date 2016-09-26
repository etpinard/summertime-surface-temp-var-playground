% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_soil_mois_budget_res.m
%
% --> plot_comp_datasets.m <--
%
% Soil moisture budget residual, both (bar) and (anomaly).
%
% ======================================================================

% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[mm day-1]';   

% 1) 'ximbar'
cvec = [-5:1:5]; 
opt_x_cvec = 'add_both';
color_handle = @color_corr;
%bins = [-5:0.1:5]; 
%yval = 1;

vars_req = {'lon','lat','ximbar'};
comp_cmd = ['ximbar = sqmean(Pbar - Ebar - Rbar)*secinday;'];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

break

% 2) 'sig_xim' (must change cvec, bins, etc.)
cvec = [0:0.2:2.4];
opt_x_cvec = 'above';
color_handle = [];
bins = [-0.1:0.05:4];
yval = 1.5;

vars_req = {'lon','lat','sig_xim'};
comp_cmd = ['sig_xim = sqrt(sqmean(Var_xim))*secinday;'];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

%%% *** Maybe plot sig_xim / sig_P ??



