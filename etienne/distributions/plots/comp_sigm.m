% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_sigm.m
%
% --> plot_comp_datasets.m <--
%
% Compare GCM and reanalysis surface energy forcing functions.
%
% Output plots of sig_m
%
% For Var(T), refer to valid_to_obs/compobs_sigT.m
%
% ======================================================================

%name_add = '';
%out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[mm]';

cvec = [0:1:6];
opt_x_cvec = 'above';
color_handle = @color_Var;
bins = [0,10];
yval = 0.2;

vars_req = {'lon','lat','sig_m'};
comp_cmd = [ ...
  'sig_m = sqrt(sqmean(sig_m.^2));' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

