% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compobs_sigP.m
%
% --> plot_compobs_datasets.m <--
%
% Summertime P std for all data set and observations.
%
% ======================================================================


% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[mm day-1]';

cvec = [0:0.5:3]; 
opt_x_cvec = 'above';
color_handle = @color_Var;
bins = [-0.1:0.05:5];
yval = 1.5;

vars_req = {'lon','lat','sig_P'};

comp_cmd = [ ...
  'sig_P = sqrt(sqmean(Var_P))*secinday;' ...
  ];

obs_cmd = [ ...
  'get_obs_P;' ...
  'obs_sig_P = sqrt(sqmean(Var_Pob))*secinday;' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_compobs_datasets;
% ----------------------------------------------------------------------
