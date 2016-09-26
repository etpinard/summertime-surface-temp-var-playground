% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_scale_E_P.m
%
% --> plot_comp_datasets.m <--
%
% Comparison of the ratio of E to P, mean and anom.
%
% ======================================================================

%name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [0.0,0.1,0.25,0.5,0.8,1,1.25,2,4,10];   
opt_x_cvec = 'add_above';
color_handle = @color_scale;

vars_req = {'lon','lat', ...
            'scale_E_P_mean','scale_E_P_anom'};

comp_cmd = [ ...
  'scale_E_P_mean = sqmean(abs(Ebar./(Pbar)));' ...
  'scale_E_P_anom = sqmean(abs(sig_E.^2./(sig_P.^2)));' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
