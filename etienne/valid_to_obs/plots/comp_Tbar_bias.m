% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_Tbar_bias.m
%
% --> plot_comp_datasets.m <--
%
% Summertime Tbar bias ratio w.r.t U. of Delaware observations.
%
% ======================================================================

% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[K]';

cvec = [-5:1:5];
opt_x_cvec = 'add_both';
color_handle = @color_corr;

vars_req = {'lon','lat','Tbar_bias'};
comp_cmd = [ ...
  'get_obs_T;' ...
  'Tbar_bias = Tbar-Tobbar;' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
