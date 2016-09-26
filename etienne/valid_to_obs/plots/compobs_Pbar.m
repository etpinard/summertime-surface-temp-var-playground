% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compobs_Pbar.m
%
% --> plot_compobs_datasets.m <--
%
% Summertime mean P for all data set and observations.
%
% ======================================================================


% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[mm day-1]';

cvec = [0,1,2,3,4,5,10]; 
opt_x_cvec = 'above';
color_handle = @color_myearth;
bins = [-0.1:0.1:30];
yval = 1.5;

vars_req = {'lon','lat','Pbar'};

comp_cmd = [ ...
  'Pbar = sqmean(Pbar)*secinday;' ...
  ];

obs_cmd = [ ...
  'get_obs_P;' ...
  'obs_Pbar = sqmean(Pobbar)*secinday;' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_compobs_datasets;
% ----------------------------------------------------------------------
