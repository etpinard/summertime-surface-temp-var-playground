% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_corr_auto_detrend.m
%
% --> plot_comp_datasets.m <--
%
% Summertime auto-correlations in the land-surface system
%   with detrended time series!
%
% ======================================================================

% plot_4panels 

clear name_add
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [-1:0.2:1];
opt_x_cvec = 'none';
color_handle = @color_corr;
%bins = [-1,1];
%yval = 4;

vars_req = {'lon','lat','Corlag_F_detrend'}; ...
comp_cmd = [ ...
  '[j1,Corlag_F] = corr_autolag(FF,sig_F,''sqz1'');' ...
  'FF_dtr = dtrnd(FF);' ...
  'Var_F_dtr = anomaly_Var(FF_dtr);' ...
  '[j1,Corlag_F_detrend] = ' ...
    'corr_autolag(FF_dtr,sqrt(Var_F_dtr),''sqz1'');' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
