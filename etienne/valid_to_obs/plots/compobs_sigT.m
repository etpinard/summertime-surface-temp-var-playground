% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compobs_sigT.m
%
% --> plot_compobs_datasets.m <--
%
% Summertime T std for all data set and observations.
%
% ======================================================================


% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[K]';

%cvec = [0:0.25:3]; 
cvec = [0:0.5:3]; 
opt_x_cvec = 'above';
color_handle = @color_Var;
bins = [-0.1:0.1:5];
yval = 1;

vars_req = {'lon','lat','sig_T'};

comp_cmd = [ ...
  'sig_T = sqrt(sqmean(Var_T));' ...
  ];

obs_cmd = [ ...
  'get_obs_T;' ...
  'obs_sig_T = sqrt(sqmean(Var_Tob));' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_compobs_datasets;
% ----------------------------------------------------------------------
