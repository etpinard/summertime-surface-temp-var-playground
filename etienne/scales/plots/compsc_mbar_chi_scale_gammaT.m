% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compsc_mbar_chi_scale_gammaT.m
%
% --> plot_compsc_datasets.m <--
%
% color-coded scatter plots of 'mbar' in ('chi','scale_gammaT') space
%
% ======================================================================

name_add = 'chi_scale_gammaT';
%name_add = 'chi_scale_gammaT-rev';
%name_add = 'chi_scale_gammaT_lt20';
%name_add = 'chi_scale_gammaT_ge20';

out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;

cvec = [0:5:40]; 
units = '[mm]';
opt_x_cvec = 'above';
color_handle = @color_mydusk;

vars_req = {'chi','scale_gammaT','mbar'};

vars_req = {'chi','scale_gammaT','mbar'};

comp_cmd = [ ...
'gamma = [];' ...
'Var_F = sig_F.^2;' ...
'Var_T = sig_T.^2;' ...
'mbar = sqmean(mbar);' ...
'tm_param_full;' ...
'chi = sqmean(chi);' ...
'scale_gammaT = sqmean(gamma.^2.*Var_T./Var_F);' ...
];

%'good = find(mbar >= 20);' ...
%'mbar = mbar(good);' ...
%'chi = chi(good);' ...
%'scale_gammaT = scale_gammaT(good);' ...
% ----------------------------------------------------------------------

%% Call plot_compsc_datasets.m
plot_compsc_datasets;
% ----------------------------------------------------------------------
