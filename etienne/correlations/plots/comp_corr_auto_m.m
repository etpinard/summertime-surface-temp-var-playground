% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_corr_auto_m.m
%
% --> plot_comp_datasets.m <--
%
% Summertime auto-correlations of m.
%
% ======================================================================

% plot_4panels required fields, for all plots!

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
%opt_overlay = 2;
units = '[-]';

cvec = [-1:0.2:1];
opt_x_cvec = 'none';
color_handle = @color_corr;

opt_corlag = 0;

vars_req = {'lon','lat','Corlag_m'}; ...
comp_cmd = [ ...
  '[j1,Corlag_m] = corr_autolag(mm,sig_m,''sqz1'');' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------
