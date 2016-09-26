% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compobs_Tbar.m
%
% --> plot_compobs_datasets.m <--
%
% Summertime mean T for all data set and observations.
%
% ======================================================================


% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[deg C]';

%cvec = [0:2:30]; 
cvec = [0,10,15:5:30]; 
%cvec = [0:5:30]; 
opt_x_cvec = 'add_both';
color_handle = @color_myhot;
bins = [-10:0.5:40]; 
yval = 0.1;

vars_req = {'lon','lat','Tbar'};

comp_cmd = [ ...
  'Tbar = sqmean(Tbar)-273.15;' ...
  ];

obs_cmd = [ ...
  'get_obs_T;' ...
  'obs_Tbar = sqmean(Tobbar)-273.15;' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_compobs_datasets;
% ----------------------------------------------------------------------
