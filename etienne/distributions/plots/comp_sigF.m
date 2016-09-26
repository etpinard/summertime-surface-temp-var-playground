% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_sigF.m
%
% --> plot_comp_datasets.m <--
%
% Compare GCM and reanalysis surface energy forcing functions.
%
% Output plots of sig_F and sig_F0.
%
% For Var(P), refer to valid_to_obs/compobs_sigP.m
%
% ======================================================================

%name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[Wm-2]';

cvec = [0:5:30];
opt_x_cvec = 'above';
color_handle = @color_Var;
bins = [0:0.5:50];
yval = 0.2;

vars_req = {'lon','lat', ...
            'sigF','sigF0'};
comp_cmd = [ ...
  'sigF = sqrt(sqmean(sig_F.^2));' ...
  'sigF0 = sqrt(sqmean(sig_F0.^2));' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

