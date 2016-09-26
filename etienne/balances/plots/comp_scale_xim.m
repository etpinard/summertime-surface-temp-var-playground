% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_scale_xim.m
%
% --> plot_comp_datasets.m <--
%
% xim' compared to P'
%
% ======================================================================

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [0,0.2:0.2:1]; 
opt_x_cvec = 'above';
color_handle = @color_small;

vars_req = {'lon','lat','scale_xim_P'};
comp_cmd = [ ...
  'scale_xim_P = sqrt(Var_xim./Var_P);' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
