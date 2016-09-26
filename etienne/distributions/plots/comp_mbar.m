% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_mbar.m
%
% --> plot_comp_datasets.m <--
%
% Summertime mean soil moisture content in top 10 cm.
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

% name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[mm]';

cvec = [0:5:40]; 
opt_x_cvec = 'above';
color_handle = @color_mydusk;
bins = [0:0.5:50]; 
yval = 0.1;

vars_req = {'lon','lat','mbar'};
comp_cmd = '';
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
