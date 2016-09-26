% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_scale_xiU.m
%
% --> plot_comp_datasets.m <--
%
% xiU' compared to F'
%
% ======================================================================

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [0,0.01,0.1,0.2:0.2:0.6]; 
opt_x_cvec = 'above';
color_handle = @color_small;

vars_req = {'lon','lat','scale_xiU_F'};
comp_cmd = [ ...
  'scale_xiU_F = sqrt(Var_xiU./Var_F);' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
