% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_ddt_xim.m
%
% --> plot_comp_datasets.m <--
%
% How important is the time derivative inside xim'
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

vars_req = {'lon','lat','scale_ddt_xim'};
comp_cmd = [ ...
  'tmp = ddt(mm);' ...
  'den = sqmean(Var_xim);' ...
  'scale_ddt_xim = sqmean(tmp.*tmp)./den;' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

