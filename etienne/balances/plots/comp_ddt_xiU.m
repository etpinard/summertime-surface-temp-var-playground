% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_ddt_xiU.m
%
% --> plot_comp_datasets.m <--
%
% How important is the time derivative inside xiU'
%
% ======================================================================

%% Define constants

%C_p = 1.02e7;  % C_p of the whole troposphere
C_p = 1.02e6;  % 1/10 of the C_p of the whole troposphere
%C_p = 1.02e5;  % 1/100 of ""
% ----------------------------------------------------------------------

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [0,0.01,0.1,0.2:0.2:0.6]; 
opt_x_cvec = 'above';
color_handle = @color_small;

vars_req = {'lon','lat','scale_ddt_xiU'};
comp_cmd = [ ...
  'tmp = ddt(C_p*TT);' ...
  'den = sqmean(Var_xiU);' ...
  'scale_ddt_xiU = sqmean(tmp.*tmp)./den;' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

