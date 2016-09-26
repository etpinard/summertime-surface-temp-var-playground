% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_bowen.m
%
% --> plot_comp_datasets.m <--
%
% Comparison of the summer mean Bowen ratio and anomaly Bowen ratio
% in the 4 datasets.
%
% ======================================================================

%name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;

cvec = [0.0,0.1,0.25,0.5,0.8,1,1.25,2,4,10];   
opt_x_cvec = 'above';
color_handle = @color_scale;
units = '[-]';

vars_req = {'lon','lat', ...
            'bowen_mean','bowen_anom'};

comp_cmd = [ ...
  'bowen_mean = sqmean(abs(Hsbar./(L*Ebar)));' ...
  'bowen_anom = sqmean(abs(sig_Hs.^2./(L^2*sig_E.^2)));' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
