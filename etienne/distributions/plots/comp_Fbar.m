% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_Fbar.m
%
% --> plot_comp_datasets.m <--
%
% Compare GCM and reanalysis mean surface energy forcing.
%
% For Pbar, refer to valid_to_obs/compobs_Pbar.m
%
% ======================================================================

%name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[Wm-2]';

cvec = [450:50:600]; 
opt_x_cvec = 'add_both';
color_handle = @color_myhot2;
bins = [250:5:700];
yval = 0.01;

vars_req = {'lon','lat','Fbar'};
comp_cmd = [ '' ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

